local api = vim.api
local pane_index = nil
local last_command = nil

local function escape(str)
  return api.nvim_call_function('shellescape', { str })
end

local function send_keys(keys)
  api.nvim_call_function('system', {
    'tmux send-keys -t ' .. pane_index .. ' ' .. keys
  })
end

local function get_input(prompt)
  api.nvim_call_function('inputsave', {})
  local input = api.nvim_call_function('input', { prompt })
  api.nvim_call_function('inputrestore', {})
  return input
end

local function find_pane()
  if pane_index then return true end

  local panes = api.nvim_call_function('systemlist', {
    'tmux list-panes'
  })

  for _, pane in ipairs(panes) do
    if string.find(pane, "(active)") == nil then
      pane_index = string.gsub(pane, ":.*", "")
      return true
    end
  end

  api.nvim_err_writeln("No tmux pane detected")
  return false
end

local function run_in_terminal(cmd)
  if find_pane() then
    last_command = cmd

    send_keys(escape(cmd))
    send_keys('Enter')
  end
end

local function run_last_command()
  if not last_command then
    api.nvim_err_writeln('No last command to run')
    return
  end

  run_in_terminal(last_command)
end

local filetype_runners = {
  javascript = function(bufname)
    run_in_terminal('node ' .. bufname)
  end,

  lua = function(bufname)
    api.nvim_command('luafile ' .. bufname)
  end,

  ruby = function(bufname)
    run_in_terminal('ruby ' .. bufname)
  end,

  python = function(bufname)
    run_in_terminal('python ' .. bufname)
  end,

  sh = function(bufname)
    run_in_terminal(bufname)
  end,
}

local function run_command()
  local cmd = get_input('command: ')

  if #cmd > 0 then
    run_in_terminal(cmd)
  end
end

local function run_current_buffer()
  local filetype = api.nvim_buf_get_option(0, 'filetype')
  local runner = filetype_runners[filetype]

  if not runner then
    api.nvim_err_writeln('No runner for filetype: ' .. filetype)
    return
  end

  local buffer_name = api.nvim_buf_get_name(0)

  runner(buffer_name)
end

return {
  run_command = run_command,
  run_current_buffer = run_current_buffer,
  run_last_command = run_last_command,
}

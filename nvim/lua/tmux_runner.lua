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

  -- 4
  -- 464
  -- 2340-5-043

  api.nvim_err_writeln("No tmux pane detected")
  return false
end

local function run_command(cmd)
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

  run_command(last_command)
end

local filetype_runners = {
  javascript = function(bufname)
    run_command('node ' .. bufname)
  end,
  ruby = function(bufname)
    run_command('ruby ' .. bufname)
  end,
}

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

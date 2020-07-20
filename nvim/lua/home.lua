local api = vim.api

local files_to_display = 10

local function add_binding(key, cmd)
  api.nvim_buf_set_keymap(0, 'n', tostring(key), cmd, {})
end

local function nvim_version()
  return api.nvim_call_function('systemlist', { 'nvim -v' })[1]
end

local function trim_file_path(path)
  return api.nvim_call_function('fnamemodify', { path, ':~:.' })
end

local function get_cwd()
  return api.nvim_call_function('getcwd', {})
end

local function starts_with(str, start)
   return str:sub(1, #start) == start
end

local function collect_recent_files()
  local files = {}
  local cwd = get_cwd()

  api.nvim_command('rviminfo!')

  for i, file in ipairs(api.nvim_get_vvar('oldfiles')) do
    if starts_with(file, cwd) then
      if #files >= files_to_display then
        break
      end

      table.insert(files, trim_file_path(file))
    end
  end

  return files
end

local function center_line(text, left_margin, width)
  return string.rep(' ', left_margin) .. text .. string.rep(' ', width - #text - 1)
end

local function draw()
  local lines = {
    'welcome! 👋',
    '',
    'info:',
    '  version: ' .. nvim_version(),
    '',
    'shortcuts:',
    '  [space] show available commands',
    '  [e]     new empty buffer',
    '  [q]     quit',
    '',
    'recent files in directory:',
  }

  local max_line_length = 0

  for i, file in ipairs(collect_recent_files()) do
    local binding = i - 1
    local line = '  [' .. binding .. '] ' .. file

    max_line_length = math.max(max_line_length, #line)

    table.insert(lines, line)
    add_binding(binding, ':edit ' .. file .. '<CR>')
  end

  local height = api.nvim_win_get_height(0)
  local width = api.nvim_win_get_width(0)
  local left_margin = math.floor(width / 2) - math.floor(max_line_length / 2)
  local top_margin = math.floor(height / 2) - math.floor(#lines / 2)

  local formatted_lines = { }

  for i=0, top_margin do
    table.insert(formatted_lines, '')
  end

  for _, line in ipairs(lines) do
    table.insert(formatted_lines, center_line(line, left_margin, max_line_length))
  end

  api.nvim_buf_set_lines(0, 0, -1, true, formatted_lines)
end

local function highlight()
  api.nvim_command('syntax match HomeScreenGroup /^[[:blank:]]\\+[[:alnum:]][[:blank:][:alnum:]_]\\+:/')
  api.nvim_command('syntax match HomeScreenItem /\\[[[:alnum:]]\\+\\]/')

  api.nvim_command('highlight default link HomeScreenGroup Bold')
  api.nvim_command('highlight default link HomeScreenItem Special')
end

local function show_home_screen()
  local argc = api.nvim_call_function('argc', {})
  if argc > 0 then return end

  api.nvim_command('enew')

  api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(0, 'buftype', 'nofile')
  api.nvim_buf_set_option(0, 'filetype', 'homescreen')
  api.nvim_buf_set_option(0, 'buflisted', false)
  api.nvim_buf_set_option(0, 'swapfile', false)
  api.nvim_win_set_option(0, 'cursorcolumn', false)
  api.nvim_win_set_option(0, 'cursorline', false)
  api.nvim_win_set_option(0, 'list', false)
  api.nvim_win_set_option(0, 'number', false)
  api.nvim_win_set_option(0, 'relativenumber', false)

  draw()

  api.nvim_buf_set_option(0, 'modifiable', false)
  api.nvim_buf_set_option(0, 'modified', false)

  add_binding('q', ':quit<CR>')
  add_binding('e', ':enew<CR>')

  highlight()
end

return {
  show_home_screen = show_home_screen
}

local api = vim.api

local function collect_lines()
  local lines = {
    'Welcome! 👋',
    '',
    'Not sure what to do? Try pressing <space>.',
  }

  return lines
end

local function center_line(text, left_margin, width)
  return string.rep(' ', left_margin) .. text .. string.rep(' ', width - #text - 1)
end

local function draw(lines)
  local max_line_length = 0

  for _, line in ipairs(lines) do
    max_line_length = math.max(max_line_length, #line)
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

local function show_home_screen()
  local argc = api.nvim_call_function('argc', {})
  if argc > 0 then return end

  api.nvim_command('enew')

  api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(0, 'buftype', 'nofile')
  api.nvim_buf_set_option(0, 'filetype', 'homescreen')
  api.nvim_buf_set_option(0, 'buflisted', false)
  api.nvim_buf_set_option(0, 'swapfile', false)

  draw(collect_lines())

  api.nvim_buf_set_option(0, 'modifiable', false)
  api.nvim_buf_set_option(0, 'modified', false)
end

return {
  show_home_screen = show_home_screen
}

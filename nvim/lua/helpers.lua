local api = vim.api

function dump(val)
  print(vim.inspect(val))
end

function highlight_dark(groups)
  api.nvim_command('syntax enable')
  api.nvim_command('highlight clear')
  api.nvim_command('set background=dark')
  api.nvim_command('set t_Co=256')
  api.nvim_command('syntax reset')

  for group, opts in pairs(groups) do
    api.nvim_command('highlight ' .. group
      .. ' guifg=' .. (opts.fg or 'NONE')
      .. ' guibg=' .. (opts.bg or 'NONE')
      .. ' gui=' .. (opts.style or 'NONE'))
  end
end

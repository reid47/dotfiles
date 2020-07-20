scriptencoding utf-8

runtime plugins.vim
runtime general.vim
runtime appearance.vim
runtime languages.vim
runtime utils.vim
runtime bindings.vim

lua << EOF

package.loaded.helpers = nil
require('helpers')

package.loaded.colorscheme_reid = nil
require('colorscheme_reid')

package.loaded.tmux_runner = nil
tmux = require('tmux_runner')

package.loaded.home = nil
home = require('home')

EOF

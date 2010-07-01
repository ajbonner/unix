" enable syntax highlighting
syn on 
"
" " tab options
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" search options
set incsearch " incremental search (search as you type)

" line numbering
set nu 

" auto indent
set ai 

" no wrapping
set nowrap

" setup and show ruler
set columns=80
set ruler

" set color scheme
source $VIMRUNTIME/colors/koehler.vim

" key shortcuts
" line numbering toggle
map gn :set invnu<CR>
map ^T :tabnew<CR>

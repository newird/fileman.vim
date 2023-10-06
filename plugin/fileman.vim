
if exists('g:loaded_fileman') || &cp
  finish
endif
let g:loaded_fileman = 1

function! s:checkRequirements() abort
  let l:unsupported = 0

  if has('nvim')
    let l:unsupported = !has('nvim-0.3.2')
  else
    let l:unsupported = !has('patch-8.0.1630')
  endif

  if l:unsupported == 1
    echohl Error
    echom "filemanager requires at least Vim 8.0.1630 or Neovim 0.3.2, but you're using an older version."
    echom "Please upgrade your (neo)vim."
    echohl None
    return 0 " Indicates requirements not met
  elseif (&rtp !~ 'fzf.vim')
    echohl Error
    echom 'filemanager depends on junegunn/fzf.vim, please install/load that first.'
    echohl None
    return 0 " Indicates requirements not met
  endif

  return 1 " Indicates requirements met
endfunction

if s:checkRequirements() == 0
  finish
endif

command! -bar -bang -nargs=0 RmFile call fileman#UseFZFToRemoveFiles()
command! -bar -bang -nargs=0 CFile call fileman#CreateFile()

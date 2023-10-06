# fileman
Fileman is a Vim/Neovim plugin that helps you create or delete files without leaving Vim. Have you ever encountered a situation where you needed to create a file with multiple directories? You would typically press `:e`, but instead, you receive an error message. To resolve this, you have to exit Vim, execute `mkdir -p dir1/dir2/`, and then reopen Vim. This process is cumbersome and repetitive. Fileman is designed to simplify this workflow.

Additionally, Fileman allows you to choose the base directory using Fzf and then create a file within it.
## install
Fileman relies on the following dependencies:
1. [rip](https://github.com/nivekuil/rip)
2. [fd](https://github.com/sharkdp/fd)
3. [fzf](https://github.com/junegunn/fzf)

Please make sure you have install them before using fileman

for vim-plug
```
Plug 'newird/fileman.vim', { 'name': 'fileman', 'dependencies': ['junegunn/fzf.vim'] }

```
for lazy.nvim
```
  {"newird/fileman.vim" , name = "fileman" ,
	  dependencies = { {'junegunn/fzf.vim'} },
  },
```
## usage 
To remove a file, type `:RmFile`. Fzf will open, allowing you to select the file you want to remove. Press Enter, and the file will be safely deleted using Rip.

To add a new file, type `:CFile`. Fzf will open again, allowing you to choose your base directory. Press Enter, and you will be prompted to enter the rest of the file path. If you want to create a new directory, simply end the path with /, and a new directory will be created. To create a new file, provide the [path/to/]filename, and a new file will be created and opened.


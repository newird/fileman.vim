" Define the function to remove selected files using rip
function! fileman#remove_file(files) 
    " Ensure we're working with a list. If it's a string, split it.
    let l:file_list = a:files
    let l:result = system('rip ./' . shellescape(file_list))
    if l:result != ''
      echo l:result
    endif 
        " If you later wish to enable file removal using rip, uncomment the next line
        " let l:result = system('rip ' . l:fullpath)
endfunction

" Function to use FZF to select and remove files
function! fileman#UseFZFToRemoveFiles()
    call fzf#run({
        \ 'source':  'fd -t f',
        \ 'options': '--prompt="Select files to remove: " ',
        \ 'sink':    function('fileman#remove_file')
        \ })
endfunction


" Define the function to create a directory
function! fileman#create_directory(path)
    " Check if a file with the same name exists
    if filereadable(a:path[:-2])
        echo "Error: A file with the same name already exists!"
        return 0 " 0 indicates false in Vimscript
    endif

    " 'p' flag creates directories recursively
    call mkdir(a:path, "p")
    return 1 " 1 indicates true in Vimscript
endfunction

" Define the function to create a file or directory based on user input
function! fileman#create_file(dir)
    let l:user_input = input("Add " . a:dir )

    " Construct the full path
    let l:full_path = a:dir . "/" . l:user_input

    " If the user's input ends with '/', treat it as a directory
    if l:user_input[-1:] == "/"
        call fileman#create_directory(l:full_path)
    else
        " Treat it as a file path with potential directories

        " Split the path to check directories and the file
        let l:parts = split(l:user_input, "/")
        let l:file_name = remove(l:parts, len(l:parts) - 1)
        let l:dir_path = a:dir . "/" . join(l:parts, "/")

        " Create directories
        if fileman#create_directory(l:dir_path)
            " Create the file
            execute "edit " . l:dir_path . "/" . l:file_name
            write " Create the file by writing to it
        endif
    endif
endfunction

function! fileman#CreateFile()
    call fzf#run({
        \ 'source':  'fd -t d',
        \ 'options': '--prompt="choose path to add: " ',
        \ 'sink':    function('fileman#create_file')
        \ })
endfunction

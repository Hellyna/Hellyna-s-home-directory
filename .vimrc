set nocompatible
syn on
syn sync fromstart
set foldmethod=syntax
set background=dark
set foldenable
"    let javaScript_fold=1
"    let javascript_fold=1
    let perl_fold=1
    let r_syntax_folding=1
    let ruby_fold=1
    let sh_fold_enabled=1
    let vimsyn_folding='af'
    let xml_syntax_folding=1
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
" I always use vim against a black background.
set background=dark

augroup syntax
au! BufNewFile,BufReadPost *.spec
au  BufNewFile,BufReadPost *.spec  so ~/vim/spec.vim
augroup END

" The main changes I make to the colours is make Function a tad brighter so
" it's more readable. Also, I prefer darkcyan for my comments. I don't
" like comments to be "louder" than the actual code.
" THis is a hack of the clour section in
" /usr/local/share/vim/syntax/syntax.vim

if &background == "dark"
  hi Comment	term=bold 		ctermfg=DarkCyan 		guifg=#80a0ff
  hi Constant	term=underline 	ctermfg=Magenta 		guifg=Magenta
  hi Special	term=bold 		ctermfg=DarkMagenta	guifg=Red
  hi Identifier term=underline 	cterm=bold 			ctermfg=Cyan guifg=#40ffff
  hi Statement term=bold 		ctermfg=Yellow gui=bold	guifg=#aa4444
  hi PreProc	term=underline 	ctermfg=LightBlue 	guifg=#ff80ff
  hi Type	term=underline 		ctermfg=LightGreen 	guifg=#60ff60 gui=bold
  hi Function	term=bold		ctermfg=White guifg=LightRed
  hi Repeat	term=underline	ctermfg=White		guifg=LightRed
  hi Operator				ctermfg=Red			guifg=Red
  hi Ignore				ctermfg=black 		guifg=bg
else
  hi Comment	term=bold ctermfg=DarkBlue guifg=Blue
  hi Constant	term=underline ctermfg=DarkRed guifg=Magenta
  hi Special	term=bold ctermfg=DarkMagenta guifg=SlateBlue
  hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
  hi Statement term=bold ctermfg=Brown gui=bold guifg=Brown
  hi PreProc	term=underline ctermfg=DarkMagenta guifg=Purple
  hi Type	term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
  hi Ignore	ctermfg=white guifg=bg
endif
hi Error	term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo	term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Conditional	Statement
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special

let X = getline(1)
let y = match(X, "#!/bin/bash" )
let z = match(X, "#!/bin/sh" )
if (y != -1)
	so ~/.vim/syntax/bash.vim
elseif (z != -1)
	so ~/.vim/syntax/sh.vim
endif
unlet X
unlet y
unlet z
if has("autocmd")
    filetype plugin indent on
endif

" automatically remove trailing whitespace before write
function! StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    if line("'Z") != line(".")
        echo "Stripped whitespace\n"
    endif
    normal `Z
endfunction
autocmd BufWritePre COMMIT_EDITMSG,.vimrc,*.js,*.cpp,*.hpp,*.i,*.h,*.c :call StripTrailingWhitespace()

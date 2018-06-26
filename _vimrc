source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"============================================TODO==========================================
"待分割

" 基本配置
"source ~/.vim_runtime/vimrcs/basic.vim
" 插件目录
"source ~/.vim_runtime/vimrcs/plugins_config.vim
" 某些文件类型的相关配置
"source ~/.vim_runtime/vimrcs/filetypes.vim
" 一些零碎的不好归类的配置
"source ~/.vim_runtime/vimrcs/more_config.vim
"============================================中文乱码设置==========================================

" 配置多语言环境,解决中文乱码问题
if has("multi_byte") 
    " UTF-8 编码 
    set encoding=utf-8 
    set termencoding=utf-8 
    set formatoptions+=mM 
    set fencs=utf-8,gbk 
    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)' 
        set ambiwidth=double 
    endif 
    if has("win32") 
        source $VIMRUNTIME/delmenu.vim 
        source $VIMRUNTIME/menu.vim 
        language messages zh_CN.utf-8 
    endif 
else 
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte" 
endif
 
"============================================vim-plug==========================================

" Specify a directory for plugins   
call plug#begin('~/vimfiles/plugins') 

Plug 'mhinz/vim-startify' 
Plug 'junegunn/vim-easy-align' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' ", {'on':'NERDTreeToggle'}
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Lokaltog/vim-easymotion'
Plug 'Valloric/YouCompleteMe'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'Valloric/ListToggle'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
" 代码检查
if v:version >= 703
    Plug 'w0rp/ale'
else
    Plug 'scrooloose/syntastic'
endif
Plug 'terryma/vim-multiple-cursors'
"主题
Plug 'morhetz/gruvbox'
" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()
"============================================基础配置==========================================
let mapleader = "\<Space>" " leader
set nu!                    " 行号
"set relativenumber        " 相对行号
colorscheme gruvbox        " 主题
set background=dark
syntax enable              " 语法高亮
syntax on                  " 语法高亮
set ruler                  " 右下角显示光标位置
set autoindent             " 自动对齐
set tabstop=4              " Tab键的宽度
set history=50             " 历史纪录数
set showcmd                " 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
set smartindent            " 基于autoindent的一些改进

set tabstop=4              " 编辑时一个TAB字符占多少个空格的位置。
set shiftwidth=4           " 使用每层缩进的空格数。
set expandtab              " 是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
set softtabstop=4          " 方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格

set autochdir              " 自动切换当前目录为当前文件所在的目录

" 在使用vim编辑文件后，总是会有一个以.un~结尾的文件自动生成，看着让人心烦。其实这是vim的undofile和备份文件，可以让你在关闭文件后再次打开时还可以撤销上次的更改如果想使用这个功能的话，但是不想被那些文件烦的话，还可以写入undodir=~/.undodir这样的话，un~文件就会被统一写入~/.undodir里面，不会四处分散了
set noundofile
set nobackup
set noswapfile


set foldmethod=indent      " 允许折叠
set foldlevel=99           " 折叠层级

" 用红色标记多余空白 ctermbg:彩色终端背景色 guifg:GUI前景色
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"set cu                      " set cursorcolumn 光标所在行列颜色
"highlight CursorColumn cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
set cul                      " set cursorline   光标所在行行颜色
"highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE

" 离开 Insert 模式时自动切换至英文输入法
" 还可以指定更高级的用法,指定文件什么的https://boyux.me/2014/02/15/vim-%E4%B8%AD%E8%8B%B1%E6%96%87%E8%BE%93%E5%85%A5%E5%88%87%E6%8D%A2/
set noimdisable



" go是guioptions的缩写
if has("gui_running")
	autocmd GUIEnter * simalt ~x " 窗口启动时自动最大化
	set go-=m                    " 隐藏菜单栏
	set go-=T                    " 隐藏工具栏
	"set go-=L                   " 隐藏左侧滚动条
	"set go-=r                   " 隐藏右侧滚动条
	"set go-=b                   " 隐藏底部滚动条
	"set showtabline=0           " 隐藏Tab栏
endif


" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" 使用 <Space>o 创建一个新文件
nnoremap <Leader>o :CtrlP<CR>

" 使用 <Space>. 切换到当前编辑文件的目录
nnoremap <silent> <leader>. :cd %:p:h<CR>

" Open command prompt by running :Cmd
command Cmd :!start cmd /k cd %:p:h<CR>

" Open windows explorer by running :We
command We :!start Explorer /select,%:p<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" 普通模式和视图模式下tab/s-tab来缩进
nmap <tab>   V>
nmap <s-tab> V<
vmap <tab>   >gv
vmap <s-tab> <gv

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

"使用vim方向键来切换编辑窗口 Ctrl+H/J/K/L
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" F10 创建新标签
:map <F10> <Esc>:tabnew<CR>
"============================================airline setting==========================================
" airline settings {
    let g:airline_theme="badwolf"                       " 可以去官网看有哪些主题, 也可以:help airline-themes-list来查看
    let laststatus = 2
    let g:airline_powerline_fonts = 1                   " 使用powerline打过补丁的字体
    let g:airline#extensions#tabline#enabled = 1        " tabline中当前buffer两端的分隔字符
    let g:airline#extensions#tabline#left_sep = ' '     " tabline中未激活buffer两端的分隔字符
    let g:airline#extensions#tabline#left_alt_sep = '|' " tabline中buffer显示编号
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#whitespace#enabled = 0     " 关闭状态显示空白符号计数,这个对我用处不大
    let g:airline#extensions#whitespace#symbol = '!'
"}

"============================================font setting==========================================
" font settting{
    " 可以通过判断win32,判断是否是gvim,并分别配置英文和中文字体
    " 技巧: gvim里输入  :set guifont=* 可以挑选,然后再输入:set guifont 查看所选中的字体
    " 字体使用的是Nerd Font里Unofficial Arch User Repository (AUR)的Nerd Fonts DejaVu Complete
    " https://aur.archlinux.org/packages/nerd-fonts-dejavu-complete/
    if has('win32')
      set guifont=DejaVuSansMonoForPowerline_Nerd:h12:cANSI:qDRAFT
    endif
    " 字体DejaVu Sans Mono for Powerline，需放在配置文件最后面
" }


"============================================NERDTree==========================================
" NERDTree Settings{
    " open a NERDTree automatically when vim starts up if no files were specified
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " 当打开 NERDTree 窗口时，自动显示 Bookmarks
    let NERDTreeShowBookmarks=1

    "设定 NERDTree 视窗大小
    "let g:NERDTreeWinSize = 25
    "
    " 不显示帮助面板
    let NERDTreeMinimalUI=1

    "change default arrows
    let g:NERDTreeDirArrows           = 1
    let g:NERDTreeDirArrowExpandable  = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let NERDTreeMinimalUI             = 1

    "不显示隐藏文件
    "let g:NERDTreeHidden=0
    "过滤: 所有指定文件和文件夹不显示
    let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']
    " 按下 F2 调出/隐藏 NERDTree, 加%,打开树时进入当前文件所在目录
    map <F2> :silent! NERDTreeToggle %<CR>
"}

"============================================Easy-align==========================================
" Easy-align Settings{
    vmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)
    if !exists('g:easy_align_delimiters')
      let g:easy_align_delimiters = {}
    endif
    let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
" }


"============================================ale==========================================
" ale Settings{
    let g:ale_sign_column_always   = 1      "始终开启标志列
    let g:ale_echo_msg_error_str   = 'E'    "显示Linter名称,出错或警告等相关信息
    let g:ale_echo_msg_warning_str = 'W'
    nmap <Leader>s :ALEToggle<CR>           "<Leader>s触发/关闭语法检查
    nmap <Leader>d :ALEDetail<CR>           "<Leader>d查看错误或警告的详细信
" }


"============================================YCM==========================================
" YCM Settings {
    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
    set completeopt=longest,menu	
    "离开插入模式后自动关闭预览窗口
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif	
    
	"回车即选中当前项 
    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
    nnoremap <silent> <leader>gt :YcmCompleter GoTo<cr>
    nnoremap <silent> <leader>gi :YcmCompleter GoToInclude<cr>
    nnoremap <silent> <leader>gd :YcmCompleter GoToDefinition<cr>
    nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<cr>

    " 修改默认快捷键, a-j 有可能和多光标的冲突 
    let g:ycm_key_list_select_completion = ['<a-j>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<a-k>', '<Up>']

    let g:ycm_global_ycm_extra_conf = "~/vimfiles/plugins/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    " 第二个字符开始补全
    let g:ycm_min_num_of_chars_for_completion = 2 
    "在注释输入中也能补全
    let g:ycm_complete_in_comments = 1
    "在字符串输入中也能补全
    let g:ycm_complete_in_strings = 1
    "注释和字符串中的文字也会被收入补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    " tags文件采集
    let g:ycm_collect_identifiers_from_tags_files = 1 
    " 关键字补全
    let g:ycm_seed_identifiers_with_syntax = 1 
    " 片段补全
    let g:ycm_use_ultisnips_completer = 1 
    " 候选条数, 默认就是50
    let g:ycm_max_num_candidates = 50

"} 


"============================================CompleteParameter==========================================
"CompleteParameter Settings{
    inoremap <silent><expr> ( complete_parameter#pre_complete("()")
    smap <a-l> <Plug>(complete_parameter#goto_next_parameter)
    imap <a-j> <Plug>(complete_parameter#goto_next_parameter)
    smap <a-h> <Plug>(complete_parameter#goto_previous_parameter)
    imap <a-h> <Plug>(complete_parameter#goto_previous_parameter)
"}

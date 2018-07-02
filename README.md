# Desc
My vimrc config file.

# Todo 
分割到不同的配置文件里去

# Compile YCM
>　YCM安装后会有些卡,可选择性安装

* Window
## 1. 先决条件: 
    * VIM和版本要在7.3以上
    * cmake
    * LLVM
    * python 
    * 装有C++开发工具的Visual Studio
## 2. 安装过程:
1) Plug 'Valloric/YouCompleteMe'
2) PlugInstall: 等待安装, 其中弹出窗口后安装 (git submodule会很长时间).
3) 安装完成后, 安装cmake,记得加入环境变量.
4) 本机要安装VS(注意要有C++开发工具)

   * [could not find any instance of Visual Studio, when i run python install.py --clang-completer](https://github.com/Valloric/YouCompleteMe/issues/2945)
    * [VS安装C++工具](https://wenku.baidu.com/view/08b294a733687e21ae45a9db.html)
5) 运行安装命令
```shell
python install.py --clang-completer
```
## 3. 遇到问题:
VS2015安装了C+环境后,还是不可以, 才注意到运行
``` shell
 python install.py --clang-completer
```
后失败的提示是:
```shell
 CMake Error at CMakeLists.txt:26 (project):
  Generator<br>
    Visual Studio 15 2017<br>
    could not find any instance of Visual Studio.
```  
提示VS 2017版本, 而我本机并未安装2017. 这时有两个办法:
1. [手动编译](https://github.com/Valloric/YouCompleteMe#full-installation-guide)

2. [指定版本](https://github.com/Valloric/YouCompleteMe#windows)

最终使用命令:
```shell
python install.py --clang-completer --msvc 14
```

## 注意:
以后每次使用Vim-Plug的 PlugUpdate后,YCM核心代码有更新的话都要重新编译(记得使用如下命令更新子模块)
```shell
git submodule update --init --recursive
```
> Remember: YCM is a plugin with a compiled component. If you update YCM using Vundle and the ycm_core library APIs have changed (happens rarely), YCM will notify you to recompile it. You should then rerun the install process. 
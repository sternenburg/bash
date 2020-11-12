### Git的工作流程
1. 在工作目录中修改文件 **modified**
2. 对这些修改的文件做快照，并保存在暂存区域 **staged**
3. 提交更新，将保存在暂存区域的文件快照存储到git目录中 **committed**

### 安装Git
```sh
$ sudo apt-get install git-core
```
### 初次配置 
```sh
$ git config --global user.name "Lei Wang"
$ git config --global user.email 1357492993@qq.com
$ git config --global core.editor vim
$ git config --list #查看配置信息
$ git config user.name #查看某项配置信息
```
### 取得Git项目仓库（repository）的方法之一：从现存目录创建
```sh
# 首先进入到目录中
$ git init # 初始化
```
### 取得Git项目仓库的方法之二：从现有仓库克隆
```sh
$ git clone git://github.com/sternenburg/bash.git
# 会在当前目录下创建一个名为bash的目录，里面含一个.git的目录
# 如果希望自己定义要新建的项目目录名称，可以这样写
$ git clone git://github.com/sternenburg/bash.git my_bash
```
### 提交更新至仓库
```sh
$ git status #首先可以检查文件状态
$ vim read_integer.sh #修改文件
$ git status # 再次查看状态时，会发现 read_integer.sh 出现在untracked files里
$ git add read_integer.sh #将修改后的文件添加至暂存区
$ git status # 会看到该文件已经被跟踪，并处于暂存状态 staged
$ git diff # 查看当前文件和暂存区域快照之间的差异，也就是修改后还没有暂存的变化内容
$ git diff --staged # 查看已经暂存的文件和上次提交的快照之间的差异
$ git commit # 提交更新，会打开编辑器，第一行用于输入提交说明
$ git commit -m "test" # 使用-m，提交更新的同时输入说明信息
$ git commit -a -m "test" # 使用-a，跳过暂存（git addd）阶段，直接提交
```
### 移除文件
```sh
$ git rm file # 从暂存区域移除，并连带从工作目录中删除
$ git rm --cached file # 从暂存区移除，但仍保存在工作目录中
# 文件改名
$ git mv file_from file_to
# 相当于以下三个命令：
$ mv file_from file_to
$ git rm file_from
$ git add file_to
```
### 查看提交历史
```sh
$ git log -p -2 # -p展开每次提交的内容差异，-2仅显示最近的两次更新
```
### 如何撤销操作
```sh
$ git commit -m '之前的提交'
$ git add forgotten_file
$ git commit --amend
# 之前提交时忘记了暂存某些修改，补上暂存操作后，重新提交
# 所以上面的三条命令最终得到一个提交，第二个提交修改了第一个提交的内容
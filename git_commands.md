[toc]
### Git的gongzuoliucheng
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
### 设置忽略文件（不自动跟踪）
```sh
$ vim .gitignore # 创建一个名为.gitignore文件
 *.a	# 忽略所有.a结尾的文件
 !lib.a # lib.a除外
 /TODO	# 仅仅忽略项目根目录下的TODO文件，不包括subdir/TODO
 build/ # 忽略build目录下的所有文件
 doc/*.txt # 忽略doc/notes.txt，但不包括 doc/server/arch.txt
```

### 取得Git项目仓库 `repository` 的方法之一：从现存目录创建
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
$ git commit -a -m "test" # 使用-a，跳过暂存（git add）阶段，直接提交
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
### 回退到之前的版本
```sh
$ git log # 查看历史记录
$ git log --pretty=oneline  # 精简输出信息
$ git log -p -2 # -p展开每次提交的内容差异，-2仅显示最近的两次更新
$ git reset --hard HEAD^ # 回退到上一个版本 HEAD^^是上上一个版本
# 使用HEAD时，表示是最新的版本

$ git reset --hard 1095a # 回退到一个指定的版本，1095a是commit id，不用写全

# 注意！回到之前版本后，后来新增的版本就看不到了，需要用reflog命令来查找commit id
$ git reflog # 用于记录每一次命令
```
### 如何撤销操作
```sh
$ git commit -m '之前的提交'
$ git add forgotten_file
$ git commit --amend
# 之前提交时忘记了暂存某些修改，补上暂存操作后，重新提交
# 所以上面的三条命令最终得到一个提交，第二个提交修改了第一个提交的内容

# 场景一：当改乱了工作区某个文件的内容，希望直接丢弃工作区的修改
$ git restore file
# 场景二：不但改乱了文件，还添加到了暂存区
$ git reset HEAD file # 回到场景一，然后按场景一操作
# 场景三：commit了文件，向要撤销本次操作
# 参考“回退到之前的版本”这一章
```
### 远程仓库的使用
1. 查看当前远程仓库
```sh
$ git remote -v #显示当前的远程仓库，-v是用来显示对应的克隆地址
# 如果是克隆的某个项目，Git默认用origin标识克隆的原始仓库
$ git remote show origin # 显示远程仓库的详细信息
```
2. 添加远程仓库
```sh
$ git remote add origin git://github.com/sternenburg/work.git #origin为远程仓库的默认叫法

$ git remote rm origin # 移除远程仓库
$ git remote rename origin work # 重命名远程仓库
```
3. 抓取数据及推送数据
```sh
$ git fetch work # 将远端的数据抓取到本地，并不自动合并到当前分支
$ git pull work # 将远端数据抓取到本地，并合并到本地仓库当前分支
$ git push work master # 将本地数据(master 分支）推送到远程仓库

# 如果远程仓库是空的话，第一次推送加上 -u 参数，Git不但会把本地master分支内容推送到远程新的master分支，还会将本地的master分支和远程的master分支关联起来，这样之后的推送和拉取就可以简化命令
```
### 增加标签
```sh
$ git tag # 显示现有标签
$ git tag -a v1.0 -m 'my version 1.0' # -a指定标签名称，-m指定标签说明
$ git push work v1.0 # 默认情况下，git push并不会将标签上传至远端服务器，需显式命令
$ git push work --tags # 一次推送所有本地新增的标签上去
```
### 分支管理
1. 创建分支
```sh
$ git branch dev # 创建分支
$ git checkout -b dev # 创建一个新的分支，并切换到新分支
$ git switch -c dev # 也可以用switch命令

$ git branch # 查看分支
$ git checkout master # 切换到master分支
$ git switch master # 同样，也可以用switch命令
```
2. 合并分支
```sh
$ git merge dev # 把dev分支合并到当前的master分支上
$ git branch -d dev # 删除dev分支

# 当git无法自动合并分支时，就必须首先解决冲突，解决冲突后再提交，就完成了合并
$ git log --graph # 查看分支合并图
```
3. 禁用fast forward模式的merge
通常在合并分支时，如果可能的话，Git会使用`fast forward`的模式，但是删除分支后，会丢失分支信息。可以通过强制禁用`fast forward`的方式，使Git在合并时生成一个新的commit，这样从分支历史就可以看出分支信息。
```sh
$ git merge --no-ff -m "merge with no-ff" dev
```
4. bug分支
工作过程中需要创建临时分支处理bug，但是工作还没进行完，没法提交。就可以用`stash`功能临时“储藏”工作区。
```sh
$ git stash #之后用 git status查看状态，会发现是clean的
$ git stash list # 查看储藏在哪里
$ git stash apply # 恢复
$ git stash drop #删除stash的内容

$ git stash pop # 恢复的同时删除，相当于上面的apply和drop两条命令
```
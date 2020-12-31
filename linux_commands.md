### SHELL 快捷键
- `ctrl + a` 移动到行首
- `ctrl + e` 移动到行尾
- `ctrl + k` 剪切从光标到行尾
- `ctrl + u` 剪切从光标到行首
- `ctrl + y` 将剪切内容粘贴到光标位置
- `ctrl + d` 删除光标处字符
- `alt + l`   从光标到字尾字符转换为小写字符
- `alt + u`   从光标到字尾字符转换为大写字符

### ln
创建链接——硬链接/符号链接

- **硬链接**无法引用目录，而且无法引用其他磁盘分区的文件
- **符号链接** 被创建时，需要指定相对位置或者绝对位置
- `rm`命令删除链接的时候，删除的是链接文件，目标文件本身还被保存。

```bash
$ ln fun fun-sys # 创建文件fun的硬链接
$ ln -s fun fun-sys #符号链接
$ ln -s ../fun dir1/fun-sys #描述目标文件与符号链接的相对位置关系
$ ln -s /home/lei/playground/fun dir1/fun-sys #描述目标文件的绝对位置
```

### type / which / apropos / whatis

- `type` 显示命令的类型
- `which` 显示命令的位置
- `man` 显示命令的使用手册
- `apropos` 显示合适的命令
- `whatis` 显示命令的简要描述

### alias
创造命令的别名
```bash
$ alias foo='cd /usr; ls; cd -'
$ alias # 查看定义的所有别名
$ unalias foo # 删除别名
```

### > and >>
重定向操作符。后面接文件名，就可以把标准输出重定向到文件内容中去
`>` 和 `>>` 区别是后者将内容添加到文件尾部

一个程序可以把生成的输出内容发送到任意文件流中去，shell用0,1,2分别对应标准输入文件，标准输出文件，标准错误文件。

```bash
$ ls -l /bin/usr 2> ls-error.txt  #将错误信息发送到ls-error.txt文件中
$ ls -l /bin/usr &> ls-output.txt #将标准输出和标准错误都重定向至ls-output.txt文件中
$ ls -l /bin/usr 2> /dev/null #将标准错误定向到/dev/null这个文件中，实际上就是抛弃这个错误信息,不作任何处理
```
### cat
合并文件
```bash
$ cat ls-output.txt # 显示文件内容
$ cat movie.mpeg.0* > movie.mpeg #将多个文件movie.mpeg.01 movie.mpeg.02 等重新连接到一起，生成一个新的文件 movie.mpeg
$ cat > foo.txt # 将接收的屏幕输入保存在foo.txt文件中，以文件结束符 ctrl+d 结束。
```
### 管道命令
| 管道命令可以把一个命令的标准输出（stdout）传送到另一个命令的标准输入（stdin）

```bash
$ ls /bin /usr/bin | sort | less
```
- `uniq`  删除重复行，或者查看重复行 （`-d`参数）

- `wc`  打印行数(`-l`参数)、字数(`-m`参数)和字节数(`-c` 参数)

- `grep`  打印匹配行。可用正则表达式进行匹配

```bash
$ ls /bin /user/bin | sort | uniq | grep zip
# 搜索文件名包含zip的所有文件
# -i 忽略大小写
# -v 输出和patter不匹配的行
```
- `head/tail` 打印文件开头/结尾部分

- `tee`  从stdin读取数据，同时输出至stdout和文件。当在某个中间处理阶段捕获一个管道内容时会很有用

### Shell
- 算数扩展  `$((expression))`， 例如： `$(( 1+2 ))` 。 空格在算数表达式中是没有意义的，子表达式可用括号来组合，例如  `$(( (5*2) * 3 ))`

- 花括号扩展用于创建多种文本字符串，例如： `$ echo Front-{A, B, C}-Back`,  ` $ echo {Z..A}`， ` $ echo a{A{1, 2}, B{3, 4}}b`
  ```bash
  $ mkdir {2009..2011}-0{1..9} {2009..2011}-{10..12}
  # 创建 2009-01 2009-02 ... 2011-12 等文件夹
  ```

- 命令替换，用于把一个命令的输出作为另外一个命令的输入参数
  ```bash
  $ ls -l $(which cp)
  $ file $(ls /usr/bin/* | grep zip)
  ```
  
- 常用的转义字符
  - -a 响铃
  - -n 新的一行
  - -r 回车
  - -t 制表符
  
- 配置文件 **`~/.bashrc`**
  用户私有的启动文件。可以用来扩展或重写全局配置脚本中的设置。

  激活修改： `$ source ~/.bashrc`

  

### 权限
```bash
$ chmod 755 example.sh #更改文件权限为可执行
# 常用 7(rwx), 6(rw-), 5(r-x), 4(r--), 0(---)
```

命令符号表示
- `u` user,所有者
- `g` group，文件所属组
- `o` others，其他所有用户
- `a` all，以上三者组合

```bash
$ chmod a+x example.sh #给所有用户增加执行的权限
```

`umask`:用于设置默认权限，表示从原始文件模式属性中删除一个掩码值
例如`umask`值为0002（8进制），用二进制表示010，则1对应的属性w被取消

**使用权限的例子**

```bash
$ # 需要实现两个用户在一个共享目录下，各自存储、修改彼此的文件
$ sudo groupadd -g 2001 group_music # 创建一个新组，组的gid为2001
$ sudo gpasswd -a bei group_music # 把用户加入到新组里 -d是移除用户
$ sudo gpasswd -a lei group_music
$ cat /etc/group | grep group_music # 查看组的成员
$ sudo mkdir /usr/local/share/dir_music # 创建一个共享目录
$ sudo chown :group_music /usr/local/share/dir_music # 将目录用户组由root更改为group_music
$ # 现在用户（lei）在目录下创建的文件，默认仍然是用户的主要组（lei），而不是group_music，通过设置目录的setgid来更改
$ sudo chmod g+s /usr/local/share/dir_music # 目录中新创建的文件 具有这个目录用户组(group_music)的所有权，而不是文件创建者（lei）所属用户组（lei）的所有权
```
### 进程

- `ps` – 报告当前进程快照

- `top` – 显示任务
```bash
$ top | grep firefox # 和grep命令相结合，查找进程PID
```
- `jobs` – 列出活跃的任务

- `bg` – 把一个任务放到后台执行
```bash
$ bg %1 #把job id为1的进程放进后台执行
$ code & # 打开code程序，后台执行
```
- `fg` – 把一个任务放到前台执行

- `kill` – 给一个进程发送信号
```bash
$ kill 2350 # 用PID终止进程
$ kill %1 # 用job id终止程序
```

### 挂载和卸载存储介质
**设备命名的模式**
```bash
$ ls /dev # 列出所有设备
```
- `/dev/fd*` 软盘驱动器
- `/dev/hd*` 老式的IDE磁盘
- `/dev/lp*` 打印机
- `/dev/sd*` SATA硬盘，闪存，USB存储设备等
- `/dev/sr*` 光盘
挂载和卸载的步骤(以U盘为例)
1. 确定设备名称，可以查看 `\dev`下的文件
2. 创建挂载节点，节点仅仅是文件系统的某个目录
```bash
$ sudo mkdir /mnt/flash
```
3. 挂载设备
```bash
$ sudo mount /dev/sdb1 /mnt/flash
```
4. 卸载设备
```bash
$ sudo umount /dev/sdb1
```




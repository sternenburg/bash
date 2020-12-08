#### shell 快捷键
- `ctrl + a` 移动到行首
- `ctrl + e` 移动到行尾
- `ctrl + k` 剪切从光标到行尾
- `ctrl + u` 剪切从光标到行首
- `ctrl + y` 将剪切内容粘贴到光标位置
- `ctrl + d` 删除光标处字符
- `alt + l`   从光标到字尾字符转换为小写字符
- `alt + u`   从光标到字尾字符转换为大写字符

#### ln
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

#### type / which / apropos / whatis

- `type` 显示命令的类型
- `which` 显示命令的位置
- `man` 显示命令的使用手册
- `apropos` 显示合适的命令
- `whatis` 显示命令的简要描述

#### alias
创造命令的别名
```bash
$ alias foo='cd /usr; ls; cd -'
$ alias # 查看定义的所有别名
$ unalias foo # 删除别名
```

#### > / >>
重定向操作符。后面接文件名，就可以把标准输出重定向到文件内容中去
`>` 和 `>>` 区别是后者将内容添加到文件尾部

一个程序可以把生成的输出内容发送到任意文件流中去，shell用0,1,2分别对应标准输入文件，标准输出文件，标准错误文件。

```bash
$ ls -l /bin/usr 2> ls-error.txt  #将错误信息发送到ls-error.txt文件中
$ ls -l /bin/usr &> ls-output.txt #将标准输出和标准错误都重定向至ls-output.txt文件中
$ ls -l /bin/usr 2> /dev/null #将标准错误定向到/dev/null这个文件中，实际上就是抛弃这个错误信息,不作任何处理
```
#### cat
合并文件
```bash
$ cat ls-output.txt # 显示文件内容
$ cat movie.mpeg.0* > movie.mpeg #将多个文件movie.mpeg.01 movie.mpeg.02 等重新连接到一起，生成一个新的文件 movie.mpeg
$ cat > foo.txt # 将接收的屏幕输入保存在foo.txt文件中，以文件结束符 ctrl+d 结束。
```
#### 管道命令
| 管道命令可以把一个命令的标准输出（stdout）传送到另一个命令的标准输入（stdin）

```bash
$ ls /bin /usr/bin | sort | less
```
- `uniq`  删除重复行，或者查看重复行 （`-d`参数）
- `wc`  打印行数(`-l`参数)、字数(`-m`参数)和字节数(`-c` 参数)
- `grep`  打印匹配行
- `head/tail` 打印文件开头/结尾部分
- `tee`  从stdin读取数据，同时输出至stdout和文件。当在某个中间处理阶段捕获一个管道内容时会很有用

#### shell
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
  


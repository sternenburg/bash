[toc]
### SHELL 快捷键
- `ctrl + a` 移动到行首
- `ctrl + e` 移动到行尾
- `ctrl + k` 剪切从光标到行尾
- `ctrl + u` 剪切从光标到行首
- `ctrl + y` 将剪切内容粘贴到光标位置
- `ctrl + d` 删除光标处字符
- `alt + l`   从光标到字尾字符转换为小写字符
- `alt + u`   从光标到字尾字符转换为大写字符

### 基础命令
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

#### > and >>
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

- 花括号扩展用于创建多种文本字符串，例如： `$ echo Front-{A, B, C}-Back`,  ` $ echo {Z..A}`， `$ echo a{A{1, 2}, B{3, 4}}b`
```bash
  $ mkdir {2009..2011}-0{1..9} {2009..2011}-{10..12}
  $ # 创建 2009-01 2009-02 ... 2011-12 等文件夹
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
```bash
$ source ~/.bashrc # 更改后，启用设置
```

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
1. **确定设备名称**，可以查看 `\dev`下的文件
2. **创建挂载节点**，节点仅仅是文件系统的某个目录
```bash
$ sudo mkdir /mnt/flash
```
3. **挂载设备**
```bash
$ sudo mount /dev/sdb1 /mnt/flash
```
4. **卸载设备**
```bash
$ sudo umount /dev/sdb1
```
### 安装软件
1. 从资源库安装软件包
```bash
$ sudo agt-get update
$ sudo apt-get install package_name
```
2. 下载软件包，安装软件
```bash
$ sudo dpkg --intall package_file
```
3. 编译程序
- 获取源代码解压缩
```bash
$ tar xzf diction-1.11.tar.gz
```
- 生成程序
```bash
$ ./configure # 分析生成环境，检查并配置build程序。创建Makefile文件（指导make命令如何生成可执行程序的配置文件）
$ make # 生成程序。坚持的原则：目标文件要比依赖文件新
```
- 安装程序
```bash
$ sudo make install # 使用超级用户权限安装程序。通常会安装在/usr/local/bin目录下
```

### 网络系统
`traceroute`: 查看从本地到主机，需要经过的路由器
`netstat -ie`: 查看系统中的网络接口
`netstat -r`: 显示内核的网络路由表
`ftp`: 从ftp server传输文件
`wget`: 从网站或者ftp server传输文件
`ssh`: Secure Shell 与远程主机安全通信
```bash
$ # 没有远端系统，可以安装openssh-server软件包，将本地主机作为远端主机名
$ sudo apt-get install openssh-server
$ ssh localhost # 和自身建立网络连接
```
### 查找文件
- `locate`: 通过名字查找路径名与指定字符串相符的文件
```bash
$ locate bin/zip # 查找名称以zip开头的程序。因为是程序文件，所以路径名以bin/结尾
$ locate zip | grep bin # 结合grep命令使用
```
- `find`: 在目录层次结构中查找文件。`locate`仅仅是依据文件名，`find`是依据文件的属性在指定目录查找
```bash
$ find ~ -type d | wc -l # 在 ~ 目录下查找目录文件，然后用 wc 命令统计数量 （d 目录；f 普通文件；l 符号链接）
$ find ~ -type f -name "*.JPG" -size +1M | wc -l
# 统计大小超过1MB的JPG文件数量

$ find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)
# 查找访问权限不是0600的文件，和访问权限不是0700的目录

$ find ~ -type f -name '*.BAK' -delete
# 查找 BAK 文件，然后删除
```
***用户自定义操作***: `-exec command {} ;` command 表示要执行的操作命令，{ }表示当前路径， ；表示命令结束
```bash
$ find ~ -type f -name '*.BAK' -exec rm '{}' ';'
# 查找 BAK 文件，然后删除
# 可以用 -ok 取代 -exec， 每一次指定的命令执行前会询问用户

$ find ~ -type f -name 'foo*' -exec ls -l '{}' ';'
# 查找并用ls命令列出以foo开头的文件。每找到一个，就执行一次ls命令

$ find ~ -type f -name 'foo*' -exec ls -l '{}' +
# 和上面输出一样。将结尾的；改为 + ， 最后只执行一次ls命令

$ find ~ -type f -name 'foo*' -print | xargs ls -l
# 使用xargs命令，将find命令的输出作为ls命令的输入参数
# 但名称包含空格的文件会被当做参数分隔符处理

$ find ~ -type f -name 'foo*' -print0 | xargs --null ls -l
# find命令提供-print0选项来产生以空字符为参数分隔符的输出结果。xargs命令的--null参数选项支持xargs接收以空字符为参数分隔符的输入
```
### 归档和备份
- `gzip` 文件的压缩与解压缩
```bash
$ gzip foo.txt # 压缩文件，执行后foo.txt会被foo.txt.gz文件取代
$ gzip -d foo.txt.gz # 解压缩文件 或者用 gunzip foo.txt
```
- `tar` 归档工具
```bash
$ tar cf playground.tar playground # 模式c表示创建归档文件，f用于指定归档文件名。必须首先指定模式，然后才是其它的选项
$ tar tf playground.tar # 列出归档文件的内容
$ tar tvf playground.tar # 列出归档文件的详细信息
$ tar xf playground.tar # 抽取tar包中的文件
```

**tar 模式**

| 模式 | 说明                               |
| ---- | ---------------------------------- |
| c    | 为文件和／或目录列表创建归档文件。 |
| x    | 抽取归档文件。                     |
| r    | 追加具体的路径到归档文件的末尾。   |
| t    | 列出归档文件的内容。               |

`tar`通常和`find`命令结合制作归档文件

```bash
$ find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'
# 这里我们使用 find 命令来匹配 playground 目录中所有名为 file-A 的文件，然后使用-exec 行为，来唤醒带有追加模式（r）的 tar 命令，把匹配的文件添加到归档文件 playground.tar 里面。

$ find playground -name 'file-A' | tar cf - --files-from=- | gzip >  playground.tgz
# 也可以使用管道命令。“-”表示标准输入或输出，“--files-from” 表示tar命令从文件而不是命令行读入路径名列表

# 可以简化为：
$ find playground -name 'file-A' | tar czf playground.tgz -T -
```
- `zip`打包压缩工具

```bash
$ zip -r playground.zip playground 
# 需要包含-r选项，要不然只有 playground 目录（没有任何它的内容）被存储

$ unzip ../playground.zip # 解压缩

# 和find命令结合
$ find playground -name "file-A" | zip -@ file-A.zip
$ find playground -name "file-A" -exec zip file-A.zip '{}' '+'
```
- `rsync` 文件和目录的同步
```bash
# 例如要将本地的 /home/lei/git_repo 目录及文件备份到USB存储设备
$ sudo mount /dev/sdb1 /mnt/flash #首先挂载设备
$ sudo rsync -av --delete /home/lei/git_repo/ /mnt/flash/git_repo_backup/ # 备份文件
# '-a'表示保留文件属性，'-v'显示详细输出，'--delete'移除残留于备份设备而源设备不存在的文件
```

### 正则表达式
| 特殊符號 |代表意義            |
| ------------- | --------------------- |
| [:alnum:]	| 代表英文大小寫字元及數字，亦即 0-9, A-Z, a-z |
| [:alpha:] | 代表任何英文大小寫字元，亦即 A-Z, a-z |
| [:blank:] |	代表空白鍵與 [Tab] 按鍵兩者 |
| [:cntrl:] |	代表鍵盤上面的控制按鍵，亦即包括 CR, LF, Tab, Del.. 等等 |
| [:digit:] | 代表數字而已，亦即 0-9 |
| [:graph:] | 除了空白字元 (空白鍵與 [Tab] 按鍵) 外的其他所有按鍵 |
| [:lower:] | 代表小寫字元，亦即 a-z |
| [:print:] | 代表任何可以被列印出來的字元 |
| [:punct:] | 代表標點符號 (punctuation symbol)，亦即：" ' ? ! ; : # $... |
| [:upper:] |	代表大寫字元，亦即 A-Z |
| [:space:]	| 任何會產生空白的字元，包括空白鍵, [Tab], CR 等等 |
| [:xdigit:] |	代表 16 進位的數字類型，因此包括： 0-9, A-F, a-f 的數字與字元 |

**常用的grep选项**

| 选项 | 描述 |
| :--------------: | :----------- |
| -i   | 忽略大小写。不会区分大小写字符。也可用 `--ignore-case` 来指定。 |
| -v   | 不匹配。通常，`grep` 程序会打印包含匹配项的文本行。这个选项导致 `grep` 程序 只会不包含匹配项的文本行。也可用`--invert-match` 来指定。 |
| -c   | 打印匹配的数量（或者是不匹配的数目，若指定了-v 选项），而不是文本行本身。 也可用--count 选项来指定。 |
| -l   | 打印包含匹配项的文件名，而不是文本行本身，也可用`--files-with-matches` 选项来指定。 |
| -L   | 相似于-l 选项，但是只是打印不包含匹配项的文件名。也可用`--files-without-match` 来指定。 |
| -n   | 在每个匹配行之前打印出其位于文件中的相应行号。也可用`--line-number` 选项来指定。 |
| -h   | 应用于多文件搜索，不输出文件名。也可用`--no-filename` 选项来指定。 |

```bash
$ grep -n '^[a-z]' file.txt
$ grep -n '^[[:lower:]]' file.txt # 两行命令效果一样，都是查找以小写字母开头的行
```



**基本正则表达式BRE** and **扩展正则表达式ERE**

BRE可以辨认以下元字符：

```bash
^ $ . [ ] *
```

- ^ -- 与开头内容进行匹配
- $ -- 与末尾内容进行匹配
- .  -- 表示任意字符
- \[  \]  -- 要匹配的字符集
- \[ ^ \]  -- 如果中括号内的第一个字符为 ^, 表示字符集为否定，即不应出现 

ERE可以搜索作为**群组处理的字符串**。ERE可以辨认除上面的元字符外的以下元字符：

```bash
( ) { } ? + |
$ grep -E # 应用ERE时，需给grep添加-E参数
$ echo "CCC" | grep -E 'AAA|CCC'
```

扩展正则表达式ERE支持以下几种方法，***指定一个元素或群组被匹配的次数 :***

- ?  -- 匹配前面元素0次或1次
- \* -- 匹配前面元素0次或多次
- \+ -- 匹配前面元素1次或多次
- { } -- 匹配前面元素特定次数

| 限定符 | 意思                                                     |
| ------ | -------------------------------------------------------- |
| {n}    | 匹配前面的元素，如果它确切地出现了 n 次。                |
| {n,m}  | 匹配前面的元素，如果它至少出现了 n 次，但是不多于 m 次。 |
| {n,}   | 匹配前面的元素，如果它出现了 n 次或多于 n 次。           |
| {,m}   | 匹配前面的元素，如果它出现的次数不多于 m 次。            |

### 文本处理

- `sort` 对标准输入的内容，或命令行中指定的一个或多个文件进行排序，然后把排序 结果发送到标准输出
```bash
$ du -s /usr/share/* | sort -nr | head
# 产生一个按存储空间排序的列表, '-nr'参数表示从大到小排序

$ ls -l /usr/bin | sort -nr -k 5 | head
# sort 也可以指定标准输出的某个字段（-k 5）进行排序
```
- `uniq` 输出或省略重复行。因为仅对排好序的文本才有用，所以和sort结合使用。
```bash
$ sort foo.txt | uniq # 输出不重复的行
$ sort foo.txt | uniq -c # 输出文本中重复行的数量
```
- `cut` 从文本行中切片
```bash
$ cut -f 3 distros.txt | cut -c 7-10
# 提取distros.txt文件中以tab键（默认分隔符）分隔的第三个字段，然后再提取从第7到第10个字符

$ cut -d ':' -f 1 /etc/passwd | head
# 参数'-d'指定分隔符
```
- `paste` 读取多个文件并将每个文件中提取的字段结合为一个整体的标准输出。`cut`的逆操作。
- `join` 基于共享关键字段将多个文件数据拼接到一起
- `tr` 对字符进行删除或者替换
```bash
$ echo "lowercase letters" | tr [:lower:] A # 将所有的小写字母替换为‘A’
```
- `sed` 首先给定sed某个简单的编辑命令（文本行中）或者是包含多个命令的脚本文件名，然后sed对文本流的内容执行给定的编辑命令。sed中的命令总是以单个字母开头
```bash
$ echo "front" | sed 's/front/back' # 参数‘s’表示替换命令，后面紧跟替换字符（默认是斜线'/'，也可以是任意字符）。替换字符之间用斜线字符分割。
```
### 编写shell脚本
#### 更改脚本的可执行权限
每个脚本文件应该以`#!/bin/bash`作为第一行，shebang用于告知操作系统，执行后面的脚本应该使用的解释器名称

```bash
$ chmod 755 script.sh # 755表示：rwxr-xr-x; 700表示rwx------。注意脚本必须为可读才能执行
$ ./script.sh  # 执行脚本
$ script.sh # 如果脚本在PATH目录下，可以直接执行。如果不在的话会报错
$ export PATH=~/bin:"$PATH" # 如果脚本的目录不在PATH目录下的话，可以将目录加入 .bashrc文件
$ . .bashrc # 重新读入 .bashrc文件，以使更改立即生效 “.”命令代表`source`命令，用于读取指定的shell命令文件
```
#### here文档
`here`文档可用于输出文本，和`echo`命令很相似，区别是`here`文档内的单引号和双引号被当做普通字符
`here`文档的工作方式：
```bash
$ command << token # "token"表示嵌入文本结尾的字符串
text
token

$ cat << _EOF_ #"_EOF_"表示文件结尾
text
_EOF_

$ cat <<- _EOF_ # 如果将"<<"改为"<<-"，shell会忽略text每行开头的tab字符。这样可以缩进，以提高可读性
text
	text
	text
_EOF_
```
#### if
```bash
$ if commands; then
	commands
  elif commands; then
  	commands
  else
  	   commands
  fi
```
#### 退出状态
```bash
$ echo $? #查看命令执行情况，0表示执行成功，其他数值（1~255）表示执行失败
```
#### 使用test命令
```bash
$ test expression
# 等同于
$ [ expression ]
```
- 常用的**测试文件表达式**

```bash
#!/bin/bash
# test-file: Evaluate the status of a file
FILE=~/.bashrc
if [ -e "$FILE" ]; then # 文件存在。 注意FILE的引用方式，双引号保证$FILE是一个字符串，可避免因文件名有空格导致的错误
    if [ -f "$FILE" ]; then
        echo "$FILE is a regular file." # 存在并且是一个普通文件
    fi
    if [ -d "$FILE" ]; then
        echo "$FILE is a directory."
    fi
    if [ -r "$FILE" ]; then
        echo "$FILE is readable."
    fi
    if [ -w "$FILE" ]; then
        echo "$FILE is writable."
    fi
    if [ -x "$FILE" ]; then
        echo "$FILE is executable/searchable."
    fi
else
    echo "$FILE does not exist"
    exit 1
fi
exit
```
- 常用的**字符串表达式**
```bash
#!/bin/bash
# test-string: evaluate the value of a string
ANSWER=maybe
if [ -z "$ANSWER" ]; then # String的长度为0
    echo "There is no answer." >&2
    exit 1
fi
if [ "$ANSWER" = "yes" ]; then
    echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
    echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
    echo "The answer is MAYBE."
else
    echo "The answer is UNKNOWN."
fi
```
- 常用的**整数表达式**
| 表达式                | 如果为真...                   |
| --------------------- | ----------------------------- |
| integer1 -eq integer2 | integer1 等于 integer2.       |
| integer1 -ne integer2 | integer1 不等于 integer2.     |
| integer1 -le integer2 | integer1 小于或等于 integer2. |
| integer1 -lt integer2 | integer1 小于 integer2.       |
| integer1 -ge integer2 | integer1 大于或等于 integer2. |
| integer1 -gt integer2 | integer1 大于 integer2.       |

```bash
#!/bin/bash
# test-integer: evaluate the value of an integer.
INT=-5
if [ -z "$INT" ]; then
    echo "INT is empty." >&2
    exit 1
fi
if [ $INT -eq 0 ]; then
    echo "INT is zero."
else
    if [ $INT -lt 0 ]; then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if [ $((INT % 2)) -eq 0 ]; then
        echo "INT is even."
    else
        echo "INT is odd."
    fi
fi
```

#### 更现代的test命令版本
- `[[ expression ]]` 和`test`命令类似，但是增加了新的字符串表达式：
```bash
string =~ regex # 如果string和扩展的正则表达式regex匹配，则返回true
$ if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
```
- 新增的另外一个特性是`==`操作符支持模式匹配，在**评估文件和路径名**时候非常有用
```bash
$ if [[ $FILE == foo.* ]]; then
```
#### `(( ))`——为整数设计
```bash
$ if (( INT == 0)); then # 可通过变量名字识别，不需要在前面加$
$ if (( INT < 0 )); then
$ if (( ((INT % 2)) == 0)); then
```
#### 组合表达式

逻辑操作符

| 操作符 | 测试test | [[  ]] and ((  )) |
| ------ | -------- | ----------------- |
| AND    | -a       | &&                |
| OR     | -o       | \|\|              |
| NOT    | !        | !                 |

```bash
$ if [[ INT -ge MIN_VAL && INT -le MAX_VAL ]]; then # 使用[[ ]]时，变量前的$可以不加
$ if [ $INT -ge $MIN_VAL -a $INT -le $MAX_VAL ]; then #使用test时，变量前必须加$，否则会报错
$ if [ ! \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \)]; then # 可用（）进行分组，但是使用test时候，（）前必须要加转义字符
```
#### 读取键盘输入
- `read`
```bash
read [-options] [variable...]
```

 read 选项

| 选项               | 说明       |
| :------------------- | :------------------------- |
| -a array     | 把输入赋值到数组 array 中，从索引号零开始。我们 将在第36章中讨论数组问题。 |
| -d delimiter | 用字符串 delimiter 中的第一个字符指示输入结束，而不是一个换行符。|
| -e           | 使用 Readline 来处理输入。这使得与命令行相同的方式编辑输入。 |
| -n num       | 读取 num 个输入字符，而不是整行。    |
| -p prompt    | 为输入显示提示信息，使用字符串 prompt。  |
| -r           | Raw mode. 不把反斜杠字符解释为转义字符。 |
| -s           | Silent mode. 不会在屏幕上显示输入的字符。当输入密码和其它确认信息的时候，这会很有帮助。 |
| -t seconds   | 超时. 几秒钟后终止输入。read 会返回一个非零退出状态，若输入超时。 |
| -u fd        | 使用文件描述符 fd 中的输入，而不是标准输入。 |

```bash
if read -t 10 -sp "Enter secret pass phrase > " secret_pass; then
     echo -e "\nSecret pass phrase = '$secret_pass'"
```


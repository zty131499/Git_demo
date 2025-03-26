                                                                 #conda/mamba下载指定版本的R语言#

conda create -n r_env
conda activate r_env
mamba search r-base
mamba install -y r-base=4.4.2
R打开
                                                                  
#安装rstudio-server
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2024.12.0-467-amd64.deb
sudo dpkg -i rstudio-server_2024.12.0-467_amd64.deb

yum install rstudio-server-rhel-2021.09.2-382-x86_64.rpm

#检查是否安装成功
rstudio-server verify-installation
rstudio-server status

#修改rstudio-server配置
# vim /etc/rstudio/rserver.conf
# Server Configuration File
#rsession-which-r=/usr/local/bin/R（写入）
rsession-which-r=/ifs1/Software/miniconda3/bin/R

rstudio-server stop
rstudio-server start
rstudio-server status

#修改防火墙
systemctl start rstudio-server.service
systemctl enable rstudio-server.service
systemctl status rstudio-server
firewall-cmd --permanent --add-port=8787/tcp
firewall-cmd --permanent --add-port=8787/udp
firewall-cmd --reload

#找ip地址
IP地址:8787
8787就是rstudio的端口号相当于防火墙的端口号

#第四步在linux的R里面下载包
.libPaths()  查看R包的路径
/home/ubuntu/miniconda3/envs/r_env/lib/R/library   Linux所有安装的R包都在这个文件夹里面    
C:\Users\周天跃1314\AppData\Local\Temp\Rtmp0CLHO3\downloaded_packages  windows的R包下载路径
C:\Program Files\R\R-4.4.2\library  windows的R包安装路径

判断要用的包来自CRAN还是Bioconductor
r-  bioconductor-  
install.packages("ggplot2") 自己选一个镜像
install.packages("BiocManager")
BiocManager::install("DESeq2")
在linux的R里面下载
conda install -c bioconda bioconductor-deseq2 
mamba search deseq2
mamba install -y bioconductor-deseq2
.libPaths(new = "/home/ubuntu/miniconda3/envs/r_env/lib/R/library")可以改变R包的路径，用其他的包.

#使用Rstudio
更新的时侯点Tools-Global options-change
打开文档乱码就在Tools-Global options-code-saving-cp936/utf-8
换新电脑的时候别再加中文名了
在file保存的时候可以选择编码方式 Save with Encoding
运行R脚本就直接是Rscript test.R

#设置工作目录
Crtl+Shift+H 快捷键
使用鼠标
getwd()
setwd("c:/Users/xxx/Desktop/")
如果只用一个反斜线还可能是转译的意思所以用俩。这个命令在linux里面可以列出所有的可选目录

#创建 Project
创建Project可以将所有数据放到一个目录下,R的Project会保存分析过程中全部内容,方便管理以及分享。

#运行R脚本
Rscript test.R
R -f test.R

#常用快捷键
1、alt+-
R语言的赋值使用“<-”,每次需要敲两个字符,非常麻烦,在Rstudio中可以使用“alt+-”直
接生成,非常方便,如果使用右侧alt键,更加容易。
2、ctrl+shfit+h
使用R第一件事情就是设置工作目录,如果不习惯敲setwd或者不熟悉系统目录结构,可
以使用该快捷键直接用鼠标选择。
3、esc
中断程序，非常有用。
4、tab
tab自动补齐,可以补齐函数,选项参数等;
5、ctrl+L
相当于清屏,与Linux一致。
6、上下箭头
历史记录；
7、ctrl+sfhit+F10
重新启动R,有些情况下需要重新启动R,这个时候无需关闭整个Rstudio,使用该快捷键
即可重新启动R。
8、ctrl+r
ctrl+r快捷键可以快速调出使用过的历史记录,如果有些命令太长,使用这个快捷键非常方便。
9、ctrl+向上
也是快速调出历史记录,与ctrl+r类似。
10、ctrl++,ctrl+-
调整字体大小。
11、ctrl+shift+m
如果使用tidyverse系列包,经常需要使用管道符“%>%”，使用该快捷键可以直接输出管道符。
12、alt+shift+k
可以快速调出所有快捷键列表。
13、alt+enter
就是把选中的命令运行出来

#gc()函数
Garbage CollectionR 语言使用自动内存管理机制。当创建对象（如向量、数据框、列表等）时，
R会自动分配内存来存储这些对象。然而,当对象不再被引用（例如，一个变量被重新赋值，原来指向的对象就没有变量引用它了），这些对象占用的内存并不会立即被释放。
gc()函数会检查内存中的对象，识别出那些没有被任何变量引用的对象，并回收它们所占用的内存空间。这就类似于清理房间，把不再需要的东西清理出去，为新的东西腾出空间。

#R包管理
安装vcd包
install.packages("vcd")

一次安装多个包
install.packages(c("ggplot2","pheatmap"))

查看已安装的包
installed.packages()

加载R包
library(vcd)
require(vcd)

升级软件包
update.packages()

删除扩展包，从磁盘中移除
remove.packages("vcd")

取消加载，从内存中移除
detach("package:vcd")

列出R包中的函数
ls(package:base)

加载包中的数据集
data(package="vcd")

查看当前环境哪些包加载
find.package()
path.package()

查看当前环境哪些包加载
find.package()
path.package()
search()

列出当前包
(.packages())

列出有效包
(.packages(all.available=TRUE))

列出加载包的路径
path.package()

#利用bioconda管理R
在使用bioconda管理R包之前,首先需要知道R包在bioconda中名字为名字为r-base,一些Bioconductor包的名字为bioconductor-前缀。这样就可以使用conda命令安装和管理
R包了。bioconda安装的R包,安装路径在下面目录下。
miniconda3/lib/R/library
conda install -y bioconductor-deseq2

#查看帮助文档
打开帮助页
help()
查看函数帮助
?ggplot2
查看扩展包里函数
??heatmap
查看包帮助文档
help(package="ggplot2" )
运行函数案例代码
example("heatmap")
查看vignettes格式文档
browseVignettes()
R网站搜索
RSiteSearch("heatmap")

#文件操作
1、csv 
逗号分隔值Comma-Separated Values,CSV,有时也称为字符分隔值，因为分隔字符也可
以不是逗号），其文件以纯文本形式存储表格数据（数字和文本）。纯文本意味着该文件是一
个字符序列,不含必须像二进制数字那样被解读的数据。CSV文件由任意数目的记录组成,
记录间以某种换行符分隔；每条记录由字段组成，字段间的分隔符是其它字符或字符串，最
常见的是逗号或制表符。通常，所有记录都有完全相同的字段序列。通常都是纯文本文件。
name,age
张三,20
李四,30

2、tsv
TSV:tab separated values即“制表符分隔值”
name age
张三 20
李四 30

第一行做为每一列的名字，就是第一列做为每一行的名字。

#读取文件
先设置工作目录    obs.就是指行  variables.就是指列
dta <- read.table(file = "Rdata/CountMatrix.csv",header = T,sep = ",",row.names = 1)
class(dta)  判断是什么类型
head(dta)  
tail(dta)  
rownames(dta)  
colnames(dta) 
View(dta)

#写入文件
write.csv(x = dta,file = "matrix.csv",sep = ",",append = F,row.names = F)这个时候是指定无行名字的，和读取的时候不一样，不然会多一列。
zty$name <- row.names(zty)
write.table(x=zty,file = "ztl.csv",sep = ",",row.names = F)，这个时候是指定有行名字的，和读取的时候一样，不然会少一列。


#读写excel文件
普通的一个csv文件就是指一个工作表,一个excel文件就是指一个工作簿,一个工作簿里面可以有多个工作表。
安装openxlsx包
install.packages("openxlsx")
library(openxlsx)
x <- read.xlsx("2015.xlsx",sheet = 1)
?read.xlsx
write.xlsx(x = dta,sheetName = "dta",file = "dta.xlsx",append = F)

#读写R文件
RDS=R Data Single ,存储一个单个数据集,相对于文本格式的数据,以为会压缩，它的存储效率更高,读取速度更快。 
Rdata=R data multiple ,存储多个数据集,可以存储多个数据集,并且可以存储R的所有对象,如数据框、列表、函数等。
?iris
head(iris)
getwd()
saveRDS(iris,file="iris.RDS")
rdsdata <- readRDS("iris.RDS")

#Write RData file
save(iris,iris3,file = "iris.Rdata")
save.image()
load(file = "iris.Rdata")

#数据结构
数据类型主要表示数据代表哪种内容，是字符串还是数值，逻辑值，或者时间日期等。数值
可以用于计算，字符串不能用来计算，逻辑值用来判断等。
类型                         说明
字符(charactor)          常常被引号包围
数值(numeric)               实数向量
复数(complex)               复数向量
逻辑(logical)        二元逻辑向量(T=TRUE, F=FALSE)



数据结构                    说明                           允许多种类型
1 向量(vector)           最基本的类型                           否
2 因子(factor)           表示类别/分类数据                       否
3 数组(array)            带下标的多维数据集合                    否
4 矩阵(matrix)            二维数组                              否
5 数据框(data frame) 行和列组成的表，每列可以是不同数据类型        是
6 列表(list)             不同对象的有序集合                      是 
7 时间序列               根据时间顺序排列的数据                   是
8 类                      不同数据组合                           是


#内置数据集
R语言的一个好处是内置了大量数据集,一般R扩展包也包含数据集,这样无需自己准备
输入文件,可以很方便的重复案例的内容。启动R之后,默认已经加载了datasets包,
里面包含了大量数据集,使用data()函数可以显示所有数据集。直接敲数据集的名字就能
够打印出数据集的内容,内置数据集与自己通过文件将数据读入R中,存储为变量效果上
是一样的。

显示所有内置数据集
data()
加载扩展包数据集
data(package = "MASS")
data(package = "ggplot2")

#向量
向量:vector,是 R 中最重要的一个概念，它是构成其他数据结构的基础。向量其实是用于
存储数值型、字符型或逻辑型数据的一维数组。R 中的向量与解析几何或者物理学中有数值
和方向的量不同,R 中的向量是一个集合，即可以是数值的集合也可以是字符串或者逻辑值
的集合。其余数据结构都由向量构成。

#创建向量
用函数c来创建向量。c代表concatenate连接,也可以理解为收集collect,或者合并combine。
新手经常犯的错误就是忘了使用 c()函数。

生成连续型向量
seq(1,10,by=2)  1 3 5 7 9
seq(1,10,length=5)  1 3.25 5.5 7.75 10
rep(1:3,each=2)  1 1 2 2 3 3
rep(C(1,2,3),times=2)  1 2 3 1 2 3

字符型向量
b <- c("red","green","blue")

逻辑型向量
C<-c(T,F,T)全部大写，这里就没有加引号，因为指特殊的关键字。

#向量化操作    避免循环
y <- c(1:10)
y+1   y*2   y*c(2,-2)   y+c(1,2)

#生成样本名
a <- 1:50   b <- c("A","B")  rep(b,each=50)  b <- rep(b,each=50)  paste(b,a,sep = "")

#向量索引
一维数据,从1开始索引,其他编程语言从0开始索引。
数值索引
rivers[c(1)]
euro[1:3]
euro[-(1:3)]删除前三个数据
rivers[seq(1,141,by=2)]
名字索引
euro["ATS"]
逻辑值索引
rivers[c(T,F)]取奇数项
rivers[rivers>mean(rivers)]取大于平均数的数据
rivers[131]<- 1000 替换第131个数据
rivers[rivers== 350]<- 1 替换等于350的数据为1
data(“rivers”)可以重新加载数据集，千万不要用=号，因为=号是赋值

#例子
getwd()
dir()[23]
x <- read.csv("homo_length.csv")
x <- head(x,24)
len <- x[,2]
chr <- x[,1]
barplot(len,names.arg = chr,las=2,col = rainbow(4),border = F)

#矩阵      head  view  class rownames colnames nrow ncol
矩阵(Matrix)是一个按照长方阵列排列的复数或实数集合。向量是一维的，而矩阵是二维
的，需要有行和列。矩阵是 R 语言中使用较多的一种数据结构，矩阵分为数值矩阵和字符串
矩阵，常用的是数据矩阵，基因的表达数据为数值矩阵。矩阵有两大作用，一个是用来计算
相关性，另外可以用来绘制热图。
m <- matrix(1:20,nrow = 4,ncol = 5,byrow=T)
dim(m) 查看是几维的数据
x <- read.csv("heatmap.csv")
x <- read.csv("heatmap.csv",row.names = 1)
heatmap(x)
错误于heatmap(x): 'x'必需为数值矩阵
x <- as.matrix(x)
heatmap(x)
pheatmap(x),这个函数可以自动强制转为数值矩阵

#矩阵索引
矩阵属于二位数据，需要给定行列的。
位置索引
x[,c(1:5)]  行全要,1到5列
名字索引
x[,"N.GD1"]
y <- x[,c(1:5,11:15,6:10,16:20)] 调整样本名
逻辑值索引
y[,c(T,F)]

#apply函数,1行2列
colSums(x)
rowMeans(x)
apply(x,1,sum)
apply(x,1,var)
apply(x,1,sd)
apply(x,1,max)
apply(x,1,min)

#数据框 read.table默认读入的都是数据框      数据分析基本上都按列分析          $只能把列拿出来，行不行     按列取的会自动变为向量，按行取的要as.numeric()转换
数据框是一种表格式的数据结构，属于一种二维表，分为行和列。数据框旨在模拟数据集，
与其他统计软件例如 SAS 或者 SPSS 中的数据集的概念一致。数据集通常是由数据构成
的一个矩形数组，行表示观测，列表示变量。不同的行业对于数据集的行和列叫法不同。
在一个数据框中，每一行的元素个数相同，每一列元素个数也相同，每一列的数据类型一
致，都为一个向量，每一行内容还是一个数据框。数据框是 R 中使用最广泛的一种数据格
式。
library(openxlsx)
x <- read.xlsx("2015.xlsx")
head(x)
#按列合并
a <- 1:5
b <- letters[1:5]
c <- c("one","two","three","four","five")
data.frame(a,b,c)

#数据框索引     $数据框独有的
x <- read.csv("homo_length.csv")
barplot(height = x$length,names.arg = x$chr,las=2,col = rainbow(4),border = F)


#例子  数字不能定义为样本名开头
rm(list = ls())清空所有变量
从一个大表里面找一个小表里面的东西   相当于excel中的 Vlookup 功能
dat <- gene200[unique(gene121$gene),]  去除重复
na.omit(dat)   去除NA
write.csv(dat,file = "93gene.csv")

#因子
所有的数据集合可以分为三类,连续型,名义型和有序型。连续型例如1 2 3 4 5 8 9 10,名
义型如sample1 sample2 sample3 ，而有序型 good better best:周一,周二,周三……
等。在R中名义型变量和有序性变量称为因子,factor。这些分类变量的可能值称为一个水
平level,由这些水平值构成的向量就称为因子。因子主要用于计算频数，可以用来分组。可
以通过factor()函数中的labels选项对因子的值进行批量修改。

x <- c("M","w","M","W","M")
x
[1] "M" "w" "M" "W" "M"
factor(x)
[1] M w M W M
Levels: M w W
table(x)        查看频数


#列表
列表就是一些对象的有序集合。列表中可以存储若干向量、矩阵、数据框，甚至其他列表
的组合。
alist <- list(D=dat,G=gene121,E=gene200,V=x)
names(alist)
length(alist)

#时间序列 ts
时间数列类似与数据框，主要是记录随着时间变化值的变化，例如每天，每月，每个季度，
每年的变化前框的，主要表现趋势的变化。例如股票数据，经济数据，气候数据等。时间
序列分析主要用于预测。
plot(presidents)

#缺失数据
缺失信息问题在数据科学中非常常见。在大规模数据采集过程中，几乎不可能每次都得到完
整的数据，那么该如何处理缺失数据呢？首先我们要清楚为何会出现缺失数据，一种可能是
机器断电，设备故障导致某个测量值发生了丢失。或者测量根本没有发生，例如在做调查问
卷时，有些问题没有回答，或者有些问题是无效的回答等，这些都算作缺失值。对于缺失信
息,R中提供了一些专门的处理方法。
在R中,NA代表缺失值,NA是不可用,not available的简称,用来存储缺失信息。这里缺
失值NA表示没有,但注意没有并不一定就是0,NA是不知道是多少,也能是0,也可能
是任何值，缺失值和值为零是完全不同的
x <- 1:5
x
[1] 1 2 3 4 5
x[7] <- 7
x
[1]  1  2  3  4  5 NA  7
sum(x)
[1] NA
is.na(x)
[1] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
sum(x,na.rm = T)
[1] 22
mean(x,na.rm = T)
[1] 3.666667
x[6]
[1] NA
x[6] <- mean(x,na.rm = T)
x
[1] 1.000000 2.000000 3.000000 4.000000 5.000000 3.666667 7.000000

install.packages("VIM")
library(VIM)
help(package="VIM")
data(sleep)
class(sleep)
[1] "data.frame"
View(sleep)
na.omit(sleep)
a <- aggr(sleep, plot = FALSE)
plot(a, numbers = TRUE, prop = FALSE)

#类
类和对象是面向对象编程技术中的最基本的概念。R中会有很多类,例如在分析生物数据时,
会经常遇到各种类,例如Experiment Set 类。类是现实世界或思维世界中的实体在计算机中
的反映,它将数据以及这些数据上的操作封装在一起。对象(object)是具有类类型的变量。
R中类是将各种数据整合在一起,本质上是一种列表。



                                                                          #数据处理#

x <- c(1:100)
判断数据类型
is.vector(x)
is.character(x)
转换数据类型
as.character(x)
is.numeric(mtcars$cyl)
as.factor(mtcars$cyl)
不同数据类型绘图结果不同
plot(as.numeric(mtcars$cyl))
plot(as.factor(mtcars$cyl))

#修改数据内容
数据分析中经常需要对原数据中的某些地方进行修改。修改数据属于赋值操作，也就是将
原有的值赋一个新的值，这就需要首先能够将要修改的值索引出来，然后重新赋值即可。
如果要修改某一行或者某一列的内容，则可以先索引出这一行或一列的内容，然后批量赋
值。如果需要增加或者删除某一行或者某一列，可以使用 rbind 或者 cbind 函数。
mtcars$cyl
[1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
mtcars$cyl[mtcars$cyl==4]
[1] 4 4 4 4 4 4 4 4 4 4 4
mtcars$cyl[mtcars$cyl==4] <- "four"

as.factor(mtcars$cyl)
mtcars$cyl <- as.factor(mtcars$cyl)
str(mtcars)
levels(mtcars$cyl)
[1] "4" "6" "8"
levels(mtcars$cyl) <- c("four","six","eight")

#增加一列,并匹配值
data("mtcars")
mtcars[1:10,]
mtcars$cylinders <- NA
mtcars$cylinders[mtcars$cyl==8] <- "eight cylinders"

#筛选数据
筛选主要是将满足一定条件的内容挑选出来，例如等于某个值，或者大于，小于等，如果是
字符串就是字符串的匹配。
mtcars[mtcars$mpg >=20 & mtcars$cyl ==4,]

#排序
排序需要给定排序标准，首先确定是对数字排序还是字符串排序，数字一般是按照大小顺序，
字符串按照首字母顺序排序。可以对一维数据排序,也可以对多维数据排序。R提供了sort
和order等排序方法,order是对索引进行排序,在R中使用的更多。
一维数据排序
rivers
sort(rivers)  默认升序
sort(rivers,decreasing = T) 降序
二维数据排序
rivers
order(rivers)   排的是索引值,即位置
rivers[order(rivers)]
mtcars[order(mtcars$cyl,mtcars$mpg,decreasing = T),]
mtcars[order(mtcars$cyl,mtcars$mpg,decreasing = c(T,F)),]  分别降序和升序
rev(sort(rivers))
rivers[order(-rivers)]

#修改数据类型    把第一行变成列名，把原来的1，2，3，4去掉   一般加上row.names = 1就行
x <- read.csv("heatmap.csv")
head(x)
class(x)
[1] "data.frame"
methods(is)
methods(as)
rownames(x) <- x$X
ncol(x)
[1] 21
x[,-1]
x <- x[,-1]
class(x)
[1] "data.frame"
as.matrix(x)
x <- as.matrix(x)
class(x)
[1] "matrix" "array" 
heatmap(x)

#例子
rm(list = ls())
ls()
[1]character(0)
x <- read.csv("CountMatrix.csv",row.names = 1)
x <- x[,c(1,3,5,7,2,4,6,8)]   调整列名
colSums(x)
y <- apply(x,2,sum)   按列求和，合并数据,绘制直方图
barplot(y,las=2)
par(mar=c(8.1,4.1,4.1,2.1))
barplot(y,las=2)
x["total",] <- colSums(x)   在最后一行加上总和
tail(x)

数据分析中经常需要对原数据中的某些地方进行修改。修改数据属于赋值操作，也就是将
原有的值赋一个新的值，这就需要首先能够将要修改的值索引出来，然后重新赋值即可。
如果要修改某一行或者某一列的内容，则可以先索引出这一行或一列的内容，然后批量赋
值。如果需要增加或者删除某一行或者某一列,可以使用rbind或者cbind函数。

rbind(x[1:4,],x[10:14,])
cbind(x[1:4,1:5],x[1:4,5:8])
z <- rowSums(x)        按行求和,合并数据,过滤表达量为0的基因
x <- cbind(x,rTotal=z)
x <- x[x$rTotal > 0,]   

#不同数据类型转换
一般的R函数只能接受固定类型的数据,例如绘制热图,输入数据必须是数值型向量,数据
框则不行,线性回归分析中,输入数据必须为一个数据框。因此，需要熟悉各种数据类型之
间的转换。此外,在做数据转换的过程中，还要记住,有些数据只能单方向进行转换,而不
能相互转换,例如部分数据框无法转换为数值型矩阵。

向量和矩阵之间相互转换：给向量加上维度。
x <- c(1:10)
dim(x) <- c(2,5)
向量和数据框之间相互转换:data.frame,cbind和rbind将向量转换为数据框,取出数据框的
每一列为一个向量。
state <- data.frame(state.name,state.abb,state.division,state.area)
数据框和矩阵之间相互转换：
as.matrix()将数据框转换为矩阵
iris.mat <- as.matrix(iris[1:4])
as.data.frame()矩阵转换为数据框。
state <- as.data.frame(state.x77)
向量和因子之间相互转换；as.factor()函数。
mtcars$cyl <- as.factor(mtcars$cyl)
修改因子的水平和标签；
mtcars$cyl <- factor(mtcars$cyl,levels = c(4,6,8),labels =
c("four","six","eight"))

#随机抽样
在做统计分析的过程中,经常需要进行随机抽样,R提供了多种生成随机数的函数,并且可以进行多种形式的抽样。
x <- runif(n=100,min = 1,max = 100)
sample(x,10,replace = F)
sample(x,10,replace = T)
set.seed(1234)   设置随机种子 保证每次随机结果一样
set.seed(1234)
x <- c(1:10)
sample(x,5)
[1] 10  6  5  4  1
sample(x,3)
[1] 5 6 8
set.seed(1234)
sample(x,3)
[1] 10  6  5

按比例抽样
x <- c(1:100)
sample(x,size = 0.25*length(x))
[1]  9  5 38 16  4 86 90 70 79 78 14 56 62 96 87 21 40 89 67 99 66 47 84 48  3

#利用R语言斗地主
rm(list = ls())
type <- c("red","spades","cube","plum")
amount <- c("A",2:10,"J","Q","K")
a <- rep(type,each=13)
b <- rep(amount,4)
poker <- paste(a,b,sep = "-")  expand.grid(type,amount)
poker[c(53,54)] <- c("black joker","red joker")
sample(poker,54,replace = F)
set.seed(666)
shuffle <- sample(poker,54,replace = F)
dipai <- shuffle[52:54]
shuffle <- shuffle[-(52:54)]
one <- shuffle[c(T,F,F)]
two <- shuffle[c(F,T,F)]
three <- shuffle[c(F,F,T)]
sort(one)
sort(two)
sort(three)
dipai

#探索数据
x <- read.csv("WHO.csv",row.names = 1)
View(x)
x$CountryID <- rownames(x)
y <- data.frame(x$CountryID,x$Population_total)
y[order(y$x.Population_total,decreasing = T),]
y[order(y$x.Population_total,decreasing = T),][1:10,]
colnames(x)[grep("Pop",colnames(x))]
y <- data.frame(x$CountryID,x$Sugar_per_person)
y[order(y$x.Sugar_per_person,decreasing = T),]

#数据透视表
R提供了apply系列函数,包括apply,lapply,sapply,tapply,vapply等,可以对二维数据
进行计算,并且可以分组进行统计,类似于Excel中的数据透视表功能。
tapply(x$Income,x$Province,mean)  分组计算平均值,用province分组
aggregate(x$Income,by=list(x$Province,x$City),mean)


class(state.x77)
state.x77 <- as.data.frame(state.x77)
sort(tapply(state.x77$Income,state.division,mean))

                                                                           #tidyverse#
Tidyverse是Rstudio公司推出的专门使用R进行数据分析的一整套工具集合,里面包括了
readr,tidyr,dplyr,purrr,tibble,stringr,forcats,ggplot2等包。
https://github.com/tidyverse/

这些包涵盖了数据读取，清洗，转换，字符串处理，建模，数据可视化，生成报告等完整过
程。可以阅读《R数据科学》查看完整教程。
《R数据科学》电子书:https://r4ds.had.co.nz/

tidyverse包重构了R语言处理数据的语法,比默认的R函数更加方便,相当于一套新的语
法,使用起来更加方便。但是并不是所有的R包都兼容这套语法。
tidyr与dplyr包是用R语言中用来处理各种数据整合分析的包,可以说是R数据整合的“瑞
士军刀”,tidyr包负责将数据重新整合,dplyr包可以完成数据的排序,筛选,分类计算等都
等操作，还包括各种集合的运算。掌握这两个包就可以完成绝大部分的数据处理工作。
官网:https://www.tidyverse.org/

#tidyr 数据整理
library(tidyverse)  加载tidyverse包可能会乱码,可以使用Sys.setlocale("LC_CTYPE","zh_CN.UTF-8")解决,或者手动调也行

tidyr包用于将数据重新整合,替代之前的reshape和reshape2包,用于数据的重塑与聚合,
类似于Excel中的数据透视功能pivot。tidyr之前的版本主要包含一下几个重要函数:
gather:宽数据变成长数据；
spread:长数据变成宽数据；
unite:将多列按指定分隔符合并为一列
目前最新的版本中主要提供pivot_longer,pivot_wider等函数。

#整洁数据       列是变量,行是观察值
tidyr名字来自于tidy(整洁)一词。所谓“整洁数据”，根据 Hadley Wickham 对整洁数据的专门
研究，其定义如下：
1.每个变量构成一列；
2.每项观察构成一行；
3.每种类型的观察单元构成一个表格；
tidy data定义:https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html
总而言之，让数据变的更好用（符合下层函数参数的格式要求），方便用户查找和阅读。简
而言之：易阅读，方便用。数据的整理是一个从数据框的统计结构（变量与观察值）到形式
结构（列与行）的映射。
tidyr包主要就是用来将数据转换为“整洁数据”的包,主要功能为
(1)缺失值的简单补齐
(2)长形表变宽形表与宽形表变长形表；

#长数据与宽数据


#稀疏矩阵与稠密矩阵
在矩阵中,若数值为0的元素数目远远多于非0元素的数目,并且非0元素分布没有规律时,
则称该矩阵为稀疏矩阵;与之相反,若非0元素数目占大多数时,则称该矩阵为稠密矩阵。
稀疏矩阵(sparse matrix)
OTU ID sampleA sampleB sampleC
OTU0      0       0      4
OTU1      6       0      0
OTU2      1       0      7
OTU3      0       0      3
稠密矩阵（ dense matrix)   @提取数据
sampleA OTU1 6
SampleA OTU2 1
SampleC OTU0 4
SampleC OTU2 7
SampleC OTU3 3

#数据“融化”与“重铸
数据“融化”melt与“重铸”cast来自于reshape包中的概念。这些概念非常形象的描述了数据
转换的过程。melt将数据转换为长数据,cast重新调整变量。tidyr数据转换也是类似的方法。

#tidyr 使用案例
R包::R函数不用加载,直接使用该函数,以为有的包加载一下太耗内存，而且后加载的包中的函数会覆盖前面的包
help(package="tidyr")
??tidyr::pivot_longer
??tidyr::pivot_wider
library(purrr)
宽数据变长数据
table4a
pivot_longer(table4a, cols = 2:3, names_to ="year",values_to = "cases")
x <- pivot_longer(table4a,cols = 2:3,names_to = "year",values_to = "cases")
pivot_wider(x,names_from = year,values_from = cases)
pivot_longer(billboard,cols = starts_with("wk"),names_to = "week",names_prefix = "wk",values_to = "rank",values_drop_na = T)
长数据变宽数据
table2
pivot_wider(table2, names_from = type,values_from = count)


#dplyr 数据处理
#案例 1:筛选过滤行 filter() 
filter()函数用于筛选出一个观测子集，第一个参数是数据库框的名称，第二个参数以及随
后的参数是用来筛选数据框的表达式。
dplyr::filter (iris,Sepal.Length >7)
dplyr::filter(mtcars,mpg>21)
dplyr::filter(mtcars,cyl==c(4,6),mpg>21)

#案例 2:排序 arrange() 
arrange()函数的使用方法与 filter()函数类似，主要用于排序，默认按照从小到大顺序，
可以使用 desc()按照降序排序。
dplyr::arrange(iris,Sepal.Length)
dplyr::arrange(iris,desc(Sepal.Length))  降序
dplyr::arrange(mtcars,-mpg)

#使用管道%>%，快捷键ctrl+sfhit+m
library(magrittr)
relig_income %>%  pivot_longer(!religion, names_to = "income", values_to = "count")
mtcars %>% dplyr::filter(mpg>20) %>% dplyr::arrange(cyl)

#案例 3：筛选过滤列 select() 
select()函数用于筛选有用的列，第一个参数还是数据库，第二个参数以及后面是需要的列
名，列名有多种书写方式，可以使用冒号作为范围，也可以使用 stars_with,ends_with 等
函数进行模式匹配。另外，当想要把几个需要的列移到前面，可以配合使用 everythins()
函数，将剩余的列添加到后面。
x %>%dplyr::select(starts_with("Pop")) %>% View()   找出以Pop开头的列

#案例 4：抽样： 
抽样的函数使用起来比较容易，可以按照个数抽样，也可以按照百分比进行抽样。
dplyr::sample_n(iris,10)
dplyr::sample_frac(iris,0.1)
mtcars %>% sample_n(10)
mtcars %>% sample_frac(0.2)

#案例 5：创建新变量 
有时需要对已有变量进行重新计算，例如计算几列的和，会某一列取对数，这样将生成新的
变量，这个时候可以使用 mutate 函数。
dplyr::mutate(iris,new=Sepal.Length+Petal.Length)
mtcars %>% dplyr::mutate(mpg10=mpg*10)
round(x$Income/x$People,digits = 1) 保留一位有效数字
x %>% dplyr::mutate(avg=Income/People)

#案例 6：统计： 
使用summarise()可以对每一列单独进行计算，例如求和，求平均值等，这些都可以使用
apply系列函数来完成,summarise()一般都配合group_by()函数一起使用，可以进行分组
统计。
summarise(iris,avg=mean(Sepal.Length))
summarise(iris,sum=sum(Sepal.Length))


#案例 7：分组统计： 
group_by()函数与 summarise()配合一起使用，可以进行分组统计。
head(iris)
iris_by <- dplyr::group_by(iris,Species)
summarise(iris_by,mean=mean(Sepal.Length,na.rm = T))
使用管道组合操作：
iris %>% group_by(Species) %>% summarise(avg=mean(Sepal.Width)) %>% dplyr::arrange(avg)

#案例 8：集合运算 
按列合并
a=data.frame(x1=c("A","B","C"),x2=c(1,2,3))
b=data.frame(x1=c("A","B","D"),x3=c(T,F,T))
dplyr::left_join(a,b,by="x1") 
dplyr::full_join(a,b,by="x1")  
dplyr::semi_join(a,b,by="x1")
dplyr::anti_join(a,b,by="x1")

按行操作
first <- slice(mtcars,1:20)
second <- slice (mtcars,10:30)
intersect(first, second) 交集
union_all(first, second)  并集
union(first, second) 合并完去重
setdiff(first, second) 补集，前面的优先级高
setdiff(second, first) 



                                                                  #统计检验#

                                                 有关系：相关性检验             没关系：独立性检验
#假设检验 
假设检验是用来判断样本与样本，样本与总体的差异是由抽样误差引起还是本质差别造成的
统计推断方法。其基本原理是先对总体的特征做出某种假设，然后通过抽样研究的统计推理，
对此假设应该被拒绝还是接受做出推断。其基本原理如下所示：
(1)先假设总体某项假设成立，计算其会导致什么结果产生。若导致不合理现象产生，则
拒绝原先的假设。若并不导致不合理的现象产生，则不能拒绝原先假设，从而接受原先假设。
(2)它又不同于一般的反证法。所谓不合理现象产生，并非指形式逻辑上的绝对矛盾，而
是基于小概率原理：概率很小的事件在一次试验中几乎是不可能发生的，若发生了，就是不
合理的。至于怎样才算是“小概率”呢?通常可将概率不超过0.05的事件称为“小概率事件”，
也可视具体情形而取0.1或0.01等。在假设检验中常记这个概率为α，称为显著性水平。而
把原先设定的假设成为原假设,记作H0。把与H0相反的假设称为备择假设,它是原假设
被拒绝时而应接受的假设，记作H1。
假设的形式
H0——原假设,H1——备择假设
双侧检验:H0:μ = μ0 ,
单侧检验:H1:μ < μ0或 H1:μ > μ0 假设检验就是根据样本观察结果对原假设(H0)行检验，接受 H0,就否定 H1:拒绝 H0,就接受 H1。

#频数统计与独立性检验
离散型变量（因子）通过计算频数，然后进行独立性检验，判断两个变量之间是否有关系。
install.packages("vcd")  离散数据可视化
x$Improved[x$Improved=="Some"] <- "Marked"  改数据的第一步先是找到数据的位置
levels(x$Improved) <- c("None","Marked","Marked")

y <- table(x$Improved,x$Treatment)
chisq.test(y)
fisher.test(y)   
z <- table(x$Improved,x$Sex)
chisq.test(z)
fisher.test(z)

#t 检验(有参)与 wilcox 检验（无参）
连续型变量独立性检验,如果数据分布满足正太分布可以使用t检验,否则使用wilcox检验。
y <- t.test(x[1,1:5],x[1,6:10])
class(y)
[1] "htest"    类 
str(y)
y$p.value
for(i in 1:30){y=t.test(x[i,1:5],x[i,6:10])$p.value;print(y)}
apply(x,1,function(x) {t.test(x[1:5],x[6:10])$p.value})
apply(x,1,function(x) {t.test(x[1:5],x[11:15],paired = T)$p.value}) 配对t检验,前后差异
p <- apply(x,1,function(x) {wilcox.test(x[1:5],x[11:15],paired = T)$p.value}) 如果不满足正态分布


#多重检验校正
p.adjust(p =p,method = "fdr" )  因为每次检验都有一定的错误率,累计多了所以要校正
p.adjust.methods
[1] "holm"       "hochberg"   "hommel"     "bonferroni" "BH"         "BY"        
[7] "fdr"        "none"      


差异表达基因不能用t检验,因为t检验结果比真实算出来的结果要大很多,会漏掉很多值。

#例子
vc_0.5 <- ToothGrowth[(ToothGrowth$supp=="VC" & ToothGrowth$dose==0.5),]$len
oj_0.5 <- ToothGrowth[(ToothGrowth$supp=="OJ" & ToothGrowth$dose==0.5),]$len
t.test(vc_0.5,oj_0.5,paired = F)


#相关性检验
利用 R 进行数据挖掘，数据来源于著名的 state.x77 数据集。这个数据集提供了美国 50 个州
在 1997 年人口、收 入、文盲率、预期寿命、谋杀率和高中毕业率、气温以及土地面积的
数据。通过数据搜集的信息，想知道哪些因素与谋杀率相关性较高。
计算相关性系数
R 可以计算多种相关系数，包括 Pearson 相关系数、Spearman 相关系数、Kendall 相关系数、
偏相关系数等。直接利 用 cor()函数即可计算，输入数据必须是一个矩阵。  矩阵就不能用$符号取数据了
round(cor(state.x77),digits = 2) 
cor.test(state.x77[,3], state.x77[,5] )  相关性检验



                                                                  #统计建模#
#线性回归      lm（）函数简单的线性回归，正态分布
回归 regression,通常指那些用一个或多个预测变量,也称自变量或解释变量,来预测响
应变量，也称为因变量、效标 变量或结果变量的方法。
lm( 因变量~自变量1+自变量2+自变量3,数据集)     要求输入的数据集是一个数据框
plot(women$height,women$weight,type = "l") 
fit <- lm(weight ~  height, data = women) 线性回归
summary(fit) 模型的详细信息

Call:
lm(formula = weight ~ height, data = women) 模型

Residuals:残差，实际值与预测值的差值，越小越好
    Min      1Q  Median      3Q     Max 
-1.7333 -1.1333 -0.3833  0.7417  3.1167 

Coefficients:系数项
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) -87.51667    5.93694  -14.74 1.71e-09 ***    截距
height        3.45000    0.09114   37.85 1.09e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.525 on 13 degrees of freedom  残差标准误差
Multiple R-squared:  0.991,	Adjusted R-squared:  0.9903  多重R方,越大越好
F-statistic:  1433 on 1 and 13 DF,  p-value: 1.091e-14   F检验,越小越好

fitted(fit) 列出拟合模型的预测值  原有的数据集带进去验证
predict(object = fit ,newdata = newdata) 用拟合模型对新的数据集预测响应变量值，新的数据集
coef(fit) 列出拟合模型的系数，截距和斜率
resid(fit) 列出拟合模型的残差
confint(fit) 列出拟合模型的置信区间
newdata <- data.frame(height=c(73,60)) 
predict(object = fit ,newdata = newdata) 用拟合模型对新的数据集预测响应变量值

#谋杀率案例
通过计算相关矩阵,已经可以初步知道几个因素与谋杀率murder之间的相关关系,那
么具体是怎样的关系，需要进行数据挖掘，建立谋杀率与几个因素之间具体的数学关系。
模型建立之后就可以通过数值预测某个地区的谋杀率。线性回归函数lm只接受数据框
结构数据，所以需要将矩阵转换为数据框。

state.x77 <- as.data.frame(state.x77)
class(state.x77)
[1] "data.frame"   
colnames(state.x77)   把列名写出来，一会要用
[1] "Population" "Income"     "Illiteracy" "Life Exp"   "Murder"     "HS Grad"   
[7] "Frost"      "Area"      
attach(state.x77)   用这个函数提出来之后可以自动补齐
Population
fit <- lm(Murder~Population+Income+`Life Exp`+`HS Grad`+Frost+Area,data = state.x77)
summary(fit)  可以根据结果调整模型,不用特别担心toy data的拟合度,真实数据还不一定是什么样的呢

#基因组大小与基因个数线性回归案例        “多倍体”  "重复序列"
x <- read.csv("prok_representative.csv")   因为第一列有重复,所以不能row.names=1
x[duplicated(x$Organism),]
plot(x$Size,x$Genes,pch=16,cex=0.8,xlab = "Gene Size",ylab = "Gene Number",main = "Genomesize with Numbers")
abline(fit,col="blue")
text(3.5,10000,label="y=843.7x+286.6 \n R2=0.9676")
text(12.5,2000,label="Corynebacterium striatum")
text(2.5,6000,label="Candidatus Burkholderia \n kirkii UZHbot1")

#购物篮分析    用户画像   大数据杀熟
购物篮分析属于一种关联规则，是数据挖掘中非常流行的一种技术，购物篮分析有着广泛的
应用,例如用于网络交易记录分析,视频推荐系统,购物推荐系统等。R中实现关联分析可
以使用arules包,里面包含了apriori算法与eclat算法等。
 
install.packages("arules")
library(arules)
data(Groceries)
Groceries
inspect(Groceries)
fit <- apriori(Groceries,parameter = list(support=0.01,confidence=0.5))
summary(fit)
inspect(fit)

#用户收听习惯分析
library(arules)
data(audioscrobbler)
x <- read.transactions("audioscrobbler.csv",sep = ",")
audioscrobbler.apriori <- apriori(data=audioscrobbler,parameter=new("APparameter",support=0.0645) )
inspect(audioscrobbler.apriori)
eclat算法
library(arules)
data(audioscrobbler)
audioscrobbler.eclat <- eclat( data=audioscrobbler, parameter=new("ECparameter",support=0.129,minlen=2))
inspect(audioscrobbler.eclat)

#利用机器学习预测乳腺癌   训练集+验证集=8；2   分类；有监督的机器学习，逻辑回归    聚类；无监督的机器学习
这是一个典型的利用当前流行的机器学习算法来进行生物数据挖掘的案例，非常具有代表性。
同样的算法可以应用在其
他不同肿瘤研究中。这是一份来自威斯康星州采集的乳腺癌数据集。这个数据集中包含699
个细针抽吸活检的样本单
元,其中458个(65.5%)为良性样本单元,241个(34.5%)为恶性样本单元。
[数据链接] 
(http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/)

假阳性：实际为阴性，预测为阳性,错检；假阴性：实际为阳性，预测为阴性，漏检；真阳性：实际为阳性，预测为阳性；真阴性：实际为阴性，预测为阴性。
http://vassarstats.net/     在线网站计算各种想要的值  

读入数据
x <- read.csv("breast.csv",row.names = 1)
x <- x[,-1]
x$class <- as.factor(x$class)
levels(x$class) <- c("benign","nalignant")
拆分数据集
set.seed(1234)
train <- sample(nrow(x),0.7*nrow(x))
x.train <- x[train,]
x.validate <- x[-train,]
table(x.train$class)
   benign nalignant 
      319       170 
table(x.validate$class)
   benign nalignant 
      139        71 
建模
fit <- glm(class ~ . ,data = x.train,family = binomial())
summary(fit)
验证
prob <- predict(object = fit,x.validate,type="response")
result <- factor(prob>0.5,levels = c(F,T),labels = c("benign","malignant"))
table(x.validate$class)
   benign nalignant 
      139        71 
table(result)
result
   benign malignant 
      130        75 
table(x.validate$class,result) 混淆矩阵   左上和右下是对的,右上和左下是错的
           result
            benign malignant
  benign       129         6
  nalignant      1        69
自己的数据预测
newdata <- dplyr::sample_n(x,5)
newdata <- newdata[-10]
View(newdata)
predict(fit,newdata=newdata,type="response")


#R语言使用技巧
修改默认提示语言
Sys.getlocale() #显示系统语言
Sys.setenv(LANG="en") # 更换默认语言为英文

查看某个数据集内存大小
object.size(mtcars)
object.size(mtcars)/1024 #以kb显示

代码中换行  shift+enter
function(x,y) {
  
}

释放内存
install.packages("pryr")
library(pryr)
mem_used()  # 查看当前 R 会话的内存使用情况
rm(list = ls())
gc()

删除全部变量
显示全部变量内容
ls()
删除
rm(list=ls())
释放内存
gc()

边赋值边显示
(x <- runif(10))

快速获取函数选项参数
args(heatmap)

利用函数修改镜像
chooseCRANmirror()
chooseCRANmirror(ind = 18)

默认保留小数点
options('digits')
options('digits'=2)
options('digits')

管道
library(magrittr)
library(ggplot2)
mtcars %>% ggplot(aes(x=cyl,y=mpg,group=cyl))+geom_boxplot()

拆分列数据
attach(mtcars)
cyl
mpg

默认加载包
file.edit("~/.Rprofile")
.First <- function() {
  library(ggplot2)
}

为R添加额外扩展包加载路径
.libPaths()
.libPaths(new = "C:/Users/genom/Desktop/nparFiles/")
.libPaths()

迁移R包
在A设备上保存名字列表
oldip <- installed.packages()[,1]
save(oldip,file = "installedPacckages.Rdata")

在B设备上进行安装；
load("installedPacckages.Rdata")
newip <- installed.packages()[,1]
for (i in setdiff(oldip,newip)) {
  install.packages(i)
}

列出R包中的函数
ls(package:base)

不加载包使用其中函数
dplyr::filter()

快速获取颜色
rainbow(6)

炸开数据
library(magrittr)
women %$% plot(weight,height)

巧用example函数学习绘图
library(pheatmap)
example("pheatmap")

统计计算时间
system.time(runif(100000000))

恢复默认数据集
head(mtcars)
mtcars=1:10
mtcars
data("mtcars")
head(mtcars)

                                                                #R语言绘图系统介绍#
R语言具有强大的绘图功能,可以满足科研绘图的需求,越来越多的文章中采用R语言来进
行绘图。按照绘图方式,R语言可以分为四大绘图系统,分别是:1、R基础绘图系统,2、
Grid绘图系统,3、lattice绘图,4、ggplot2绘图。除此之外,R还有非常多的扩展包,几
乎可以完成任何形式的绘图要求,无论是2D绘图还是3D绘图。最新的shinny包,还可以
绘制交互式的绘图操作。

#成竹在胸
苏轼有云,“故画竹,必先得成竹於胸中”。这句话对于R语言绘图也同样适用。也就是我们
在进行画图之前，心里应该清楚我们要画的图大概是什么样子。比如描述数据分布的，可以
用散点图，直方图，热图，表现数据各部分百分比，可以用条形图，饼图，韦恩图，展示变
化趋势可以用折线图等。
数据可视化:https://www.data-to-viz.com/
R绘图合集:https://www.r-graph-gallery.com/
1、分布:散点图，密度图，直方图，直方图，小提琴图等
2、关系型:散点图，热图，相关性，气泡图等
3、变化趋势:条形图，雷达图，星云图，玫瑰风向图等
4、整体部分:堆叠（分组）条形图，饼图，树形图等
5、进化:折线图，面积图，时间序列图等

#数据维度
对于R语言绘图来说,最重要的其实是数据,也就是数据结构。每一个函数都有固定的数据
结构要求，所以在画图之前必须了解数据的维度，是一维数据还是二维数据还是多维数据。
以及是连续数据，还是分类数据。不同类型以及不同维度的数据采用不同的展现模式。一般
来说，数据的维数越高，展示起来越复杂。一维数据比较容易，一般常用点图，线图，饼图
等来展示。二维数据一般是矩阵，可以使用热图，条形图的等。对于多维数据，一般采用多
种元素来展现，例如，同一个点，可以通过点的大小对应（映射）数据大小，点的颜色，形
状对应分类数据。

#绘图获取帮助
R语言有非常完善的帮助系统,一般的绘图函数都有详细的帮助文档以及案例数据，可以通
过R自带的案例数据进行学习。了解每个函数所需数据结构。此外,可以通过example()函
数运行绘图函数自带的案例数据。然后在将自己的数据结构“做成”与案例数据结构一样的即
可。
example(boxplot)
demo (graphics)
demo(persp)

#绘图设备
默认R绘图展示在绘图窗口中,可以直接显示,可以通过设置修改默认绘图设备。绘图
设备也称为图形设备” (Devices)，指的是一个绘图的窗口或文件。默认的绘图设备为屏
幕显示,也可以直接保存为文件,不同的文件类型属于不同的绘图设备。R支持的常
用的绘图设备有以下几种：
分类                         R绘图设备                      含义描述
屏幕显示                        x11                      X 窗口/图形界面窗口
文件设备                     postscript                  ps 格式的矢量图文件
                               pdf                      pdf格式的矢量图文件
                               png                          png格式文件
                               jpeg                      jpg 格式的位图文件 
png,jpeg是像素图,不是矢量图,不能随意放大。pdf是矢量图,由代码构成,不会失帧。

在各种R的绘图设备中,最常用的为X11和pdf,X11在绘图调试过程中非常方便,不用每
次打开绘图文件，属于边绘图边查看的方式，所见即所得，这种交互式的方式适合调整图形，
例如修改不同的绘图选项参数。在确定最终绘图方式并生成图形文件进行保存时，推荐使用
pdf格式,因为R绘制的pdf图形为矢量图,pdf通用性较强,便于后期调整。绘制pdf图
形的函数为pdf()。

当绘图函数开始执行时,如果没有打开绘图设备,那么R将打开一个绘图窗口来展示这个图
形,默认打开的就是X11窗口,也可以使用命令x11()来直接打开一个绘图窗口。R可以
同时打开多个绘图设备，最近打开的设备将作为绘图时使用的设备，随后的所有图形都将
在这上面显示。函数dev.list() 可以显示所有打开的设备列表。
dev.list() 显示出的数字是设备的编号，要改变或关闭某一设备需使用这些编号，如使用
dev.off(3) 关闭的 是编号为 3 的 windows 绘图设备，当前使用的是编号为 4 的 pdf 绘图设
备。

dev.list()   把Rstudio自带的窗口扫掉!
NULL
pdf(file = "zty.pdf")   #第一步就是先生成一个绘图设备
pheatmap(state.x77)
plot(women,col="blue")
dev.list()              #在里面可以连续画各种图
pdf 
  2 
dev.off()               #最后关闭，保存到文件里面
null device 
          1 
jpeg(filename = "zty.jpg")
plot(women,col="blue")
pheatmap(state.x77)
dev.off()
null device 
          1 

#高级绘图与低级绘图
R的基础绘图来自于R的graphics包,是随R默认安装的,基础绘图可以完成一些常见的
图形。按是否能够自动创建新的图形,R的绘图函数可以分为两类——高级绘图函数和低级
绘图函数。高级绘图函数可以创建一个新的图形，低级绘图函数是在现有的图形上添加元素。
基础绘图主要绘制一些二维图形，例如点图，线图，直方图，饼图，条形图等，很多情况下，
这些图形使用Excel绘制更加容易,但是基础绘图是学习R绘图思想的基石,熟练掌握这些
函数的使用，也可以绘制出满足文献出版要求的图形。
R的绘图参数(graphical parameters)是控制绘图选项的，可以使用默认值、可以在绘制图形
时进行修改,也可以使用par函数进行修改。一般的,使用高级绘图命令绘制图形的框架,
使用低级绘图命令对图形进行补充。另外,R的绘图参数是对图形进行个性化修饰和调整
的,R的两种命令和绘图参数需结合使用。
help(package="graphics")
ls(package:graphics)   列出R默认的一些作图的包

#高级绘图命令
R中的高级绘图命令约有20多种,这里将最为常用的高级绘图命令概括如下:

绘图命令                         命令描述
plot(x)             以 x 的元素值为纵坐标，序号为横坐标绘制散点图
plot(x,y)                     x 与 y 的二元作图
pie(x)                            饼图
boxplot(x)                       盒形图
hist(x)                     x 的频率分布直方图
barplot(x)                    x 的值的柱状图
heatmap(mat)                      热图

#低级绘图命令
R中的低级绘图命令是针对现存图形的处理的,是对高级绘图命令产出的图形进行的补充。
下面是一些主要的低级绘图命令:

低级绘图命令                                      说明
points(x,y)                      与 plot 类似，向图中添加点(可以使用选项 type)
lines(x,y)                                   同points,但是添加线
text(x,y,labels,...)                     在(x,y)处添加用 labels 指定的文字
mtext(text,side=3)               在边上添加用 text 指定的文字,side 指定添加哪一条边
abline(a,b)                              绘制斜率为 b,截距为 a 的直线
abline(h=y)                               在纵坐标 y 处绘制一条水平线
abline(v=x)                               在横坐标 x 处绘制一条垂直线
legend(x,y,legend)                在点(x,y)处添加图例，图例内容由 legend 指定
axis(side,vect)                                 绘制坐标轴
rug(x)                                在 x-轴上用短线画出 x 数据的位置
box()                                      给当前的图形加上边框

#绘图参数  ？par
直接在R编辑器中输入命令par()或者par(no.readonly=TRUE,非只读的)把这个赋值给opar,列出当前可以改的参数有什么，画完图之后可以改回来。都可以获取当前的各个绘图参数。   
1、符号和线条
pch:指定绘制点所使用的符号，取值范围[0, 24]，其中 4 是“差号”,20 是“点”
cex:指定符号的大小。cex 是一个数值，表示 pch 的倍数，默认是 1.5 倍
lty:指定线条类型。lty=1 代表实线,2 至 6 都是虚线，虚的程度不一样
lwd:指定线条宽度,默认值为lwd=1,可以适当修改 1.5 倍、2 倍等
2、颜色
col:默认绘图颜色。某些函数(如 lines、pie)可以接受一个含有颜色值的向量，并自动循环使用。
col.axis:坐标轴刻度文字的颜色，不是坐标轴的颜色
col.lab:坐标轴标签(名称)的颜色
col.main:标题的颜色
col.sub:副标题的颜色
fg:图形的前景色
bg:图形的背景色
3、文本属性(用来指定字号、字体、字样)
cex.axis:坐标轴刻度文字的缩放倍数
cex.lab:坐标轴标签(名称)的缩放倍数
cex.main:标题的缩放倍数
cex.sub:副标题的缩放倍数
font:整数。用于指定字体样式。1 常规、2 粗体、3 斜体、4 粗斜体
4、图形尺寸与图形边界
pin:以英寸表示图形的宽和高
mai:以数值向量表示边界大小，顺序为"下、左、上、右"，单位为英寸
mar:以数值向量表示边界大小，顺序为"下、左、上、右"，单位为英分，默认值 c(5, 4, 4, 2)+0.1
5、标题
可以使用函数 title,格式为:title(main = " ", sub = " ", xlab = " ", ylab = " ")
6、坐标轴
axes=FALSE 将禁用全部坐标轴，框架和刻度全部没有了
xaxt="n" 禁用 x 轴的刻度线
yaxt="n" 禁用 y 轴的刻度线
xlim x 坐标轴的范围，只写出最小值和最大值
ylim y 坐标轴的范围，只写出最小值和最大值
side:一个整数。表示在图形的哪边绘制坐标轴(1=下,2=左,3=上,4=右)
at:一个数值向量，表示需要绘制刻度线的位置
labels:一个字符型向量(也可以是数值型)，表示刻度线旁边的文字标签(刻度值)，如果整个不
写，则直接使用 at 的值
col:线条和刻度的颜色
lty:线条类型
las:标签的字体是否平行(=0)或者垂直(=2)坐标轴
tck:刻度线的长度(默认值-0.01,负值表示刻度在图形外，正值表示刻度在图形内侧)
7、参考线
abline(h=yvalues, v=xvalues)
8、图例(legend)
legend(location, title, legend, ……)

#绘图函数包
R 语言绘图强大之处就在于 R 包含众多的绘图扩展包，几乎可以完成任何形式的绘图要求，
而且还在不断增加之后，下面列出了 28 个实用程序包。
图形                               软件包
地图                             cartogram
圈图                              circlize
圆形曼哈顿图                        CMplot
相关性图                          corrgram
时间序列数据的可视化               dygraphs
椭圆相关性                         ellipse
雷达图                              fmsb
时间序列分析                      forecast
散点图矩阵                         GGally
叠嶂图（山峦图）                   ggridges
二维直方图                         hexbin
网络图                             igraph
交互式地图                        leaflet
李克特量表数据的可视化              likert
地图                                maps
地图                               maptools
绩效指标计算与可视化           performanceAnalytics
交互式可视化                        plotly
统计质量控制                         qcc
曼哈顿图                            qqman
地图                                REmap
三维散点图                       scatterplot3d
脸谱图                          TeachingDemos
树图                              treemap
小提琴图                           vioplot

#基因长度分布直方图：连续数据，hist     

x <- read.table("Rdata/H37Rv.gff",sep = "\t",header = F,skip = 7,quote = "")
x <- x[x$V3=="gene",]
x %>% dplyr::filter(v3=="gene")
x <- abs(x$V5-x$V4+1)
x %>% dplyr::mutate(gene_length=abs(v5-v4)+1)
length(x)
range(x)
hist(x)
hist(x,breaks = 80)
hist(x,breaks = c(0,500,1000,1500,2000,2500,15000))   可以自己决定范围
hist(x,breaks = 80,freq = F)
hist(x,breaks = 80,density = T)
hist(rivers,density = T,breaks = 10)
?hist
h=hist(x,nclass=80,col="pink",xlab="Gene Length (bp)",main="Histogram of Gene
Length");     
h    可以从这个变量里面取需要用的值
rug(x);   x轴下面的毛毯，看清楚数据分布。
xfit<-seq(min(x),max(x),length=100);
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x));
yfit <- yfit*diff(h$mids[1:2])*length(x);   生成一个密度曲线
lines(xfit, yfit, col="blue", lwd=2);
grep "想找的东西"  文件名   >  自己定义一个文件


#饼图及扇形图
x <- read.csv("Rdata/homo_length.csv",header = T)
x <- x[1:24,]
barplot(height = x$length,names.arg = x$chr)
pie(x$length/sum(x$length))

m <- read.table("Rdata/Species.txt");
m
x <- m[,3]
pie(x);
pie(x,col=rainbow(length(x)))
lbls <- paste(m[,1],m[,2],"\n",m[,3],"%" )
pie(x,col=rainbow(length(x)),labels = lbls)
pie(x,col=rainbow(length(x)),labels = lbls,radius = 1)
pie(x,col=rainbow(length(x)),labels = lbls,radius = 1,cex=0.8)

#3D 饼图
install.packages("plotrix")
library(plotrix)
pie3D(x,col=rainbow(length(x)),labels = lbls)
pie3D(x,col=rainbow(length(x)),labels = lbls,cex=0.8)
pieplot <- pie3D(x,col=rainbow(length(x)),radius = 1,explode = 0.1)
pie3D.labels(pieplot,labels = lbls,labelcex = 0.8,height = 0.1,labelrad = 1.75)

#扇形图
fan.plot(x,col=rainbow(length(x)),labels = lbls,cex=0.8,radius = 1)

#条形图：分类数据，barplot  =直方图+饼图   既能分类又能比大小
hg19_len <- read.csv(file = "homo_length.csv",header = T)
hg19_24 <- hg19_len[1:24,]
barplot(height = hg19_24$length)
barplot(height = hg19_24$length,horiz = T, las = 2, border = F , width = c(1,2,3),space = 0.1,density = 30,柱状图里面用斜线代替,angle = 90,线的角度)  
par("mar")   par(mar=c(5,6,1,2))
barplot(height = hg19_24$length,names.arg = names(hg19_24$chr))
好看的颜色
library(RColorBrewer)
brewer.pal.info 查看详细信息
cols <- brewer.pal(n = 6,name = "Set1") 调色板的名字
barplot(height = hg19_24,names.arg = names(hg19_24),col = cols)

#分组条形图
x <- read.csv("Rdata/sv_distrubution.csv",header = T,row.names = 1)
x
barplot(x)
barplot(as.matrix(x))
barplot(t(as.matrix(x)))
barplot(t(as.matrix(x)),col = rainbow(4))
barplot(t(as.matrix(x)),col = rainbow(4),beside = T)  变成分组条形图,不用堆叠，小张要的那张图
barplot(t(as.matrix(x)),col = rainbow(4),legend.text = colnames(x))
barplot(t(as.matrix(x)),col = rainbow(4),legend.text = colnames(x),ylim = c(0,800))
barplot(t(as.matrix(x)),col = rainbow(4),legend.text = colnames(x),ylim = c(0,800), main = "SV Distribution",xlab="Chromosome Number",ylab="SV Numbers")

#箱线图
boxplot(len ~ dose, data = ToothGrowth)
boxplot(len ~ dose+supp, data = ToothGrowth)
boxplot(len ~ supp+dose, data = ToothGrowth,col = c("orange", "red"))  可以改变一下顺序  col=brewer.pal(2,"Set2") 可以把颜色对应的代码显示出来
boxplot(len ~ dose:supp, data = ToothGrowth,col = c("orange", "red"),notch=T)   让箱子变瘦一点
boxplot(len ~ dose:supp, data = ToothGrowth,col = c("orange", "red"),sep = ":",lex.order = T)

#小提琴图
install.packages("vioplot")
library(vioplot)
vioplot(len ~ supp+dose,data = ToothGrowth)
vioplot(len ~ supp+dose,data = ToothGrowth,col=rep(c("cyan","violet"),3))

#韦恩图  集合  最多5个
install.packages("venn")
library(venn)
listA <- read.csv("genes_list_A.txt",header=FALSE)
A <- listA$V1
listB <- read.csv("genes_list_B.txt",header=FALSE)
B <- listB$V1
listC <- read.csv("genes_list_C.txt",header=FALSE)
C <- listC$V1
listD <- read.csv("genes_list_D.txt",header=FALSE)
D <- listD$V1
listE <- read.csv("genes_list_E.txt",header=FALSE)
E <- listE$V1
alist <- list(A,B,C,D,E)
alist
venn(alist)
venn(alist[1:3],ellipse = TRUE)
venn(alist,snames = "A,B,C,D,E", counts = NULL, ilabels = FALSE, ellipse = FALSE,
zcolor = "bw", opacity = 0.3, size = 15, cexil = 0.6, cexsn = 0.85,borders = TRUE)
venn(alist,col = "red",zcolor = "blue")
venn(alist,col = c("red","blue"),zcolor = c("blue","green"))
venn(alist[1:4],col = c("red","blue"),zcolor = c("blue","green"),ellipse = T)
H <- venn(alist[1:4],zcolor = rainbow(5),ellipse = T,ilabels =T )  保存到一个变量里面,可以看到详细的信息

#绘图布局
#mfrow、mfcol
opar <- par(no.readonly = TRUE)   把可以改的变量保存起来
par(mfrow=c(2,2))                 分成两行两列
par(mfcol=c(2,2))                 按列排
layout.show(4) 
par(ask=FALSE)
par("mar")                        1下2左3上4右
par(mar=c(5.1,4.1,4.1,2))
plot(pressure,col="red",main="Pic 1") 
barplot(table(mtcars$cyl),col = c("red","cyan","orange"),main = "Pic 2")
hist(rivers,breaks = 30,col = "pink",main = "Pic 3")
pie(c(1,3,4,2),labels = c("A","B","C","D"),main = "Pic 4")

#layout布局
layout(mat = matrix(c(1,2,3,4),nrow = 2, byrow = T)) 画四个图,按两行两列来分。
layout.show(4)
layout(mat = matrix(c(1,1,2,3),nrow = 2, byrow = T))   不等分
layout.show(3)
layout(mat = matrix(c(1,0,0,2,2,0,3,3,3),nrow = 3, byrow = T))
layout.show(3)
layout(matrix(c(1,2)),heights = c(2,1))
layout.show(2)
绘图
barplot(table(mtcars$cyl),col = c("red","cyan","orange"),main = "Pic 2")
plot(pressure,col="red",type="l",main="Pic 1")
layout(matrix(c(0,2,0,0,1,3),2,3,byrow=T),widths = c(0.5,3,1),heights = c(1,3,0.5),TRUE)
layout.show(3)
plot(pressure,col="red",main="Pic 1")
barplot(table(mtcars$cyl),col = c("red","cyan","orange"),main = "Pic 2")
hist(rivers,breaks = 30,col = "pink",main = "Pic 3")

#恢复
par(opar)

                                                                   #ggplot2绘图#
                                                              
ggplot2包提供了一个基于全面而连贯的语法的绘图系统。它弥补了R中创建图形缺乏一致性的缺点,使得用户可以创建有创新性的、新颖的图形类型。ggplot2是R语言绘图一个重
要特性和优势。通过ggplot2,只需少量的代码,就可以绘制出高质量的图形,满足出版需要。ggplot2语法简介,逻辑清晰,功能强大,可以快速上手。在R语言中自成一派,目前
也有越来越多的绘图包基于ggplot2进行二次开发,一般都是以“gg”开头,例如ggpubr,ggtree,ggvis,ggtree,ggstatsplot等。

#图形语法
ggplot2采用一套新的图形语法,其中gg就表示图形语法(grammar of graphic),理解了这套语法就理解了ggplot2绘图。
传统的R绘图称为“画家模式”,首先布局一块画布,然后在画布上添加点线面,而ggplot2采用图层的方式,类似于“Photoshop”模式,通过累加不同的图层元素来绘图。

ggplot2的图层语法如下所示:
1、数据(Data)
ggplot2绘图需要一个数据框,通过data选项添加。
colnames(mtcars)
ggplot(data=mtcars)

2、映射(Mapping)
映射是ggplot2中最重要的一个概念,将数据对应到不同的图形属性。通过mapping选项
添加,然后使用aes()函数,aes来自于aesthetics(美学，美的哲学),数据可以分别映射到x
轴与y轴,同时可以添加更多属性,例如点的大小,形状,颜色,透明度等属性,映射完成
之后ggplot会自动分配图形显示比例。
range(mtcars$mpg)
[1] 10.4 33.9
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg))

3、几何对象(Geometric)
映射完成之后，就可以直接出图，根据映射数据的特点展示不同的图，需要注意数据的类型，
是离散型数据还是连续型数据，例如绘制条形图，箱线图等，必须包含离散数据。
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg,size=mpg)) + geom_point()
mtcars$cyl <- as.factor(mtcars$cyl) 因为不接受连续型变量
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg,size=mpg,shape=cyl)) + geom_point()
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg,size=mpg,shape=cyl,color=cyl)) +geom_point(size=6)  画点和线的时候才用color    填充色一般用 fill = AgeGroup 
如果不想在映射里面设置颜色,感觉太多了,可以在geom_point()里面加上。

4、标尺(Scale)            修改每一个映射部分,就是你映射里面已经定义了很多东西,比如说color,fill等等,都在这里改。
标尺用于重新调整默认的图形属性，例如修改坐标刻度，颜色属性等。
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg,color=mpg)) + geom_point()+
scale_color_gradient(low = "orange",high = "red")  渐变色,这个适合连续型变量，+scale_color_discrete(type=rainbow(3))/(type=c("blue","orange","red"))自己指定,适合离散型数据,因子。

5、统计变换(Statistics)
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()+
 stat_smooth( method = 'loess' ,formula = 'y ~ x')

6、坐标(Coordinate)
坐标系统控制坐标轴,可以修改坐标轴范围,转换xy轴,笛卡尔坐标和极坐标转换。
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()+coord_flip()  把x,y轴换一下

7、图层(Layer)
类似于Photoshop的图层概念,直接使用+号即可实现图层叠加，一张图内展示更多内容。  先放箱子再放点,就不会被遮住。
ggplot(data=mtcars, mapping = aes(x=cyl, y=mpg)) + geom_point()+geom_boxplot()

8、面(Facet)
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()+facet_grid(. ~ cyl) 这个是按列分,(cyl ~ .)这个就是按行分。

9、主题(Theme)
主题是一些元素默认设置构成的整体,ggplot2默认的主题是其简单设置就可以生成高质量
的图片,无需进行更多修改。此外,除了默认的主题(theme_gray)之外,ggplot2 还内置
了许多其他的主题，可以快速切换，类似与手机系统一键更换主题一样容易。
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()+theme_bw()
install.packages(hrbrthemes)

10、保存绘图
p <- ggplot(data=mtcars, mapping = aes(x=wt, y=mpg)) + geom_point()+theme_bw()
ggsave(filename = "mtcars.pdf",plot = p)

#ggplot 常用绘图函数
函数                      添加                          选项
geom_bar()	             条形图	                 color, fill, alpha	
geom_boxplot()	         箱线图	             color, fill, alpha, notch, width	
geom_density()	         密度图	               color, fill, alpha, linetype	
geom_histogram()	     直方图	           color, fill, alpha, linetype, binwidth	
geom_hline()	         水平线	               color, aplha, linetype, size	
geom_jitter()	         抖动点	               color, size, alpha, shape	
geom_line()	              线图	               colorvalpha, linetype,size	
geom_point()	         散点图	               color, alpha, shape, size	
geom_rug()	             地毯图	                    color, sides	
geom_smooth()	        拟合曲线	     method, formula, color, fill, linetype, size	
geom_text()	            文字注解	           这个非常多,参考相应文档	
geom_violin()	        小提琴图	          color, fill, alpha, linetype	
geom_vline()	          垂线	              color, alpha, linetype, size

#ggplot2常用绘图选项参数
选项                        详述
color	          对点、线和填充区域的边界进行着色	
fill	          对填充区域着色，如条形和密度区域	
alpha	          颜色的透明度,从0(完全透明)到1(不透明)	
linetype          图案的线条(1=实线,2=虚线,3=点,4=点破折号,5=长破折号,6=双破折号)	
size	          点的尺寸和线的宽度	
shape             点的形状(和pch一样,0=开放的方形,1=开放的圆形,2=开放的三角形等等)
position          绘制诸如条形图和点等对象的位置。对条形图来说，'dodge'将分组条形图并排，'stacked'堆叠分组条形图，'fill'垂直地堆叠分组条形图并规范其高度相等。对于点来说，'jitter'减少点重叠。
binwidth          直方图的宽度
notch	          表示方块图是否应为缺口(TRUE/FALSE)	
sides             地毯图的安置("b"=底部，"I"=左部，"t"=顶部，"r"=右部,“bI”=左下部,等等
width	          箱线图的宽度

#ggplot2 绘图案例

#散点图
x <- read.table("Rdata/prok_representative.csv",sep = ",",header = T); 
head(x)
ggplot(data = x,aes(x=Size,y=Genes))+geom_point()
ggplot(data = x,aes(x=Size,y=Genes))+geom_point(size=1,color="blue")
fit <- lm(data = x,Genes~ Size)
fit
ggplot(data =x,aes(x=Size,y=Genes))+geom_point(size=1,color="blue")+geom_abline(intercept =286.6,slope = 843.7,col="red",lwd=1)
p <- ggplot(data =x,aes(x=Size,y=Genes))+geom_point(size=1,color="blue")+geom_abline(intercept =286.6,slope = 843.7,col="red",lwd=1)
p+annotate(geom = "text",x=4,y=10000,label="y=286x+842.7\nR2=0.9676")
p+annotate(geom ="text",x=4,y=10000,label="y=286x+842.7\nR2=0.9676")+labs(title="Genome Size vs Gene Number",x="Genome Size",y="Genes")  加标题

#直方图    只需要一个向量，不是数据框，没有数据框就直接NULL就行了。
library(tidyverse)
x %>% dplyr::filter(V3=="gene",) %>% dplyr::mutate(gene_length=abs(V5-V4)+1) %>% ggplot(aes(x=gene_length))+geom_histogram()
x <- read.table("Rdata/H37Rv.gff",sep = "\t",header = F,skip = 7,quote = "") 
x <- x[x$V3=="gene",] 
x <- abs(x$V5-x$V4+1) 
length(x) 
range(x) 
ggplot(data = NULL,aes(x=x))
ggplot(data = NULL,aes(x=x))+geom_histogram(bins = 80)
ggplot(data = NULL,aes(x=x))+geom_histogram(bins = 80)+geom_rug() 

#条形图
hg19_len <- read.csv(file = "Rdata/homo_length.csv",header = T)
x <- hg19_len[1:24,] 
hg19_len %>% dplyr::slice(1:24)   按行筛选
ggplot(data = x,aes(x=chr,y=length,fill=chr))+geom_bar(stat = "identity")  在这里指定是分组条形图还是堆砌条形图 
p <- ggplot(data = x,aes(x=chr,y=length,fill=chr))+geom_bar(stat = "identity") 有问题,x轴默认是按计算机asii码排的,要该成按顺序排
ggplot(data = x,aes(x=chr,y=length,fill=chr))+geom_bar(stat = "identity")+scale_x_discrete(limits=x$chr[1:24])
p+scale_x_discrete(limits=x$chr)
p+scale_x_discrete(limits=x$chr)+coord_flip()
p+scale_x_discrete(limits=x$chr)+coord_flip()+guides(fill=FALSE)  不用图例
scale_fill_manual(values = c(rep(brewer.pal(4,"Set1"),6)))

#分组条形图
x <- read.csv("Rdata/Rdata/sv_distrubution.csv")
head(x)          你画图的时候x,y的取值只有两列
  X Contraction Deletion Expansion Insertion
1 1          97      183       234       265
2 2         134      193       135       240
3 3         113      134       122       196
4 4         116      159       111       144
5 5          99      138       114       156
6 6         100      126       156       186
svs <- x %>% tidyr::pivot_longer(cols = 2:5,names_to = "Variation")   所以啊就要把这种宽数据转成长数据,变量的名字都可以自己定义
ggplot(data = svs,aes(x=X,y=value))+geom_bar(stat = "identity")
ggplot(data = svs,aes(x=X,y=value,fill = Variatio))+geom_bar(stat = "identity")
p <- ggplot(data = svs,aes(x=X,y=value,fill = Variatio))+geom_bar(stat = "identity",position="dodge") 这个position参数就是指定分组/堆叠条形图stack,fill指的就是把柱子填满,然后按%看。
p
p+scale_x_discrete(limits=x$X) 改x轴的顺序
p+scale_x_discrete(limits=x$X)+scale_fill_brewer(palette = 4,type = "seq")  改颜色,type指定的是数据类型,可以不加。
p+labs(title ="SV Distribution",x="Chromosome Number",y="SV Numbers")  加标题
p+labs(title ="SV Distribution",x="Chromosome Number",y="SV Numbers")+theme(legend.position = "bottom")  放图例的位置
p+labs(title ="SV Distribution",x="Chromosome Number",y="SV Numbers")+theme(legend.position = "bottom",plot.title = element_text(hjust = 0.5))+guides(fill="none")  把标题的位置放在中间,把图例去掉。


#饼图   加个极坐标系
m <- read.table("Rdata/Species.txt");
y <- paste(m[,1],m[,2])
x <- data.frame(name=y,values=m$V3/sum(m$V3))
p <- ggplot(data = x,aes(x = "",y=values,fill=name))+geom_bar(stat ="identity",width = 1)+guides(fill=FALSE)   就是不要X轴了呗,粘在一起的数据单纯只是为了分组。
p
p+coord_polar(theta = 'y')+labs(x = '', y = '', title = '')

#箱线图   x轴必须是因子，y轴必须是数字
head(ToothGrowth)
ToothGrowth$dose <- as.factor(ToothGrowth$dose)   这一步很重要啊,连续型数据要改成因子才行！
按提供药物种类分组
ggplot(data = ToothGrowth,aes(x=supp,y=len,fill=supp))+geom_boxplot()
按剂量分组
ggplot(data = ToothGrowth,aes(x=dose,y=len,group=dose,fill=dose))+geom_boxplot()
两组
ggplot(data = ToothGrowth,aes(x=dose,y=len,group=supp:dose,fill=supp:dose))+geom_boxplot()
ggplot(data = ToothGrowth,aes(x=supp,y=len,fill=supp,group=supp:dose))+geom_boxplot()
分面,就是师姐她们画的那些图,每一个面里面也就只有一个和上面对应的坐标了！
ggplot(data = ToothGrowth,aes(x=supp,y=len,fill=supp,group=supp:dose))+geom_boxplot()+facet_grid(~ supp,scales = "free")

#box图加抖动点
ggplot(data =ToothGrowth,aes(x=supp,y=len,fill=supp))+geom_boxplot()+geom_jitter(aes(x=supp,y=len),width = 0.1)
ggplot(data =ToothGrowth,aes(x=dose,y=len,group=dose,fill=dose))+geom_boxplot()+geom_jitter(aes(x=dose,y=len),width = 0.1)

#小提琴图
ggplot(data = ToothGrowth,aes(x=supp,y=len,fill=supp))+geom_violin() 
ggplot(data = ToothGrowth,aes(x=supp:dose,y=len,fill=supp))+geom_violin()  分组
把箱子画上
ggplot(data =ToothGrowth,aes(x=supp,y=len,fill=supp))+geom_violin()+geom_boxplot(width=0.1,fill="white")


                                                 theme,改标题的部分     #修改主题#    scale,改数据的部分

#修改默认主题
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=cyl)) +geom_boxplot()
ggplot(data = mtcars,mapping = aes(x=wt,y=mpg,colour = factor(cyl)))+geom_point(size=3)
p
p+theme(legend.position="top",legend.background = element_rect(color = "red"))要指定好图例的具体位置,比如说图例背景的那个矩形框(rect)。
p+theme(legend.position="none",legend.title = element_text(size = 22,colour = "red"))图例上的文本
p+theme(axis.title = element_text(size = 22,angle = 90))同时修改x,y轴。
p+theme(legend.text = element_text(colour = "red"))  图例字体颜色
p+theme(panel.grid = element_line(color = "red"))    改坐标系里面的线
p+theme_bw()
p+theme_classic()
p+theme_void()
p+theme_light()
p+theme_linedraw()


#去除图例三种方法
p <- ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+geom_boxplot()
p
一：使用 guides()
p+guides(fill=FALSE)
二：
p+theme(legend.position = "none")
三：
p+scale_fill_discrete(guide=FALSE)


#默认修改颜色
离散型数据  discrete  
mtcars$cyl <- as.factor(mtcars$cyl)
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=cyl)) +geom_boxplot()
p+scale_fill_brewer(palette = "Set2")
p+scale_fill_manual(values = c("red","green","blue"))

连续型数据
p <- ggplot(mtcars, aes(x=wt, y=mpg,color=mpg)) +geom_point()
两种渐变色
p+scale_color_gradient(low = "yellow",high = "red")
三种渐变色
p+scale_color_gradient2(low = "yellow",mid = "orange",high = "red")

#ggsci:科学文献配色
install.packages("ggsci")
library(ggsci)
mtcars$cyl <- as.factor(mtcars$cyl)
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=cyl)) +geom_boxplot()
p
help(package="ggsci")
p+scale_fill_aaas()
p+scale_fill_npg()
p+scale_fill_nejm()
p+scale_fill_jama()
p+scale_fill_lancet()    一一对应

#ggthemes:常见期刊主题     相当于手机的主题
install.packages("ggthemes")
library(ggthemes)
mtcars$cyl <- as.factor(mtcars$cyl)
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=cyl)) +geom_boxplot()
p
p+theme_economist()
p+theme_wsj()
p+theme_excel()
p+theme_stata()

#修改坐标系
x <- read.csv("Rdata/sv_distrubution.csv",header = T) 
x 
svs <- x %>% gather(key = Variation,value =Number,-X)
p <- ggplot(data = svs,aes(x=X,y=Number,fill=Variation))+geom_bar(stat ="identity")
p

交换xy轴
p+coord_flip()
修改极坐标：玫瑰风向图
p+coord_polar()
p+coord_polar()+guides(fill=FALSE)

#分面
library(gcookbook)
p <- ggplot(mpg,aes(x=displ,y=hwy,color=drv))+geom_point(size=3)
横向分面
p+facet_grid(drv ~ .)
纵向分面
p+facet_grid(.~cyl)
两个条件分面
p+facet_grid(drv ~ cyl)
facet_wrap()分面
p+facet_wrap( ~ class)
p+facet_wrap(~ class,nrow = 2)
使用不同坐标
ggplot(mpg,aes(x=displ,y=hwy))+geom_point()+facet_grid(drv ~ cyl,scales = "free_y")


#布局与组合
利用ggExtra布局
library(ggplot2)
library(ggExtra)
head(mtcars)
p <- ggplot(mtcars, aes(x=wt, y=mpg, color=cyl, size=cyl)) +geom_point() +theme(legend.position="none")
p1 <- ggMarginal(p, type="histogram", size=10)
p1
p2 <- ggMarginal(p, type="histogram", fill = "slateblue", xparams =list( bins=10))
p2
p3 <- ggMarginal(p, margins = 'x', color="purple", size=4)
p3

利用gridExtra组合图形
library(ggplot2)
library(gridExtra)
g1 <- ggplot(mtcars, aes(x=qsec)) + geom_density(fill="slateblue")
g2 <- ggplot(mtcars, aes(x=drat, y=qsec, color=cyl)) + geom_point(size=5) +theme(legend.position="none")
g3 <- ggplot(mtcars, aes(x=factor(cyl), y=qsec, fill=cyl)) + geom_boxplot() +theme(legend.position="none")
g4 <- ggplot(mtcars , aes(x=factor(cyl), fill=factor(cyl))) + geom_bar()
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 2)
grid.arrange(g1, g2, g3, nrow = 3)
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 1)
grid.arrange(g2, arrangeGrob(g3, g4, nrow=2), nrow = 1)
ggsave(filename="zty.pdf",device ="",)   保存图片,可以指定想要的类型。但是这样保存多个图的时候会失帧


#更多主题
ggpubr绘图
ggpubr实际上是基于ggplot2开发出来的包,目的是为了简化ggplot2的操作,便于画出满足论文出版要求的图。
ggpubr是基于ggplot2开发,只是默认添加了很多内容,普通用户绘制科学文献绘图更容
易。ggpubr的使用也比较简单,只需要将对应的函数替换一下即可。ggpubr的函数一般都
是gg前缀开头,比如ggpie,ggline,gghistogram,ggviolin,ggboxplot等。

library(ggpubr)
help(package="ggpubr")
?ggviolin
ggviolin(ToothGrowth, x = "dose", y = "len",add = "jitter", shape = "dose")
ggviolin(ToothGrowth, "dose", "len", fill = "dose",palette = c("#00AFBB","#E7B800", "#FC4E07"),add = "boxplot", add.params = list(fill = "white"))

#plotly交互绘图
library(plotly)
packageVersion('plotly')
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=cyl)) +geom_boxplot()
ggplotly(p)



                                                                    #科学文献绘图#
#文字云图
install.packages(c("Rwordseg","wordcloud2"))
library(Rwordseg)
library(wordcloud2)
x <- readLines("政府工作报告.txt",encoding = 'UTF-8')
head(x)
开始分词,可以使用 system.time()函数计时
y <- segmentCN(strwords = x,analyzer = "hmm",returnType = "vector")
y[1:3]
system.time(y <- segmentCN(strwords = x,analyzer = "hmm",returnType = "vector"))
拆分列表为向量
y <- unlist(y)
过滤数字
y <- y[!grepl('[0-9]',y)]
过滤空白以及单个词
y <- y[nchar(y)>=2]
统计频数
table(y)
排序获得前 50 个关键字
top50 <- sort(table(y),decreasing = TRUE)[1:50]
top50
绘图
wordcloud2(top50)
修改形状和配色
wordcloud2(top50,shape = "star",color =rep_len(c("red","darkred"),length(top50)))


#相关性图
相关分析图又称散布图，是通过绘制两个变量之间的散布图，计算相关系数等、分析确定质
量特性和影响质量的因素之间、质量特性和质量特性之间、质量影响因素和质量影响因素之
间是否有相关关系、相关关系密切程度如何，从而通过一个变量的改变实现对另一个变量的
控制。R中corrplot包可以用于绘制相关性。输出数据为一个数值矩阵后者相关性矩阵。
install.packages("corrplot")
library(corrplot)
help(package="corrplot")
corrplot(as.matrix(mtcars),is.corr = F)  未进行相关性计算
M <- cor(mtcars)
corrplot(M,type = "upper")  
corrplot(M,method = "ellipse")
corrplot(M,method = "shade")
corrplot(M,method = "color")
corrplot(M,method = "shade")
corrplot(M,method = "circle")
corrplot(M,method = "pie",type = "upper")        只要右上角那一部分。
corrplot(M,method = "circle",type = "lower")
corrplot(M, order = "AOE", type = "upper", tl.pos = "d")
corrplot(M, p.mat = res1$p, insig = "p-value")

#曼哈顿图
曼哈顿图(manhattan plot),是一种类似曼哈顿摩天大楼排列的一种展示图。如下图所示。
美国纽约曼哈顿区。manhattan图即模拟曼哈顿高低起伏的摩天大楼而成,类似一种条形图。
在生物和统计学上,做频率统计、突变分布、GWAS关联分析的时候,经常需要绘制
manhattan图,用来展示每条染色体上SNP的分布及频率变化,能够对候选位点的分布和
数值一目了然。在R中,可以利用qqman包来绘制Manhattan图,Plink软件的输出结果可
以直接作为输入数据进行绘图。
install.packages("qqman")
library(qqman)
library(RColorBrewer)
str(gwasResults)
head(gwasResults)
manhattan(gwasResults)
manhattan(gwasResults, main = "Manhattan Plot", ylim = c(0, 6), cex = 0.6,cex.axis = 0.9, col = c("blue4", "orange3"), suggestiveline =F, genomewideline = F,chrlabs = c(1:20, "P", "Q"))
unique(gwasResults$CHR)
number <- length(unique(gwasResults$CHR))
yanse <- brewer.pal(n = 4,name = "Set1")
manhattan(gwasResults, main = "Manhattan Plot", ylim = c(0, 6), cex = 0.6,cex.axis = 0.9, col = yanse, suggestiveline = F, genomewideline = F,chrlabs = c(1:20, "P", "Q"))
manhattan(subset(gwasResults,CHR==3))
高亮显示部分SNP结果
snpsOfInterest
manhattan(gwasResults, highlight = snpsOfInterest)
注释SNP结果
manhattan(gwasResults, annotatePval = 0.001)                      只显示最高的那个点
manhattan(gwasResults, annotatePval = 0.001, annotateTop = FALSE) 这样把全部的点都显示出来了
更多内容可以查看manhattan与qqman 的帮助文档
help("manhattan")
vignette("qqman")

#地图
R可以直接绘制热图,并根据数据大小对地图进行涂色。
library(maps)
library(mapdata)
library(ggplot2)
world_map <- map_data("world")
查看全部区域
world_map$region
unique(world_map$region)
sort(unique(world_map$region))
获取某一地区地图数据
states_map <- map_data("state")
绘制地图,使用geom_polygon()或者geom_path()
ggplot(states_map,aes(x=long,y=lat,group=group))+geom_polygon(fill="white",color="black")+coord_map("mercator")
ggplot(states_map,aes(x=long,y=lat,group=group))+geom_path()+coord_map("mercator")
数据映射到地图
crimes <- data.frame(state=tolower(rownames(USArrests)),USArrests)    小写,为了可以合并
crimes
states_map <- map_data(map="state")
crime_map <- merge(states_map,crimes,by.x = "region",by.y = "state")
library(dplyr)
dplyr::arrange(crime_map,group,order)
crime_map <- dplyr::arrange(crime_map,group,order)
ggplot(crime_map,aes(x=long,y=lat,group=group,fill=Assault))+geom_polygon(color="black")+coord_map("mercator")

#树形图
library(factoextra)
dd <- dist(mtcars,method = "euclidean")  算两两之间的距离
dd
hc <- hclust(dd,method = "ward.D2")
plot(hc)
fviz_dend(hc)
fviz_dend(hc,k=4)  聚成4类
fviz_dend(hc,k=4,cex = 0.8,k_colors = rainbow(4))
fviz_dend(hc,k=4,cex = 0.8,k_colors = rainbow(4),ccolor_labels_by_k = FALSE,rect_border = rainbow(4))
fviz_dend(hc,k=4,cex = 0.8,ccolor_labels_by_k = FALSE,rect_border = rainbow(4),rect = TRUE,rect_fill = TRUE)
fviz_dend(hc,k=4,horiz = TRUE,type = c("circular"))
fviz_dend(hc,k=4,horiz = TRUE,type = c("rectangle"))
fviz_dend(hc,k=4,horiz = TRUE,type = c("phylogenic"))

#和弦图
和弦图(chord Diagram)，是一种显示矩阵中数据间相互关系的可视化方法，节点数据沿圆周
径向排列，节点之间使用带权重（有宽度）的弧线链接。和弦图是表示数据之间相互关系的
图形方法。节点围绕着圆周分布，点与点之间以弧线彼此连接以显示当中关系，通过每个圆
弧的大小比例给每个连接分配数值。此外，还可以通过颜色将数据分类，直观地进行比较和
区分。
之前的“基因组圈图”也是一种和弦图，用来展示基因组之间相互关系。
和弦图的输入数据非常简单,主要是一种关联,最简单的分为三列。source字段、target
字段、和value字段,也就是从哪里到哪里,然后就是数值。source和target确定连接关系,
为字符型,value确定关系大小,展示连接关系大小。
更复杂的和弦图可以使用Circos软件绘制。
install.package("circlize")
library(circlize)
library(RColorBrewer)
help(package="circlize")
set.seed(999)
mat<-matrix(sample(18, 18), 3, 6)
rownames(mat) <- paste0("S", 1:3)
colnames(mat) <- paste0("E", 1:6)
df<- data.frame(from = rep(rownames(mat), times = ncol(mat)),to = rep(colnames(mat), each = nrow(mat)),value = as.vector(mat),stringsAsFactors = FALSE)
chordDiagram(df,grid.col = brewer.pal(9,"Set1")[1:9],link.border="grey")
circos.clear()
chordDiagram(mat,grid.col = brewer.pal(9,"Set1")[1:9],link.border="grey")
circos.clear()
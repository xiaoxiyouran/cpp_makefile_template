# cpp makefile 项目模板

cpp 项目模板：

```sh
user00|12:46:32@~/xixie/xi_git_oa/gdb/project$ tree
.
├── bin
│   └── main
├── build.sh
├── include
│   └── func.h	# 头文件目录
├── Makefile
├── obj
│   ├── func.o
│   └── main.o
├── Readme.md
└── src			# 实际的项目文件路径
    ├── func.cpp
    └── main.cpp

```



make 即可, 产生中断

```sh
 kill  -s SIGSEGV 26378
```

cpp 程序：

```cpp
#include<iostream>
#include<vector>
using namespace std;
int main ()
{
	cout << "hello world"  << endl;
	vector<int> u(3,0);
	u[0]=5;
	u[1]=2;
	int a[1] = {0};
	a[2] = 2;
	cout <<"no core" << endl;
	while(1);
	cout <<"end" << endl;
	return 0;
}
```



实际测试：

```sh
(gdb) p u
$1 = std::vector of length 3, capacity 3 = {[0] = 5, [1] = 2, [2] = 0}

# 打印vector 的内容
(gdb) print *(u._M_impl._M_start)@3
$2 = {[0] = 5, [1] = 2, [2] = 0}

# +n ，打印指定元素的下标
(gdb) print *(u._M_impl._M_start+0)
$3 = 5
(gdb) print *(u._M_impl._M_start+1)
$4 = 2
(gdb) print *(u._M_impl._M_start+2)
$5 = 0

```






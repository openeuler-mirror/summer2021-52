# 项目信息

- 项目名称：将 per-memcg LRU lock 特性移植到 openEuler 的内核上

- 官方项目 git 仓库：[链接点我](https://gitee.com/openeuler-competition/summer2021-52)

- 方案描述：

  - 首先利用 Linux 中 patch 命令可以方便的将补丁修改内容加入openEuler 当前版本中。在打补丁过程中，通过定位具体的文件，找到补丁冲突的地方，参考当前内核代码对补丁进行适当修正。解决掉所有补丁冲突后，对内核进行重新编译
  - 建立一套可以运行 openEuler 内核的虚拟 QEMU 环境。通过 ubuntu 文件系统的加持，可以很好的在虚拟环境中进行各种常见的 linux 操作，例如下载 wget 和安装软件 apt install。
  - 准备运行多线程测试用例的环境，包括 docker 软件的安装，测试程序来自 https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/，仓库中含有一个 readtwice 的测试程序，是对 linux 的内存管理的一个很好的压力测试

  ​

# 项目进度

- 已完成工作：

1. 已完成 openEuler 内核测试和编译环境的搭建，利用 QEMU 虚拟机强大的仿真功能和 ubuntu 文件系统，成功在服务器上跑起来openEuler 内核的运行。
  ​

2. 已完成总计 19 个所有补丁的打入，目前在 openEuler 的 21.03 版本上进行打补丁，总共多出 19 条 commit 信息因为 21.03 的内核版本与这个官方的补丁前的版本十分接近，所有的补丁冲突都是未对齐的行数导致的，共有四处。还存在一个对于代码注释的补丁冲突，由于注释并不会对代码造成影响，这一部分冲突的补丁已经进行了手动删除。
  ​
  已经打好补丁的内核代码和 QEMU 运行所需的文件都已经上传官方gitlab 仓库，同时，我在 gitee 上还进行了备份。同样的，成功打入补丁的 openEuler 内核代码我也单独存放在一个 gitee 仓库中，参考：
  https://gitee.com/wang-kn/kernel

  memcg官方的补丁，[参考](https://patchwork.kernel.org/project/linux-mm/cover/1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com/)

  ## 后续工作安排：

  后面在现有测试环境中，借鉴 docker 软件启动多线程，成功执行 vm-scalibility 中自带的 readtwice 测试用例。其次，通过对测试结果的对比分析，并撰写出这次补丁对于内核性能影响的分析报告，完成项目最后的部分

## 遇到的问题及下一步解决方案：（后续工作交接）

- 问题一：安装 docker 软件，由于测试用例需要采用多线程的测试，需要在启动的内核虚拟机中安装docker环境。安装 docker 软件较为复杂，这里参考了菜鸟教程安装，[参考点这里](https://www.runoob.com/docker/ubuntu-docker-install.html). 在启动的虚拟机中安装使用一键脚本可能会失败，具体可以参考菜鸟教程后面的自行安装或deb安装教程，最终成功安装了 docker 软件。但是运行 memcg 测试程序的 docker 程序运行失败。具体参考下面问题二 memcg 测试用例的描述。docker 错误信息：Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?。参考了网上的解决方案使用 sudo service docker restart，之后还是出问题 Job for docker.service failed because the control process exited with error code.
- 问题二：memcg 测试用例，这个测试用例采用了 google kernel source 中的 vm-scalability.git 的测试程序中的 lru-file-readtwice 这个 case。由于要改为多线程测试用例，还要借助 docker 运行，所以不能采用官方 git 中运行方法，跑测试的一键运行脚本我已经放在了官方 git 仓库中的 dockertest 的文件夹中，在安装好 docker 软件后，只需要运行 run_readtwice.sh 即可。在本地服务器上亲测可用，只是 qemu 虚拟机中还不太行。这 dockertest 文件夹中的所有文件都来自 linux 官方社区的交流网站中，[参考点这里](https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/).  
- 其他方法：由于 qemu 启动内核的方法一直在启动后出现各种问题，我还参考了本地虚拟机替换为编译好的 openEuler 内核的方法，参考[这里](https://blog.csdn.net/m0_56602092/article/details/118604262)。在本地虚拟机 ubuntu18.04 中成功编译加了补丁的 openEuler 内核后，采用参考中的方法替换内核后，重启后虚拟机自动变成 ubuntu 20.04，并且后续安装 docker 软件也出现未知错误。这条路暂时也未走通。**这里需要注意的点是**，编译自己修改了内核代码的内核时，由于内核中含有签名机制，可能会出现签名校验不过的情况，这时候需要在编译前的menuconfig中disable掉签名校验，[参考](https://zhuanlan.zhihu.com/p/99483997)。具体的地方是，security settings中的 intergrity settings 全部关掉。




---

在这个项目开发过程中参考的链接：

[memcg 血泪史](https://blog.csdn.net/bjchenxu/article/details/112504932)

[搭建qemu-x86_64运行环境](https://www.cnblogs.com/pengdonglin137/p/6442624.html)

[搭建linux内核开发环境](https://blog.csdn.net/weixin_38227420/article/details/88402738?utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-4.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-4.control)

[ubuntu文件系统制作](https://www.cnblogs.com/pengdonglin137/p/9540670.html)

[vmscalability官方git仓库](https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/about/)

[创建ubuntu根文件系统](https://www.cnblogs.com/kay2018/p/10990648.html)

[内核编译配置选项](https://www.cnblogs.com/zengkefu/p/6372232.html)




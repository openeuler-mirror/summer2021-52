# Summer2021-No.52 将per-memcg LRU lock特性移植到openEuler的内核上

#### 介绍
https://gitee.com/openeuler-competition/summer-2021/issues/I3EIE3


#### 使用说明

1.  cd ./ubuntu-openEuler
2.  sudo ./create-image.sh
3.  cd ../
4.  git submodule update --init --recursive
5.  cd ./kernel
6.  git checkout openEuler-21.03
7.  make ARCH=x86_64 menuconfig
8.  make ARCH=x86_64 bzImage -j2
9.  ./runqemu-openEuler-ubuntu.sh

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request

#### 备注

1.  本仓库搭建了运行一个简单的 （openEuler内核）+（ubuntu 文件系统）的环境
2.  若需要改变运行 ubuntu 的发行版本，修改 create-image.sh 的 25 行
3.  这个版本的 openEuler 内核是在最新的 21.03 分支上打入 memcg 补丁，并成功编译的版本
4.  后续计划使用 readtwice 测试用例测试补丁前后内核的性能，需要安装 docker 环境并运行多线程测试

#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)

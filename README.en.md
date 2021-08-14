# Summer2021-No.52 将per-memcg LRU lock特性移植到openEuler的内核上

#### Description
https://gitee.com/openeuler-competition/summer-2021/issues/I3EIE3


#### Installation

1.  cd ./ubuntu-openEuler
2.  sudo ./create-image.sh
3.  cd ../
4.  git submodule update --init --recursive
5.  cd ./kernel
6.  git checkout openEuler-21.03
7.  make ARCH=x86_64 menuconfig
8.  make ARCH=x86_64 bzImage -j2
9.  ./runqemu-openEuler-ubuntu.sh

#### Contribution

1.  Fork the repository
2.  Create Feat_xxx branch
3.  Commit your code
4.  Create Pull Request

#### 备注

1.  this repository build a simple environment for running (openEuler kernel)+(ubuntu file system)
2.  if you want to change the ubuntu distrubutation, change line 25 in create-image.sh
3.  the kernel of  openEuler in this repository is official branch 21.03 with  memcg patch, and the compile process is doing well 
4.  future plan is running "readtwice" test, which needs the docker environment

#### Gitee Feature

1.  You can use Readme\_XXX.md to support different languages, such as Readme\_en.md, Readme\_zh.md
2.  Gitee blog [blog.gitee.com](https://blog.gitee.com)
3.  Explore open source project [https://gitee.com/explore](https://gitee.com/explore)
4.  The most valuable open source project [GVP](https://gitee.com/gvp)
5.  The manual of Gitee [https://gitee.com/help](https://gitee.com/help)
6.  The most popular members  [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)

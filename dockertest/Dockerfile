FROM centos:8
MAINTAINER Alexs 
#WORKDIR /vm-scalability 
#RUN yum update -y && yum groupinstall "Development Tools" -y && yum clean all && \
#examples https://www.linuxtechi.com/build-docker-container-images-with-dockerfile/
RUN yum install git xfsprogs patch make gcc -y && yum clean all && \
git clone  https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/ && \
cd vm-scalability && make usemem

COPY readtwice.patch /vm-scalability/

RUN cd vm-scalability && patch -p1 < readtwice.patch

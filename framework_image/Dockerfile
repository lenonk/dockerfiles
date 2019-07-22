# Based on the base CentOS6 image, create an image customized as a
# Jenkins SSH slave.

FROM centos:6.9
MAINTAINER James Jhurani <jjhurani@alertlogic.com>

# Allow the specification of http(s) proxys.
#ARG http_proxy
#ARG https_proxy

# Install updates and required packages
RUN yum -y install epel-release \
	&& yum -y install gcc \
                rpm-build \
		curl \
        	git \
        	gnupg2 \
        	java-1.8.0-openjdk-headless \
        	openssh-server \
        	sed \
                libpcap-devel \
        	sudo \
        	tar \
        	which \
		htop \
		vim \
		git \
		subversion \
		openssl \
		openssl-devel \
		automake \
		autoconf \
		libtool \
		flex \
		bison \
		texinfo \
		libpcap-devel \
		wget \
		re2 \
		re2-devel \
		doxygen \
		centos-release-scl \
		perl-devel  \
		pcre-devel \
        && yum clean all \
	&& yum -y install devtoolset-4 devtoolset-4-libatomic-devel python27

# Add Mercurial support.
#RUN /usr/bin/yum -y localinstall https://www.mercurial-scm.org/release/centos6/RPMS/x86_64/mercurial-3.4.2-0.x86_64.rpm

# Clean up
RUN rm -rf /etc/ld.so.cache \
	&& rm -rf /sbin/sln \
	&& rm -rf /usr/share/man \
	&& rm -rf /usr/share/doc \
	&& rm -rf /usr/share/info \
	&& rm -rf /usr/share/gnome/help \
	&& rm -rf /usr/share/cracklib \
	&& rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/*

# Fix SSH's PAM configuration so we can login.
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

#RPMIZE
RUN echo $'#!/bin/bash\n\
if (( $# < 1 )); then\n\
echo "not enough arguments"\n\
exit 1 \n\
fi \n\
(cd `dirname $1` && tar -zcvf `basename $1`.tar.gz `basename $1`) \n\
mv `dirname $1`/`basename $1`.tar.gz ~/rpmbuild/SOURCES/ \n\
rpmbuild -bb $1/rpm/`basename $1`.spec ' > /bin/rpmize
RUN chmod +x /bin/rpmize

# CERT
RUN mkdir -p ~/.ssh
RUN echo $'-----BEGIN RSA PRIVATE KEY-----\n\
MIIEowIBAAKCAQEAtsawT8qDh6AZZkSQ1GH3i6HpLVPymxXkFUhvYElfDD4iiPpB\n\
Ar7YqfY9djVeWDIDu/z5q/zKZDoOVyxzW+cl5pN9qFXx+TDYLpwMxt2FKEwAooya\n\ 
ydYypPXCBU4g3K6sw3TatQHvv8+x7GT7ecmtBE6A0t3M0TIkaTJmtLLAtYx7uN7J\n\
y/6rGfMHkFoqkv1LrsoeAaG/AlySP5NwZZojF9E4f5lKe5jtrwng9G945MTlFSo2\n\
DcL1FFlkVFf+4vm4YAD3oEVsor3WK00nOkWCIKOmSOlfVEeyJ7/QIV4DmJRuVsAx\n\
WfRNgXsr5hMhEm5qqw1Cipr/2FSunLTUXAkkGQIDAQABAoIBAAgindRfWi1eNeM0\n\
aBHb7m27nipTUzgN6GH+IF7zxRRBa74XDW+22OPvvtqVE4bvavUiFGbQUJ3Xa637\n\
n4LWrfwuUmh8stF5mBWzAmqTj4q0n06c3YLgUs6+1Yzw5kuMRspIWDe4R1iNQQkZ\n\
kYvhKx9G8zrvfl9NUQuRn7qpPiSWcdOxvR4bhuKXBOZtBwUDIzyQFVGI9zWZhSTj\n\
eD+6cHXiZgePby89olg7qJ6r+OVQsJQPssXpIOEKkSO1N3j3i7Kyh9dx4Rj+Y5GK\n\
xMmdQFEkRsJd9LMqgYHGB75ZJF9Jll4Mi7uVnt1bonSFDr9witpuAHxEOkiaZ7te\n\
NQJeG4ECgYEA66Xhac9F/7CkIeEllEI6u6/ovyHMRhmf/hlf6anY0/UnaB3E5Vro\n\
Z4gueyZBQKqCpJRiBrFPof2wPadh9fagcgy39qyFZBpENgcxY0NlrNxS/9MeOlsz\n\
Obf9C8Sju3Npuj6kxby9JsabO5Wu925T68qNiRPOXZcfPfTUhmJBS/ECgYEAxo/T\n\
FyiiHZQk530DI26sP87Yx8hga8h21LSsArkP1sk/MQLUxLp2o0zbf5QH0W8KLoin\n\
/bj1qy+iM7pbeKCb6j4G30EBMUP6f2l/hXHTHRvkiXFBQ/Ep0z6+KHb6db5QYigs\n\
0PeUI5KMaAHMwDIp6nmRSME/BsGhiF8KIjhYIqkCgYB6/w8j6kMwDWPuJxU1SEhd\n\
tJh4Qszbff6LY3Uzgiqhn2EdMASYbhXGDEeuka4XcahU/PoZYi0dcUuvMpGoDz15\n\
qffPcgcB08/sn16A4CnOywUrcGdjsDyRkN4saUvIyJnT02SvrS7RcXKO7DbyAQ0e\n\
ko/Dj6n0Ia/157eSGPDaEQKBgQCFZ1XcZllc5A5TVMNKB+5ERHWS7EYTxDBKQkSa\n\
47kHhlglVpCax+gzWMzUDyGdjSvbDcdICP9NDwi8FkWkasu1+gxl7GefsNtYxQl/\n\
H3VGRloqGWRPAHUoTyw1RZKKjt20xOcvUlc9+xTIQAVPT6SnuxtoNSViJa+gTrIh\n\
QZe9WQKBgFvZCpayCyLuBsaDGEnivhzQ08NnNlvXgy/1bgtKc0skWlT8eTNmR3wS\n\
HvDwiRQ8YD2FpBS4pSbvO3+IdjbdlvbSXBtOWFHrQYaJm++JGqCf7BXqkgDcTqPZ\n\
xJn+amlbCr+bnhaqkb9fLLQ9j6zpRHwM2DpfBLVngDY+BDiMtBCm\n\
-----END RSA PRIVATE KEY-----' > ~/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa

#jenkins
RUN echo $'[user] \n\
	email = jenkins@alertlogic.com\n\
	name = <Jenkins Build> ' > ~/.gitconfig
RUN echo -e "Host algithub.pd.alertlogic.net\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config


# Update sudo setup.
RUN sed -i 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers \
    && echo 'Defaults    env_keep += "http_proxy https_proxy"' >> /etc/sudoers \
    && echo '%users ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Configure timezone
RUN ln -sf \
	/usr/share/zoneinfo/UTC \
	/etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network

# Setup the jenkins user. Unlike a standard jenkins install, we give Jenkins
# a shell so it can login.
RUN useradd -d /var/lib/jenkins -m -s /bin/bash -c "Jenkins Continuous Build Account" jenkins
RUN echo "jenkins:jenkins" | chpasswd

# make rpm directory setup
RUN mkdir -p ~/rpmbuild/{RPMS,BUILD,SOURCES,CODE} && cd ~/rpmbuild/CODE && ln -s ~/rpmbuild/CODE/ ~/workspace 

#CMAKE
RUN wget https://cmake.org/files/v3.10/cmake-3.10.0-rc3-Linux-x86_64.sh \
    && mkdir /opt/cmake \
    && bash cmake-3.10.0-rc3-Linux-x86_64.sh --prefix=/opt/cmake --skip-license \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake 

#populate our bashrc
RUN echo $'CC=/opt/rh/devtoolset-4/root/usr/bin/gcc\n\
CPP=/opt/rh/devtoolset-4/root/usr/bin/cpp\n\
CXX=/opt/rh/devtoolset-4/root/usr/bin/g++\n\ 
PATH=/opt/rh/devtoolset-4/root/usr/bin:$PATH\n\
BOOST_ROOT=/opt/rh/devtoolset-4/root/usr\n\
PATH=$PATH:~/bin:/var/alertlogic/bin\n\
. /opt/rh/python27/enable' >> ~/.bashrc 

RUN rm -f /usr/local/bin/python && ln -s /opt/rh/python27/root/usr/bin/python /usr/local/bin/python

#boost
RUN yum -y install bzip2-devel \
	&& . ~/.bashrc \
	&& . /opt/rh/python27/enable \
	&& wget "https://downloads.sourceforge.net/project/boost/boost/1.64.0/boost_1_64_0.tar.bz2" \
	&& tar -jxf boost_1_64_0.tar.bz2 && cd boost_1_64_0 \
	&& ./bootstrap.sh --prefix=/usr --with-toolset=gcc && ./b2 install --with=all || exit 1

RUN  yum -y install gcc-c++
#manual libdnet? id like to move over to the rpm but then framework requires it... so maybe a new 
# al-tm-libdnet is warranted and obsoletes libdnet?
RUN wget http://prdownloads.sourceforge.net/libdnet/libdnet-1.11.tar.gz \
	&& tar -zxf libdnet-1.11.tar.gz \
	&& cd libdnet-1.11 \
	&& ./configure --with-pic \
	&& make && make install

# daq
#RUN wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz \
#	&& tar -zxf daq-2.0.6.tar.gz \
#	&& cd daq-2.0.6 \
#	&& ./configure \
#	&& make && make install
RUN wget https://source.ipfire.org/source-2.x/daq-0.6.2.tar.gz \
	&& tar -zxf daq-0.6.2.tar.gz \
	&& cd daq-0.6.2 \
	&& ./configure \
	&& make && make install

# symlink expected in spec
RUN mkdir -p ~/rpmbuild/{RPMS,BUILD,SOURCES,CODE} && ln -s ~/rpmbuild/CODE ~/rpmbuild/workspace 

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "-l", "/entrypoint.sh"]

# Based on the base CentOS6 image, create an image customized as a
# Jenkins SSH slave.

FROM centos:6.9
MAINTAINER Lenon Kitchens <lkitchens@alertlogic.com>

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
		openssl \
		openssl-devel \
		automake \
		autoconf \
		libtool \
		flex \
		bison \
		texinfo \
		wget \
		re2 \
		re2-devel \
		doxygen \
		centos-release-scl \
		perl-devel  \
		pcre-devel \
        && yum clean all \
	&& yum -y install python27 erlang zsh

# Rebar
RUN git clone git://github.com/rebar/rebar.git \
    && cd rebar \
    && ./bootstrap \
    && cp rebar /usr/bin

# oh my zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
    && sed -i 's/robbyrussell/muse/' ~/.zshrc \
    && echo 'PS1="$PS1%{$PROMPT_FAILURE_COLOR%}(docker)%{$reset_color%} "' >> ~/.zshrc

# Clean up
RUN rm -rf /etc/ld.so.cache \
	&& rm -rf /sbin/sln \
	&& rm -rf /usr/share/man \
	&& rm -rf /usr/share/doc \
	&& rm -rf /usr/share/info \
	&& rm -rf /usr/share/gnome/help \
	&& rm -rf /usr/share/cracklib \
	&& rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/*

# albuild
RUN git clone https://algithub.pd.alertlogic.net/alertlogic/build/ \
    && cd build \
    && git checkout albuild2 \ 
    && echo PATH=$PATH:/build/bin >> ~/.zshrc \
    && echo PATH=$PATH:/build/bin >> ~/.bashrc \
    && echo 'eval $(ssh-agent -s)' >> ~/.zshrc \
    && echo 'eval $(ssh-agent -s)' >> ~/.bashrc 

# Fix SSH's PAM configuration so we can login.
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

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

RUN chmod 600 ~/.ssh/id_rsa \
    && eval $(ssh-agent -s) \
    && ssh-add /root/.ssh/id_rsa \
	&& echo $'algithub.pd.alertlogic.net,10.10.16.75 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQzbVieSDdNDGhJL4DswGlMFashTa75yMhZF1jZyrTszFcF1X78jSLxm9sLXyDdD2WeuQMF4/GQD75D1P1gmxqE8a/b6EZUUIovp9lw5Ct8NDxJVafonoY8mGHs2Z9el1gcRZIyy6H584l09HOFUq1eTlTN+yTZe1qGmFpprvjjveBN7es3KpHJbO0Z5GB2sqlgcoq3EgVBPr1K4fo/Yi61zXCx8aJQdhHEXHko8HVVdVpqZ1ieUcxyirUasPV2Tow9E+ToyVUcfuqfvGhaJ0ICHdNZh+YliIxR0F4nMe371b9izL9shjNhwEXeCob129vf0Sluw/s5AuNWxiAgS4P' > ~/.ssh/known_hosts

# Update sudo setup.
RUN sed -i 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers \
    && echo 'Defaults    env_keep += "http_proxy https_proxy"' >> /etc/sudoers \
    && echo '%users ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Configure timezone
RUN ln -sf \
	/usr/share/zoneinfo/UTC \
	/etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network

RUN rm -f /usr/local/bin/python && ln -s /opt/rh/python27/root/usr/bin/python /usr/local/bin/python

RUN  yum -y install gcc-c++

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh

COPY init_alfi.sh /root/init_alfi.sh

CMD ["/bin/bash", "-l", "/entrypoint.sh"]

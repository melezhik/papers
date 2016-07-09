FROM tutum/centos

MAINTAINER "melezhik" <melezhik@gmail.com>

ENV http_proxy http://usca-proxy01.na.novartis.net:2011
ENV https_proxy http://usca-proxy01.na.novartis.net:2011


RUN yum clean all
RUN yum -y install git-core
RUN yum -y install make
RUN yum -y install gcc

RUN yum -y install perl perl-devel \
perl-Test-Simple perl-Digest-SHA perl-Digest-MD5 perl-CPAN-Meta \
perl-CPAN-Meta-Requirements perl-Getopt-Long \
perl-JSON perl-Module-CoreList perl-Module-Metadata perl-parent perl-Path-Tiny perl-Try-Tiny \
perl-App-cpanminus perl-JSON-PP perl-Algorithm-Diff perl-Text-Diff \
perl-Spiffy perl-Test-Base perl-YAML perl-File-ShareDir-Install perl-Class-Inspector \
perl-File-ShareDir perl-File-ShareDir-Install perl-Config-General

RUN cd /bin/ && curl -L https://cpanmin.us/ -o cpanm && chmod +x cpanm

RUN cpanm Sparrow -q


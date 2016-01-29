FROM centos:7
MAINTAINER Joeri van Dooren

RUN yum -y install epel-release && yum -y install pwgen supervisor bash-completion psmisc tar postgresql uuid libuuid perl-DBD-Pg perl-CPAN perl-IO-Compress-Gzip perl-YAML perl-Params-Check perl-Module-Load-Conditional perl-IPC-Cmd perl-HTML-Tiny perl-CPAN-Meta-YAML perl-Pod-Coverage perl-Perl-Critic perl-Test-Perl-Critic perl-ExtUtils-Embed perl-Getopt-ArgvFile perl-DBD-Pg perl-Math-Round perl-Time-HiRes perl-ZMQ-LibZMQ3 curl && yum clean all -y

RUN curl -L https://cpanmin.us | perl - --sudo App::cpanminus

COPY run_mojolicious.sh /

RUN mkdir /var/mojo

VOLUME /var/mojo

USER 997
EXPOSE 8080
CMD ["/bin/sh", "/run_mojolicious.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Mojolicious" \
      io.k8s.display-name="mojolicious centos7 epel" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,mojolicious,perl" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"

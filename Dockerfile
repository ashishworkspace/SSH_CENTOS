FROM centos:latest

RUN yum install -y openssh-server sudo

RUN useradd ashish && \
    echo 'ashish:password' | chpasswd 

RUN echo 'ashish ALL=(ALL) NOPASSWD:  ALL' >> /etc/sudoers

RUN mkdir -p /home/ashish/.ssh && \
    chmod 700 /home/ashish/.ssh && \
    chown ashish:ashish /home/ashish/.ssh

COPY public.pub /home/ashish/.ssh/authorized_keys 

RUN chown -R  ashish:ashish /home/ashish/.ssh/authorized_keys && \
    chmod 600 /home/ashish/.ssh/authorized_keys

RUN ssh-keygen -A

RUN rm -rf /run/nologin

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
    

  

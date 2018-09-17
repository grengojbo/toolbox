FROM debian:stretch-slim
MAINTAINER Oleg Dolya <oleg.dolya@gmail.com>

RUN sed -i 's/$/ contrib non-free/' /etc/apt/sources.list && apt-get update

WORKDIR /root
RUN mkdir -p /root/bin

VOLUME /mnt
VOLUME /root/bin

# Convenience
RUN apt-get install -y --no-install-recommends \
        file                       \
        git                        \
        less                       \
        man-db                     \
        manpages                   \
        vim                        \
        mc                         \
        tmux                       \
        bzip2                      \
        apt-transport-https        \
        gnupg2                     \
        software-properties-common \
        apt-utils                  \
        zsh                        \
        # openssh-server             \
        openssh-client             \
        locales-all                \
        && apt-get -y autoremove && apt-get -y autoclean

# Generic
RUN apt-get install -y --no-install-recommends \
        atop    \
        dstat   \
        htop    \
        ltrace  \
        strace  \
        sysstat \
        && apt-get -y autoremove && apt-get -y autoclean

# IO
RUN apt-get install -y --no-install-recommends \
        blktrace \
        iotop    \
        iozone3  \
        lsof     \
        && apt-get -y autoremove && apt-get -y autoclean

# Networking
RUN apt-get install -y --no-install-recommends \
        arping          \
        bridge-utils    \
        ca-certificates \
        curl            \
        wget            \
        ethtool         \
        iftop           \
        iperf           \
        iproute2        \
        mtr-tiny        \
        net-tools       \
        nicstat         \
        nmap            \
        tcpdump         \
        dnsutils        \
        dnstop          \
        dnstracer       \
        && apt-get -y autoremove && apt-get -y autoclean

# Sysdig
# RUN curl -sS https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | apt-key add - \
#     && curl -s http://download.draios.com/stable/deb/draios.list \
#         > /etc/apt/sources.list.d/draios.list \
#     && curl -s http://download.draios.com/apt-draios-priority \
#         > /etc/apt/preferences.d/apt-draios-priority \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends \
#         gcc     \
#         sysdig  \
#         libssl-dev \
#         libcap2-bin \
#         g++ \
#         make \
#     && ln -s /media/root/lib/modules /lib/modules \
#     && apt-get -y autoremove && apt-get -y autoclean

# # Docker
# RUN echo "deb https://download.docker.com/linux/debian stretch stable" \
#         > /etc/apt/sources.list.d/docker.list \
#     && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends docker-ce=17.03 \
#     && apt-get -y autoremove && apt-get -y autoclean

COPY tmux.conf /root/.tmux.conf

COPY zshrc /root/.zshrc

# Dotfiles
RUN git clone https://github.com/ragnar-johannsson/dotfiles.git /tmp/dotfiles \
    # && cp /tmp/dotfiles/zshrc.symlink /root/.zshrc \
    && cp /tmp/dotfiles/vimrc.symlink /root/.vimrc \
    && cp -r /tmp/dotfiles/zsh.symlink /root/.zsh  \
    && cp -r /tmp/dotfiles/vim.symlink /root/.vim  \
    && zsh -i -c "cat /dev/null" \
    && sed -i 's/^colorscheme /" colorscheme /' /root/.vimrc \
    && sed -i '/fzf/s_\./install_echo nnn \\| \./install_' /root/.vimrc \
    && vim +PlugInstall +qall \
    && sed -i 's/^" colorscheme /colorscheme /' /root/.vimrc \
    && sed -i "/'.*separator'/d" /root/.vimrc \
    && sed -i '/fzf/d; /^# GQ/d; /DEVMANAGEMENT/d' /root/.bashrc /root/.zshrc \
    # && echo 'ln -s /docker/docker.sock /var/run/docker.sock 2>/dev/null' >> /root/.zshrc \
    && touch /root/.z \
    #&& compaudit | xargs -I '%' chmod g-w,o-w '%' \
    && rm ~/.zcompdump* \
    && rm -rf /tmp/dotfiles 


CMD ["/bin/zsh"]


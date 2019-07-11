FROM alpine:3.9.4

# Install Tools
RUN apk update && apk upgrade && \
	apk add --no-cache \
	curl \
	zsh \
	zsh-vcs \
	git \
	tmux \
	vim

# Install Bat from @testing
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	bat

# oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# vim-plug
RUN curl -fsLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# oh-my-zsh config
# vimrc
COPY .vimrc .zshrc .aliases /root/

# run plug install
RUN vim +silent +PlugInstall +qall

# home since we're root for now
WORKDIR "/root"
CMD [ "/bin/zsh" ]

alias lt="ls -lrt"
# Obviously this assumes the location where Brew installed git:
source /usr/local/Cellar/git/1.9.0/etc/bash_completion.d/git-completion.bash
source /usr/local/Cellar/git/1.9.0/etc/bash_completion.d/git-prompt.sh

#export M2_HOME=/apache-maven-2.2.1
#the \e is to set up the titlebar; see https://www.ibm.com/developerworks/linux/library/l-tip-prompt/
export PS1="\[\\e[32;1m\]\w\[\e[0m\] $(__git_ps1 "(%s)") \n\$ "
SVN_EDITOR=vi
export SVN_EDITOR
PATH=/usr/local/bin:/usr/bin:${PATH}:/xmlstarlet-1.2.1:~/bin
export PATH
export HISTTIMEFORMAT='%F %T '

#virtualenvwrapper:
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/src
#source /usr/local/bin/virtualenvwrapper.sh

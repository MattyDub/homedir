#alias python=/Python26/python.exe
alias lt="ls -lrt"
alias sqldev="sqlplus dps2@\(DESCRIPTION=\(ADDRESS_LIST=\(ADDRESS=\(PROTOCOL=TCP\)\(HOST=napdbdev.regulusgroup.net\)\(PORT=1521\)\)\)\(CONNECT_DATA=\(SERVICE_NAME=dps2dev\)\)\)"
alias sqluat="sqlplus dps2@\(DESCRIPTION=\(ADDRESS_LIST=\(ADDRESS=\(PROTOCOL=TCP\)\(HOST=cltdpsdb2.regulusgroup.net\)\(PORT=1521\)\)\)\(CONNECT_DATA=\(SERVICE_NAME=cdps2p\)\)\)"
alias py3=/Python31/python
alias py25=/Python25/python
alias py27=/Python27/python
alias da=/Python26/Scripts/django-admin.py
alias rs="/src/test/djmsg/Scripts/python /src/test/djmsg/djmsg/manage.py runserver"
#alias vi="/emacs-23.4/bin/emacsclientw.exe" # ha!

export M2_HOME=/apache-maven-2.2.1
#the \e is to set up the titlebar; see https://www.ibm.com/developerworks/linux/library/l-tip-prompt/
export PS1="\[\e]2;\w\a\e\n\[\e[33m\]\w\[\e[0m\]\n\$ "
SVN_EDITOR=/emacs-23.4/bin/emacsclientw.exe
export SVN_EDITOR
PYMACS_EMACS=/emacs-22.2/bin/emacs.exe
export PYMACS_EMACS
PATH=/usr/bin:${PATH}:/usr/local/bin/:/xmlstarlet-1.2.1/:~/bin/
export PATH
export HISTTIMEFORMAT='%F %T '


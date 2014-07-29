export DEV_ROOT=$HOME/dev

####
##
#   EXTEND $PATH
##
####
export PATH=./node_modules/.bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/local/heroku/bin"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


####
##
#   INCLUDE SOME ENV SPECIFIC CONFIGS
##
####
sources=(
  "$HOME/.bash_profiles/go"
  "$HOME/.bash_profiles/java"
  "$HOME/.bash_profiles/git-completion"
  "$HOME/.bash_profiles/dirs"
  "$HOME/.bash_profiles/ps1"

  "$HOME/.esvm/esvm.sh"

  "$HOME/.nvm/nvm.sh"
  "$HOME/.rvm/scripts/rvm"
  "$HOME/.travis/travis.sh"
)

for i in "${sources[@]}"
do
  [ -s "$i" ] && source "$i"
done


####
##
#   SHORTCUTS
##
####
alias flushdns='sudo killall -HUP mDNSResponder'
alias ip='/sbin/ifconfig | grep "inet "'
alias chrome='open -a "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"'

function untar {
  tar xvfz "$*"
}

function dev_server {
  sudo nodemon "$DEV_ROOT/server" --watch "$DEV_ROOT/server"
}
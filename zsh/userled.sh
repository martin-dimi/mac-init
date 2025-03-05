export USERLED_HOME=$HOME/Documents/core

[ -f $ZDOTDIR/gcloud.sh ] && source $ZDOTDIR/gcloud.sh

# TODO: MOve elsewhere
alias core="cd $USERLED_HOME"
alias be="cd $USERLED_HOME/backend"
alias fe="cd $USERLED_HOME/frontend"
alias sdk="cd $USERLED_HOME/sdk"
alias ml="cd $USERLED_HOME/ml"
alias ldb="bash $USERLED_HOME/experimental/martin/db/db-local.sh"
alias sdb="bash $USERLED_HOME/experimental/martin/db/db.sh"
alias pdb="bash $HOME/Documents/scripts/userled_prod.sh"

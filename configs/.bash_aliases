#-#-#-#-#-#
# Aliases #
#-#-#-#-#-#

alias vi='vim'
alias ..='cd ..'
alias ...='cd ../../'
alias ls='ls -G'
alias ll='ls -lhrtG'
alias la='ls -larthG'

# Only really useful for Python log files
alias gwarn='grep ": WARNING:\|: ERROR:"'
alias ginfo='grep ": WARNING:\|: ERROR:\|: INFO:"'

# Load tmux session
alias load_dev='~/scripts/load_dev.sh'

### Add/modfiy the folowing for different roles (aws-vault/aws-okta) ###

# Execute command as rolet
alias aws_dev='aws-vault exec dev --backend=keychain -- '

# Load env variables for role
alias assume_dev='eval $(aws_dev env | grep AWS | xargs -L 1 echo "export")'

# Kubectl context switching
alias kdev='kubectl config use-context <name>'

# Start kubepromt as role
alias k_dev='kdev && aws_dev kube-prompt'

#-#-#-#-#-#-#
# Functions #
#-#-#-#-#-#-#

unsetawsenvs() {
    unset AWS_SESSION_TOKEN
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_ACCESS_KEY_ID
    unset AWS_OKTA_SESSION_EXPIRATION
    unset AWS_OKTA_PROFILE
    unset AWS_OKTA_ASSUMED_ROLE
    unset AWS_DEFAULT_REGION
    unset AWS_OKTA_ASSUMED_ROLE_ARN
    unset AWS_SECURITY_TOKEN
    unset AWS_REGION
    unset AWS_VAULT
    unset AWS_SESSION_EXPIRATION
}

# kill all running docker images
kill_docker () {
    image_ids=`docker ps | grep -v CONTAINER | awk '{ print $1 }'`
    for id in $image_ids; do
        echo "killing $id"
        docker kill $id
    done
}

# delete all images and restart docker
nuke_docker () {
    docker rmi $(docker images -f dangling=true -q)
    docker rmi $(docker images -a -q)
    docker rm $(docker ps -a -f status=exited -f status=created -q)
    rm ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
    osascript -e 'quit app "Docker"' && open -a Docker
}


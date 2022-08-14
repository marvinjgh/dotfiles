# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'    

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# vdiff () {
#     if [ "${#}" -ne 2 ] ; then
#         echo "vdiff requires two arguments"
#         echo "  comparing dirs:  vdiff dir_a dir_b"
#         echo "  comparing files: vdiff file_a file_b"
#         return 1
#     fi
#     local left="${1}"
#     local right="${2}"
#     if [ -d "${left}" ] && [ -d "${right}" ]; then
#         vim +"DirDiff ${left} ${right}"
#     else
#         vim -d "${left}" "${right}"
#     fi
# }

# dtags () {
#     local image="${1}"
#     wget -q https://registry.hub.docker.com/v1/repositories/"${image}"/tags -O - \
#         | tr -d '[]" ' | tr '}' '\n' | awk -F: '{print $3}'
# }

weather () {
    curl https://wttr.in/"${1}"
}

alias 755d="find . -type d -exec chmod 755 {} \;"

alias 644f="find . -type f -exec chmod 644 {} \;"

# # This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# # up memory, this command will free your memory after about 20-30 seconds.
# #   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""

# alias gi="git init && git symbolic-ref HEAD refs/heads/main"

# # A way to define and run tasks in a project. It's like make except it's pure
# # Bash so there's no make limitations like not being able to forward arguments.
# alias run=./run

## docker commands
alias docker-ps=docker ps --format "Id\t{{.ID}}\nName\t{{.Names}}\nImage\t{{.Images}}\nPorts\t{{.Ports}}\nCommand\t{{.Command}}\nCreated\t{{.CreatedAt}}\nStatus\t{{.Status}}\n"
alias docker-psa=docker ps -a --format "Id\t{{.ID}}\nName\t{{.Names}}\nImage\t{{.Images}}\nPorts\t{{.Ports}}\nCommand\t{{.Command}}\nCreated\t{{.CreatedAt}}\nStatus\t{{.Status}}\n"
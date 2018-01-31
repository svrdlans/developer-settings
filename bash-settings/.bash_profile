alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias cdfh='cd /Users/svrdlans/projects/elixir/fh_umbrella/'
alias extree="tree -I 'deps|_build'"

export PATH=$PATH:/usr/local/sbin

# asdf specific
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
#

# Powerline specific
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
if [ -d "/Library/Python/2.7/site-packages/powerline" ]
then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /Library/Python/2.7/site-packages/powerline/bindings/bash/powerline.sh
fi
#

# gcloud
. /Users/svrdlans/install/google-cloud-sdk/completion.bash.inc
. /Users/svrdlans/install/google-cloud-sdk/path.bash.inc
#

# kubectl
function qdel() { kubectl delete pod "$@";}
alias qctx='kubectl config current-context'
alias qviewctx='kubectl config view'
function qsetctx() { kubectl config use-context gke_freight-hub_us-central1-c_fh-"$@"; }
function qdown() { kubectl scale rc/"$@" --replicas=0; }
function qup() { kubectl scale rc/"$@" --replicas=1; }

function qerc() { kubectl edit rc "$@"; }
function qecm() { kubectl edit configmap "$@"; }

function qpodname(){
	kubectl get pods |grep $1 |awk '{print $1}'
}
function qssh(){
	kubectl exec -ti `qpodname $1` /bin/bash
}

function qpods() {
	if [ $# -eq 0 ]; then
		kubectl get pod
	else
		ctx="$1"
		kubectl get pod --context="gke_freight-hub_us-central1-c_fh-$ctx"
	fi
}

function qlog() {
	valid_ctxs=(dev demo prod)
	if [ $# -eq 1 ]; then
		result=`qctx`
		ctx=${result##*-}
		if [[ $result == *freight-hub* && ${valid_ctxs[@]} =~ $ctx ]]; then
			echo "Current context set to '$ctx'"
		else
			ctx=dev
			echo "Current context not set; using 'dev'"
		fi
	else
		ctx="$2"
	fi
	context=gke_freight-hub_us-central1-c_fh-$ctx
	v="$1"
	NAME=${v/_/-}
	POD=`qpods $ctx | awk '{print $1}' | grep $NAME`
	echo "Tailing log for:" $POD " for ENV:" $context
	kubectl logs $POD -f --context=$context
}

function qdeploy() {
	if [ $# -eq 2 ]; then
		context=gke_freight-hub_us-central1-c_fh-dev
	else
		context=gke_freight-hub_us-central1-c_fh-"$3"
	fi
	arg1="$1"
	ctrl=${arg1/_/-}
	kubectl rolling-update $ctrl --image=gcr.io/freight-hub/"$1":0.0.1-"$2" --update-period=1s --poll-interval=2s --context=$context
}
#

# rename tabs function
tab() {
	echo -ne "\033]0;$*\007"
}
#

# grep elixir project
function grepex() {
	location="./"
	if [ $# -eq 0 ]; then
		echo "Search pattern required!"
		return 1
	fi
	if [ $# -eq 2 ]; then
		location=$2
	fi
	echo "Searching for '$1' at '$location':"
	grep -lr --exclude-dir=deps --exclude-dir=_build --include=*.ex --include=*.exs $1 $location 
}
#

# git aliases
alias g='git'
# git-completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && ! shopt -oq posix; then
	. /usr/local/etc/bash_completion.d/git-completion.bash
fi

function_exists() {
	declare -f -F $1 > /dev/null
	return $?
}

for al in `__git_aliases`; do
	alias g$al="git $al"

	complete_func=_git_$(__git_aliased_command $al)
	function_exists $complete_func && __git_complete g$al $complete_func
done
alias brml="git branch --merged | grep -oE \"FH-\d{4,}\" | sed 's/^/https:\/\/freighthub.atlassian.net\/browse\//'"
alias brul="git branch --no-merged | grep -oE \"FH-\d{4,}\" | sed 's/^/https:\/\/freighthub.atlassian.net\/browse\//'"
#
#

alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias cdfh='cd /Users/svrdlans/projects/elixir/fh_umbrella/'
alias cdex='cd /Users/svrdlans/projects/elixir/extreme_system/'
alias cdgft='cd /Users/svrdlans/projects/elixir/gft/gft_backend/'
alias cdpy='cd /Users/svrdlans/projects/python/'
alias cddo='cd /Users/svrdlans/projects/docker/'
alias extree="tree -I 'doc|deps|_build'"

export PATH=$PATH:/usr/local/sbin

# asdf specific
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
#

# kerl
function kerl_default() {
	export KERL_BUILD_BACKEND=tarball
}
function kerl_git() {
	export KERL_BUILD_BACKEND=git
	export OTP_GITHUB_URL=https://github.com/erlang/otp
}
function kerlug() {
	echo "Getting releases from git."
	`kerl_git`
	kerl update releases
}
#

# Powerline specific
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
if [ -d "/Library/Python/2.7/site-packages/powerline" ]; then
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

function ctx_name() {
	local ctx=$1
	if [[ $1 == fh-* ]]; then
		ctx="gke_freight-hub_us-central1-c_$1";
	elif [[ $1 == gft-* ]]; then
		ctx="gke_global-freight-tracking-202214_us-central1-b_$1";
	fi
	echo $ctx
}
function qsetctx() {
	local ctx=`ctx_name $1`
	kubectl config use-context "$ctx";
}

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
		local ctx=`ctx_name $1`
		kubectl get pod --context="$ctx"
	fi
}

function get_default_ctx() {
	local valid_ctxs=(fh-dev fh-demo fh-prod gft-qa gft-prod minikube)
	result=`qctx`
	local ctx=${result##*_}
	if ! [[ $result != error:* && ${valid_ctxs[@]} =~ $ctx ]]; then
		ctx=fh-dev
	fi
	echo $ctx
}

function qlog() {
	valid_ctxs=(fh-dev fh-demo fh-prod gft-qa gft-prod minikube)
	if [ $# -eq 1 ]; then
		ctx=`get_default_ctx`
		echo "Current context set to '$ctx'"
	elif [ $# -eq 2 ]; then
		echo "Context passed as '$ctx'"
		ctx=$2
	else
		echo "Usage: qlog POD [CTX [=(dev|demo|prod)]] "
		echo -e "Example: qlog bo-listeners \t\t# stream complete log for bo-listener using current-context (if not set defaults to dev)"
		echo -e "Example: qlog bo-listeners demo \t# stream complete log for bo-listeners for demo context"
		return 1
	fi
	local context=`ctx_name $ctx`
	local v="$1"
	local NAME=${v/_/-}
	local POD=`qpods $ctx | awk '{print $1}' | grep $NAME`
	echo "Tailing log for:" $POD " for ENV:" $context
	kubectl logs $POD -f --context=$context
}

function qlos() {
	local ctx=""
	local since=""
	if [ $# -eq 2 ]; then
		ctx=`get_default_ctx`
		since=$2
		echo "Current context set to '$ctx'"
	elif [ $# -eq 3 ]; then
		ctx=$2
		since=$3
		echo "Context passed as '$ctx'"
	else
		echo "Usage: qlos POD [ [SINCE [=num(h|m|s)]] | [CTX [=(dev|demo|prod)]] [SINCE [=num(h|m|s)]] ]"
		echo -e "Example: qlos bo-listeners 3h \t\t# stream log for bo-listeners for last 3 hours"
		echo -e "Example: qlos bo-listeners demo 10m \t# stream log for bo-listeners using demo context for last 10 minutes"
		return 1
	fi
	local context=`ctx_name $ctx`
	local v="$1"
	local NAME=${v/_/-}
	local POD=`qpods $ctx | awk '{print $1}' | grep $NAME`
	echo "Tailing log for:" $POD " for ENV:" $context
	kubectl logs $POD -f --context=$context --since=$since
}

function qdeploy() {
	if [ $# -eq 2 ]; then
		context=`ctx_name fh-dev`
	else
		context=`ctx_name $3`
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
	grep -lr --exclude-dir=deps --exclude-dir=doc --exclude-dir=_build --include=*.ex --include=*.exs --include=*.eex $1 $location
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

for al in `__git_get_config_variables "alias"`; do
	alias ,$al="git $al"

	complete_func=_git_$(__git_aliased_command $al)
	function_exists $complete_func && __git_complete ,$al $complete_func
done
alias brml=",brm | grep -oE \"FH-\d{4,}\" | sed 's/^/https:\/\/freighthub.atlassian.net\/browse\//'"
alias brul=",bru | grep -oE \"FH-\d{4,}\" | sed 's/^/https:\/\/freighthub.atlassian.net\/browse\//'"
alias brmd=",brm | grep -E \(feature\|hotfix\|bugfix\) | sed -E 's/([[:graph:]]+)/,del \1 \&\& ,delr \1/'"
alias brud=",bru | grep -E \(feature\|hotfix\|bugfix\) | sed -E 's/([[:graph:]]+)/,del \1 \&\& ,delr \1/'"
alias chapps=",di master..HEAD --name-only | sed -E 's|apps/([a-z0-9_\.\-]+)/.+|\1|' | uniq"
alias migras=",di master..HEAD --name-only -- ../**/priv/repo/migrations/. | sed -E 's|apps/([a-z0-9_\.\-]+)/.+|\1|' | uniq"
#
#

# here maps curl
alias here_map="
curl \
  -X GET \
  -H 'Content-Type: *' \
  --get 'https://route.api.here.com/routing/7.2/calculateroute.json' \
    --data-urlencode 'waypoint0=geo!stopOver!50.0522,8.2180' \
    --data-urlencode 'waypoint1=geo!stopOver!50.0460,8.5561' \
    --data-urlencode 'waypoint2=geo!stopOver!50.0957,8.5280' \
    --data-urlencode 'mode=fastest;truck;traffic:default' \
    --data-urlencode 'routeAttributes=wp,sh' \
    --data-urlencode 'trailersCount=1' \
    --data-urlencode 'app_id=kWiwwD5ZKZWirVPmaZDV' \
    --data-urlencode 'app_code=qaVLRO2xzuhXIQlaXlifbA'"

#

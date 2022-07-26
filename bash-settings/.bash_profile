alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias cdex='cd /Users/svrdlans/projects/elixir/'
alias cdfh='cd /Users/svrdlans/projects/elixir/fh_umbrella/'
alias cdvo='cd /Users/svrdlans/projects/elixir/vof/'
alias cdvk='cd /Users/svrdlans/projects/elixir/vof_k8s/'
alias cdes='cd /Users/svrdlans/projects/elixir/extreme_system/'
alias cdxs='cd /Users/svrdlans/projects/elixir/x3m_system/'
alias cdgft='cd /Users/svrdlans/projects/elixir/gft/gft_backend/'
alias cdbq='cd /Users/svrdlans/projects/big_query/'
alias cdbe='cd /Users/svrdlans/projects/elixir/nfi/beskar/'
alias cdal='cd /Users/svrdlans/projects/elixir/nfi/albus/'
alias cdre='cd /Users/svrdlans/projects/elixir/nfi/relay/dev-tools/code'
alias cdpy='cd /Users/svrdlans/projects/python/'
alias cddo='cd /Users/svrdlans/projects/docker/'
alias cdru='cd /Users/svrdlans/projects/rust/'
alias extree="tree -I 'doc|deps|_build'"

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/Library/Python/2.7/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/10/bin
export PATH=/usr/local/opt/libpq/bin:$PATH
export PATH=$PATH:/usr/local/Cellar/node/15.10.0/bin

export NODE_COOKIE=my_own_node_cookie

export LOCAL_BUILD=true
# Albus related configs
export ALBUS_GOOGLE_CLIENT_ID=368867814379-tsqr4fdpob0thgack6jqk79a822bk7s7.apps.googleusercontent.com
export ALBUS_GOOGLE_CLIENT_SECRET=XX1jF7gkXxXrKuWiE3tVjrMK
export ALBUS_EMAIL_TO=srdjan.svrdlan@gmail.com
export ALBUS_OFFERED_LOADS_REMINDER_IN_MIN=5
export ALBUS_RESERVING_LOADS_EXPIRED_IN_MIN=5
export ALBUS_RESERVING_EXPIRED_RETRY_COUNT=3
export ALBUS_RESERVING_EXPIRED_RETRY_INTERVAL_MS=1000
export ALBUS_BOOKING_LOADS_EXPIRED_IN_MIN=5
export ALBUS_TIMERS_NOT_BOOKED_IN_MIN=5
export ALBUS_CDS_EMAIL=srdjan.svrdlan@vibe.rs

# NFI projects
export LAUNCH_DARKLY_SDK_KEY=

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/svrdlans/install/google-cloud-sdk/path.bash.inc' ]; then . '/Users/svrdlans/install/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/svrdlans/install/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/svrdlans/install/google-cloud-sdk/completion.bash.inc'; fi

HOMEBREW_PREFIX=$(brew --prefix)
if type brew &>/dev/null; then
  for COMPLETION in "$HOMEBREW_PREFIX"/etc/bash_completion.d/*
  do
    [[ -f $COMPLETION ]] && source "$COMPLETION"
  done
  if [[ -f ${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh ]];
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  fi
fi

# asdf specific
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
#

# kerl
export KERL_BUILD_DOCS=yes
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=/usr/local/opt/openssl@1.1"
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
if [ -d "$HOME/Library/Python/2.7/lib/python/site-packages/powerline" ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
fi
#

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip() {
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    echo $stat
}

function should_continue() {
	read -p "Continue (y/n)? " -n 1 -r choice
	case "$choice" in 
		y|Y ) echo "yes";;
		* ) echo "no";;
	esac
}

function get_my_public_ip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}

# kubectl ->
function qdel() { kubectl delete pod "$@";}
function qdelevicted {
	kubectl get pod | grep Evicted | awk '{print $1;}' | xargs kubectl delete pod;
}

function qdesc() { kubectl describe pod "$@";}
# function qallowip { gcloud compute firewall-rules update allow-burmaja-home --source-ranges "$@"/32; }
function qallowip {
	local res=1
	if [[ $# -ne 1 ]]; then
		echo "One parameter requred: IP address!"
		return 1;
	else
		res=$(valid_ip $1)
		if [[ $res -eq 0 ]]; then
			echo "Replacing allowed IP in GCP firewall with: $1"
			if [[ $(should_continue) = "yes" ]]; then
				echo ""
				gcloud compute firewall-rules update allow-burmaja-home --source-ranges $1/32;
			else
				echo ""
				echo "User cancelled, exiting."
			fi
		else
			echo "$1 is not a valid IP address"
			return 1
		fi
	fi
}
function qallowmyip {
	local myip=$(get_my_public_ip)
	qallowip $myip
}
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

function qdpdown() { kubectl scale --replicas 0 deployment/"$@"; }
function qdpup() { kubectl scale --replicas 1 deployment/"$@"; }

function qerc() { kubectl edit rc "$@"; }
function qecm() { kubectl edit configmap "$@"; }
function qedp() { kubectl edit deployment "$@"; }

function qpodname(){
	kubectl get pods |grep $1 |awk '{print $1}'
}
function qssh(){
	kubectl exec -ti `qpodname $1` -- /bin/bash
}

function qpods() {
	if [ $# -eq 0 ]; then
		kubectl get pod
	else
		local ctx=`ctx_name $1`
		kubectl get pod --context="$ctx"
	fi
}

function qpodsw() {
	if [ $# -eq 0 ]; then
		kubectl get pod --watch
	else
		local ctx=`ctx_name $1`
		kubectl get pod --context="$ctx" --watch
	fi
}

function qpodsv() {
	if [ $# -eq 0 ]; then
		kubectl get pod -L version
	elif [ $# -eq 1 ]; then
		local ctx=`ctx_name $1`
		kubectl get pod --context="$ctx" -L version
	else
		local ctx=`ctx_name $1`
		kubectl get pod --context="$ctx" -L version $2
	fi
}

function get_default_ctx() {
	local valid_ctxs=(albus albus-prod fh-dev fh-demo fh-prod gft-qa gft-prod minikube)
	result=`qctx`
	local ctx=${result##*_}
	if ! [[ $result != error:* && ${valid_ctxs[@]} =~ $ctx ]]; then
		ctx=fh-dev
	fi
	echo $ctx
}

function qlog() {
	valid_ctxs=(albus albus-prod fh-dev fh-demo fh-prod gft-qa gft-prod minikube)
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
	kubectl logs $POD -f --context=$context --since=$since --all-containers=true
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

function qlistns() {
	kubectl get namespace
}

function qsetns() {
	kubectl config set-context --current --namespace="$1"
}
# <- kubectl

## Kubetail ->
function qt() {
	kubetail $@
}
## <- Kubetail

# rename tabs function
tab() {
	echo -ne "\033]0;$*\007"
}
#

# grep elixir project for files containing search pattern
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
	grep -lr -F --exclude-dir=deps --exclude-dir=doc --exclude-dir=_build --include=*.ex --include=*.exs --include=*.eex --include=*.leex --include=*.heex -e "$1" $location
}
#

# grep yaml files containing search pattern
function grepml() {
	location="./"
	if [ $# -eq 0 ]; then
		echo "Search pattern required!"
		return 1
	fi
	if [ $# -eq 2 ]; then
		location=$2
	fi
	echo "Searching for '$1' at '$location':"
	grep -lr -F --include=*.yaml -e "$1" $location
}
#

# grep elixir project for files not containing search pattern
function nopex() {
	location="./"
	if [ $# -eq 0 ]; then
		echo "Search pattern required!"
		return 1
	fi
	if [ $# -eq 2 ]; then
		location=$2
	fi
	echo "Searching for '$1' at '$location':"
	grep -Lr -F --exclude-dir=deps --exclude-dir=doc --exclude-dir=_build --include=*.ex --include=*.exs --include=*.eex -e "$1" $location
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

## NFI specific ->

# Vagrant
## Run colonel
alias colonel="docker exec -it colonel bash"
##

## <- NFI specific

# Rust/Cargo
source "$HOME/.cargo/env"

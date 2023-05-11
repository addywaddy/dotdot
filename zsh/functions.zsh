# opens the gem in Vim
function gum () {
  mvim `ls -d $GEM_HOME/gems/$1-* | sort | tail -n 1`
}

# cd to gem
function gom () {
  cd `bundle show $1`
}

function sedag() {

  if [[ $1 == "-h" ]];
  then
    echo "Usage:"
    echo "sedag {flags} {ag_pattern} {sed_expression} {folders}\n"
    echo "Example:"
    echo 'sedag -i "Hello" "Hello/Goodbye" lib app\n'
    echo "Flags:"
    echo "-i for realz\n"
    return 1
  fi

  ORIG_LANG=$LANG
  LANG=C # Avoids sed thinking the file is encoded in something fancy

  if [[ $1 == "-i" ]];
  then
    echo "Replacing '$2' with '$3' in the following files:\n"
    ag -a -l $2 ${@: 4}
    ag -a -l  --print0 $2 ${@: 4} |xargs -0 -n 1 sed -i '' -e "s|$2|$3|"
    echo "\nDone!"
  else
    echo "Would run the substitution '$2' in the following files:\n"
     ag -a -l $1 ${@: 3}
  fi
  LANG=$ORIG_LANG
}

function tabname () {
  echo -ne "\e]1;$@\a"
}

function rspring {
  if [ -f bin/spring ]
  then
    bin/spring rspec "$@"
  else
		bundle exec rspec "$@"
  fi
}

function xkcdpass () {
  [ $(echo "$1"|grep -E "[0-9]+") ] && NUM="$1" || NUM=1
  DICT=$(LC_CTYPE=C grep -E "^[a-zA-Z]{3,6}$" /usr/share/dict/words)
  for I in $(seq 1 "$NUM"); do
      WORDS=$(echo "$DICT"|gshuf -n 4|paste -sd ' ' -)
      XKCD=$(echo "$WORDS"|sed 's/ //g')
      echo "$XKCD ($WORDS)"|awk '{x=$1;$1="";printf "%-36s %s\n", x, $0}' | awk '{print tolower($0)}'
  done | column
}

function ibmcc () {
  eval $(ibmcloud cs cluster-config $1 | tail -2 | head -1)
  echo $KUBECONFIG
}

# FZF functions
fb() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | cut -d / -f 3,10)
}

fp() {
  fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
}

function mov2gif() {
  ffmpeg -i $1.mov \
    -s 1200x800 -pix_fmt rgb24 -r 24 -f gif - \
    | gifsicle --optimize=3 --delay=3 \
    > $1.gif
}

function iterm2_print_user_vars() {
  iterm2_set_user_var kube_context $(kubectl config current-context 2>/dev/null)
}

free2seal() {
  __helper() {
    echo "Usage: free2seal [DOMAIN] [STAGE] [SCOPE] [SECRET_NAME] [SECRET_KEY]"
    echo "Args:"
    echo "-  DOMAIN:      \"mops\""
    echo "-  STAGE:       \"dev\",    \"int\"            or \"prod\""
    echo "-  SCOPE:       \"strict\", \"namespace-wide\" or \"cluster-wide\""
    echo "-  SECRET_NAME: \"my_awesome_secret\""
    echo "-  SECRET_KEY: \"key\""
  }
  if [ $# -ne 5 ]; then __helper; return 1
    else for x in "$@"; do if [ $x = "-h" ] || [ $x = "--help" ] || [ $x = "help" ]; then __helper; return 1; fi; done
  fi
  DOMAIN=$1;STAGE=$2;SCOPE=$3;SECRET_NAME=$4;SECRET_KEY=$5
  read -sp 'Please enter your plain text secret: ' SECRET_VALUE
  aws-okta select master-$DOMAIN-$STAGE-OktaDev 1>/dev/null 2>&1
  kubectl create secret generic "$SECRET_NAME" \
    --from-literal="${SECRET_KEY}=${SECRET_VALUE}" \
    -o yaml \
    --dry-run=client \
    | kubeseal \
    --controller-namespace sealed-secrets \
    --controller-name sealed-secrets \
    --scope "$SCOPE" \
    -o yaml \
    | yq '.spec.encryptedData'
}

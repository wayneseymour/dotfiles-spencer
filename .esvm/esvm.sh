if [[ "$ES_VERSIONS" == "" ]]; then
  export ES_VERSIONS=$HOME/.esvm
fi

if [[ "$ES_DEFAULT_REF" == "" ]]; then
  default_path="${ES_VERSIONS}/.default"
  if [[ -f $default_path ]]; then
    export ES_DEFAULT_REF=$(<"$default_path")
  else
    export ES_DEFAULT_REF='master'
  fi
fi

##
# start the default verision of es
##
function esvm {
  local cmd=$1
  shift

  ##
  # run a command without any output
  ##
  function shh {
    "$@" > /dev/null 2>&1
    return $?
  }

  function trim {
    echo "$*" | sed -e 's/^ *//' -e 's/ *$//'
  }

  ##
  # outputs log messages in pretty colors
  ##
  function log {
    local level=$1
    shift

    local red='\033[0;31m'
    local green='\033[0;32m'
    local yellow='\033[0;33m'
    local NC='\033[0m' # No Color

    case $level in
    "sta") local color=$yellow ;;
    "suc") local color=$green  ;;
    *)     local color=$red    ;;
    esac

    echo -e "${color}${@}${NC}"
  }

  ##
  # check that a ref is valid
  ##
  function check-ref {
    local ref=$1
    local update_file="${ES_VERSIONS}/.last_ref_update"
    local repo="${ES_VERSIONS}/.repo"
    local now=$(date +"%s")
    local last_accepted=$(date -v-60M "+%s")

    local prev=$PWD

    if [[ ! -d "$repo" ]]; then
      log sta "cloning elasticsearch"
      git clone --bare git@github.com:elasticsearch/elasticsearch.git "$repo"
    fi

    if [[ ! -f "$update_file" || ("$(<"$update_file")" -lt "$last_accepted") ]]; then
      log sta "updating refs and tags"

      cd "$repo"
      git fetch origin
      cd "$prev"
      echo -n "$now" > "$update_file"

    fi

    cd "$repo"

    shh git rev-parse "$ref" 2>&1
    local s="$?"

    cd "$prev"

    if [[ $s -gt 0 ]]; then
      log err "invalid ref \"${ref}\""
      return 1
    fi
  }

  ##
  # check that the ref is valid, then return it's hash
  ##
  function get-ref-hash {
    local ref=$1
    local prev=$PWD

    check-ref "$ref"
    cd "$ES_VERSIONS/.repo"
    git rev-parse "$ref"
    cd "$prev"
  }

  ##
  # start a specific version of es
  ##
  function cmd-start {
    local ref=$1
    shift

    check-ref "$ref"
    if [[ "$?" != "0" ]]; then
      return
    fi

    local bin="$ES_VERSIONS/$ref/bin/elasticsearch"

    if [[ ! -x $bin ]]; then
      log err "$ref is not installed"
      return
    fi

    "$bin" \
      -Des.script.disable_dynamic=true \
      -Des.cluster.name=spencer \
      -Des.discovery.zen.ping.multicast.enabled=false \
      -Des.discovery.zen.ping.unicast.hosts=localhost:9300,localhost:9301,localhost:9302 "$*"
  }

  ##
  # set a specific es ref as the one started by calling `es`
  ##
  function cmd-use {
    local ref=$1

    if [[ ! -x "$ES_VERSIONS/${ref}/bin/elasticsearch" ]]; then
      echo "${ref} not installed"
      return 1
    fi

    echo "setting default elasticsearch version to ${ref}"

    export ES_DEFAULT_REF=$ref
    echo -n "$ref" > "${ES_VERSIONS}/.default"
  }

  ##
  # re-build specific es ref
  ##
  function cmd-update {
    local ref=$1
    cmd-remove "$ref"
    cmd-install "$ref"
  }

  ##
  # remove an installed ref
  ##
  function cmd-remove {
    local ref=$1
    check-ref "$ref"
    if [[ "$?" != "0" ]]; then
      return
    fi
    rm -rf "${ES_VERSIONS}/${ref}"
  }

  ##
  # build specific es ref
  ##
  function cmd-install {
    local ref=$1
    local prevdir=$PWD
    local finaldir="${ES_VERSIONS}/${ref}"
    local builddir="${ES_VERSIONS}/.building"

    local hash=$(get-ref-hash "$ref")
    if [[ "$?" != "0" ]]; then
      return
    fi

    if [ -d "$builddir" ]; then
      log err "build in progress or previous build did not clean up the .building directory"
      return 1
    fi

    if [ -d "$finaldir" ]; then
      log suc "${ref} already available"
      return 1
    fi

    log sta "exporting ${ref}"
    mkdir "$builddir"
    cd "${ES_VERSIONS}/.repo"
    git archive "$hash" | tar -x -C "$builddir"
    cd "$prevdir"


    log sta "building from the export"
    cd "$builddir"
    mvn clean package -DskipTests
    cd "$prevdir"


    log sta "extracting the built tarball to $finaldir"
    mkdir "$finaldir"
    cd "$builddir"
    tar -zx --strip 1 -f target/releases/*.tar.gz -C "$finaldir"
    cd "$prevdir"


    log sta "cleaning up"
    rm -rf "$builddir"

    log suc "done"
  }

  local args="$*"
  if [[ "$cmd" == "" ]]; then
    cmd="start"
    args=$(trim "$ES_DEFAULT_REF" "$args")
  fi

  local cmdfunc="cmd-${cmd}"
  if [[ $(type -t "$cmdfunc") == "function" ]]; then
    $cmdfunc "$args"
    return $?
  else
    log err "unknown command \"$cmd\""
  fi
}
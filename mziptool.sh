function mziptool_install() {
  local thankyou="                _       _              _ 
               (_)     | |            | |
  _ __ ___  _____ _ __ | |_ ___   ___ | |
 | '_ \` _ \\|_  / | '_ \| __/ _ \ / _ \| |
 | | | | | |/ /| | |_) | || (_) | (_) | |
 |_| |_| |_/___|_| .__/ \__\___/ \___/|_|
                 | |                     
                 |_|
  
The tool has been installed, thanks you for downloading it...                       
  "
  if grep -qe "mziptool" ~/.bash_profile; then
    echo "Installation found, nothing to do"
  else
    echo "$thankyou"
    local startline=$(sed -n '/# >>>>> MZIPTOOL <<<<< #/=' mziptool.sh)
    local tokens=( $startline )
    local fromline=${tokens[1]}
    local mziptoolcode=`tail -n +${fromline} mziptool.sh`
    echo -e "\n $mziptoolcode \n" >> ~/.mziptool.sh
    echo -e "source .mziptool.sh" >> ~/.bash_profile
  fi
}

# >>>>> MZIPTOOL <<<<< #
function mziptool_help() { 
  echo "Description: mziptool aims to offer a simple zip utility" 
  echo "avoiding the annoying .DS_Store and __MACOSX  directory"
  echo "Usage: mziptool src out.zip \nArguments:"
  echo "  -h, --help:    display options "
}

function mziptool() {
  # Argument parsing
  if [ -z "$1" ] || [[ "$1" == *"-h"* ]] || [[ "$1" == *"--help"* ]]; then
    mziptool_help
    return 1
  fi
  local src=$1
  
  # Removing last char if '/' 
  if [[ "$src" == *"/" ]]; then
    src="${src::${#src}-1}"
  fi
  local outfile="${src}.zip"
  if [ -n "$2" ]; then
    outfile="$2"
  fi
  
  # Checking if the file does exist
  local dir_flag=""
  if [ ! -e "$src" ]; then
    echo -e "Error: \n   ${src} not found in $(pwd)/"
    return 1
  fi
  # Check if directory
  if [ -d "$src" ]; then
    dir_flag="-r"
  fi
  #echo "zip ${dir_flag} ${outfile} ${src} -x '*.DS_Store' -x '__MACOSX'"
  # Zipping
  zip ${dir_flag} ${outfile} ${src} -x '*.DS_Store' -x '__MACOSX'
  return 0
}

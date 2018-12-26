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
  if grep -qe "MZIPTOOL" ~/.bash_profile; then
    echo "Installation found, nothing to do"
  else
    echo "$thankyou"
    local startline=$(sed -n '/# >>>>> MZIPTOOL <<<<< #/=' mziptool.sh)
    local tokens=( $startline )
    local fromline=${tokens[1]}
    local mziptoolcode=`tail -n +${fromline} mziptool.sh`
    echo -e "\n $mziptoolcode \n" >> ~/.bash_profile 
  fi
}

# >>>>> MZIPTOOL <<<<< #
function mziptool() {
  local help_string="Usage: ziptool src out.zip
  Arguments:
    -h, --help:    display options
  " 
  # Argument parsing
  if [ -z "$1" ] || [[ "$1" == *"-h"* ]] || [[ "$1" == *"--help"* ]]; then
    echo "${help_string}"
    return 1
  fi
  local src=$1
  
  # Removing last char if '/' 
  if [[ "$src" == *"/" ]]; then
    src="${src::${#src}-1}"
  fi
  local outfile="${src}.zip"
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

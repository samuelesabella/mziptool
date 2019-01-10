mziptool
========
An easy tool to zip files and directories without .DS_Store and __MACOSX

Installation
============
Open the Terminal and paste the command below
```
$ curl -O https://raw.githubusercontent.com/samuelesabella/mziptool/master/mziptool.sh && source mziptool.sh && mziptool_install && rm mziptool.sh
```
Uninstall
=========
Open the terminal and run
```
$ cd ~ && rm .mziptool.sh && sed -i '' '/source .mziptool.sh/d' .bash_profile
```

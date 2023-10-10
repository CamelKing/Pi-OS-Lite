
#!/bin/bash

source "$(dirname $0)/install-vim.sh"    

Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

# Install_Vim "$Test_Mode" "$(dirname $(readlink -f $0))" 
Install_Vim "$Test_Mode" 

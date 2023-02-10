#!/bin/bash
#----------------------------------------------------------------------------------
# This script reverses the effects of the rename-folders.sh in case you are not
# happy with the results
#
#----------------------------------------------------------------------------------

source config.sh

for (( n=0; n<=65; n++))
do
  number=$(( $n + 1))
  numberstr="0${number}"
  numberstr=${numberstr: -2};
  original_name=${bookarray[$n]}
  new_name="${numberstr} - ${bookarray[$n]}"
  mv "${translation}/${new_name}/" "${translation}/${original_name}/";
done;
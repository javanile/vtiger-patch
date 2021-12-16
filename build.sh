#!/usr/bin/env bash

rm -fr PATCH_*

[ -d CLONE ] || git clone https://code.vtiger.com/vtiger/vtigercrm.git CLONE

cd CLONE

FROM=master
while IFS="" read -r p || [ -n "$p" ]; do
  FILE=../PATCH_${p}_${FROM}
  git log --pretty=oneline ^${p} ${FROM} | cut -d' ' -f1 > tmp
  sed -e 's#^#https://code.vtiger.com/vtiger/vtigercrm/commit/#' tmp > "$FILE"
  rm tmp
  FROM=$p
done < ../TAGS

cd ..
git add .
git commit -am "Update"
git push

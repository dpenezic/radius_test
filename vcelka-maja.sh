#!/bin/bash

ID=$1
PASS=$2

HOSTNAME=$3
SECRET=$4
REALM=$5

output=`/usr/local/rad_eap_test/rad_eap_test -H $HOSTNAME -P 1812 -S $SECRET -m WPA-EAP -e TTLS -u $ID -p $PASS -t 25 -A vcelka-maja@$REALM 2>/dev/null`
code=$?
if [ $code -eq 0 ]
then
  # test byl uspesny
  echo "TTLS: vcelka-maja@$REALM $output"
  exit 2;
else
  output=`/usr/local/rad_eap_test/rad_eap_test -H $HOSTNAME -P 1812 -S $SECRET -m WPA-EAP -e TTLS -u $ID -p $PASS -t 25 -A vcelka-maja@$REALM 2>/dev/null`
  code=$?
  if [ $code -eq 0 ]
  then
  # test byl uspesny
    echo "PEAP: vcelka-maja@$REALM $output"
  fi 
fi

if [ $code -eq 1 ]
then
  # reject
  echo "TTLS,PEAP: vcelka-maja@$REALM $output: this is OK";
  exit 0
fi

echo "maja $output: problem?";
exit 1;

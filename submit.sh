#!/bin/bash

# remember to do:
#voms-proxy-init --voms $VO

if [ "$#" -ne 3 ]; then
   echo "USAGE: . submit.sh [wms-includes] [ce-includes] [jdl file]"
   return
fi

for wms in $(lcg-infosites --vo cernatschool.org wms | grep $1); do
    export GLITE_WMS_WMPROXY_ENDPOINT=$wms
    for ce in $(lcg-infosites --vo cernatschool.org ce | awk '{print $6}' | grep $2); do 
        #echo $wms
        #echo $ce
	glite-wms-job-submit -a -o jobIDfile_$1_$2 -e $wms -r $ce $3 
    done
done

# Then to check job status do:
#glite-wms-job-status -i jobIDfile

# Then get output with:
#glite-wms-job-output -i jobIDfile

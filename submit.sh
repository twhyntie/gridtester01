#!/bin/bash

#=============================================================================
#                  A simple grid testing submission script
#=============================================================================

# Remember to do:
#voms-proxy-init --voms $VO
#myproxy-init -d -n
# (entering your grid certificate password).

if [ "$#" -ne 3 ]; then
   echo "USAGE: . submit.sh [wms-includes] [ce-includes] [jdl file]"
   return
fi

# Find the WMS sites available to the VO, filtered by the first input argument.
for wms in $(lcg-infosites --vo cernatschool.org wms | grep $1); do
    export GLITE_WMS_WMPROXY_ENDPOINT=$wms
    # Find the CEs available to the VO, filtered by site.
    # FIXME: accept wildcards/no site filter.
    for ce in $(lcg-infosites --vo cernatschool.org ce | awk '{print $6}' | grep $2); do 
	glite-wms-job-submit -a -o jobIDfile_$1_$2 -e $wms -r $ce $3 
    done
done

# Then to check job status do:
#glite-wms-job-status -i [jobIDfile]

# Then get output with:
#glite-wms-job-output -i [jobIDfile] --dir [outputdir]

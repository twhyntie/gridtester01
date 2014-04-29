Grid Tester 01
==============

A small suite of tools to test job submission on the grid.

##Requirements

* A valid grid certificate (installed in ~/.globus);
* Membership of a Virtual Organisation (VO) supported by one or more GridPP sites;
* Access to an environment capable of submitting grid jobs.

##Finding a WMS

You can find which WMS sites support your VO with the following command:

    lcg-infosites --vo cernatschool.org wms

##Finding CEs

You can find which Computing Elements (CEs) support your VO with the following
command:

    lcg-infosites --vo cernatschool.org ce

##Submitting jobs

The `submit.sh` script allows you to submit jobs with a given JDL file to
a WMS site and CE sites you specify. For example, to submit with the RAL
WMS to QML CEs only, use:

    voms-proxy-init --voms cernatschool.org
    myproxy-init -d -n
    . submit.sh rl qm thisworks.jdl

This will produce the job ID file `output_rl_qm.txt`.

##Checking job status

You can check the status of the jobs with the following command:

    glite-wms-job-status -i jobIDfile_rl_qm > output_rl_qm.txt 2>&1
    # Press return (user input required)

The `process-python.py` python script processes this output so you don't
have to, telling you the status of the jobs you've submitted:

    python process-status.py output_rl_qm.txt

##Retrieving job output

Once the jobs all reach the **Done** status, you can retrive the output
with:

    glite-wms-job-output -i jobIDfile_rl_qm --dir output_rl_qm

The output files (e.g. `stdout.txt` and `stderr.txt` for
`thisworks.jdl`) will be in the `output_rl_qm` directory.

##Sample JDL files

A number of sample JDL files are provided:

* `thisworks.jdl`: uses `echo` to output a string;
* `helloworld.jdl`: tests the CERN@school CVMFS Hello World! scripts;
* `runsimpleplot.jdl`: tests the CERN@school CVMFS simpleplot executable;
* `runallpix.jdl`: tests the CERN@school **Allpix** CVMFS deployment.

##Further information

* [https://www.gridpp.ac.uk/wiki/Main_Page](The GridPP wiki).

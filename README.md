# MPI-setup-scripts
Some basic scripts i used to setup a MPI cluster. Extremely targetted and 10% user friendly coz i spent more time on this fking readme than the scripts. Will generalize if i ever get time.


### Config.sh
##### >set ethernet interface for MAC addres on line 3 slaveMAC
##### >set slave prefix on line 4 slaveLines
##### >set masterIP on line 6 masterIP
##### >set mpiusername on line 7 mpiuserName
##### >set mpiuserPass on line 8 mpiuserPass

Configures the hosts file, creates a separate user for mpi ops, sets hostname.
##### Usage:
Create a hosts.txt with the ip of master on the first line (dont insert blank lines because im using line numbers to get slave numbers), create a MACs.txt file with MAC address of master. Copy both of the texts and the script to the same folder. Plug pd into slave, sudo execute in terminal in pd, rinse and repeat for all slaves one by one. At the end just append the hosts.txt to your master's /etc/hosts file.... EZ GG

### Setup.sh

Updates and installs required packages

### TODO
##### Better hostname, IP and MAC resolution
##### Switch to commandline args
##### Accomodate for stupidities like reruns on the same machine.
##### Put in a shitload of if-else's for safety checks

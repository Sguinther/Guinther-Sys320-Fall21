#!/bin/bash

# storyline: Script to add and remove vpn peers

while getopts 'hdau:' OPTION ; do

    case "$OPTION" in

        d) u_del=${OPTION}
        ;;
        a) u_add=${OPTION}
        ;;
        u) t_user=${OPTARG}
        ;;
        h)

               echo ""
               echo "Usage: $(basename $0) [-a]|[-d] -u username"
               echo ""
               exit 1

        ;;
        *)

               echo "Invalid value."
               exit 1

       ;;
    esac

done

# check to see if the -a and -d are empty or if they are both specified throw an error
if [[ (${u_del} == "" && ${u_add} == "") || (${u_del} != "" && ${u_add} != "")   ]]
then

    echo "Please specify -a or -d and the -u and username."

fi

# Check to ensure -u is specified
if [[ (${u_del} != "" || ${u_add} != "") && ${t_user} == "" ]]
then

      echo "Please specify a user (-u)!"
      echo "Usage:  $(basename $0) [-a][-d] -u username"
      exit 1

fi

# Delete a user
if [[ ${u_del} ]]
then

    echo "Deleting user..."
    sed -i "/# ${t_user} begin/,/# ${t_user} end/d" wg0.conf


fi

# add a user
if [[ ${u_add} ]]
then

    echo "Create the User..."
    bash peer.bash ${t_user}

fi


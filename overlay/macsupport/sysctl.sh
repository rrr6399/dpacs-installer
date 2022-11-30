#!/bin/sh

set -e

conf=/etc/sysctl.conf

# This script checks several sysctl variables to see whether they have certain
# minimum values and, if not, makes sure those minimum values are set both in
# the live sysctl and in /etc/sysctl.conf.  It is designed to run as root.

SHMMAX=$((96 * 1024 * 1024)) # 96 MB
SHMMIN=1
SHMMNI=32
SHMSEG=8
SHMALL=$(( $SHMMAX / 4096 ))

readconf() {
    var=$1
    
    awk -F "=" "\$1 == \"$var\" { print \$2; exit}" < "$conf"
}

writeconf() {
    var=$1
    val=$2
    
    cat "$conf" | awk -F "=" "
        BEGIN {
            found=0
        }
        \$1 == \"$var\" {
            found=1;
            print \$1 \"=$val\";
            next
        }
        {
            print
        }
        END {
            if (found == 0)
                print \"$var=$val\"
        }"
}

ensure()
{
    # ensure that sysctl key $1 has value greater than or equal to $2
    confvar="$1"
    minval="$2"

    if [ "$(sysctl -n $confvar)" -lt "$minval" ]; then
        # check to see whether sysctl.conf already exists and has a suitable value
        # if so, use that value; otherwise update it as well.
        if [ -f "$conf" ]; then
            confval=$(readconf "$confvar")
            
            if [ "${confval:-0}" -ge "$minval" ]; then
                minval=$confval
            else
                newconf=$(writeconf "$confvar" "$minval")
                echo "$newconf" > "$conf"
            fi
        else
            echo "$confvar=$minval" > "$conf"
        fi

        sysctl -w "$confvar=$minval" > /dev/null
    fi
}

ensure kern.sysv.shmmax "$SHMMAX"
ensure kern.sysv.shmmin "$SHMMIN"
ensure kern.sysv.shmmni "$SHMMNI"
ensure kern.sysv.shmseg "$SHMSEG"
ensure kern.sysv.shmall "$SHMALL"

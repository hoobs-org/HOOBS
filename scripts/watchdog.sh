#!/bin/bash

# DO NOT USE THIS SCRIPT - ITS IN TESTING STATE AND MAY CORRUPT YOUR HOOBS DEVICE


# HOW TO RUN THE SCRIPT

# wget -q -O - https://raw.githubusercontent.com/hoobs-org/HOOBS/main/scripts/watchdog.sh | sudo bash -



##################################################################################################
# hoobs-watchdog                                                                           #
# Copyright (C) 2022 HOOBS                                                                       #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################
# Author: Bobby Slope     
echo " "
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This script will Setup Watchdog for HOOBS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "This will automatically soft reboot your system if it got stuck"
echo "----------------------------------------------------------------"
echo "This Watchdog will prevent the need of reflash"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Setup Watchdog...."
sudo apt-get update --yes
sudo apt-get install watchdog --yes
sudo update-rc.d watchdog defaults
cat > /etc/watchdog.conf <<EOL
# ====================================================================
# Configuration for the watchdog daemon. For more information on the
# parameters in this file use the command 'man watchdog.conf'
# ====================================================================

# =================== The hardware timer settings ====================
#
# For this daemon to be effective it really needs some hardware timer
# to back up any reboot actions. If you have a server then see if it
# has IPMI support. Otherwise for Intel-based machines try the iTCO_wdt
# module, otherwise (or if that fails) then see if any of the following
# module load and work:
#
# it87_wdt it8712f_wdt w83627hf_wdt w83877f_wdt w83977f_wdt
#
# If all else fails then 'softdog' is better than no timer at all!
# Or work your way through the modules listed under:
#
# /lib/modules/`uname -r`/kernel/drivers/watchdog/
#
# To see if they load, present /dev/watchdog, and are capable of
# resetting the system on time-out.

# Uncomment this to use the watchdog device driver access "file".

#watchdog-device                = /dev/watchdog

# Uncomment and edit this line for hardware timeout values that differ
# from the default of one minute.

watchdog-timeout       = 10

# If your watchdog trips by itself when the first timeout interval
# elapses then try uncommenting the line below and changing the
# value to 'yes'.

#watchdog-refresh-use-settimeout        = auto

# If you have a buggy watchdog device (e.g. some IPMI implementations)
# try uncommenting this line and setting it to 'yes'.

#watchdog-refresh-ignore-errors = no

# ====================== Other system settings ========================
#
# Interval between tests. Should be a couple of seconds shorter than
# the hardware time-out value.

#interval               = 1

# The number of intervals skipped before a log message is written (i.e.
# a multiplier for 'interval' in terms of syslog messages)

#logtick        = 1

# Directory for log files (probably best not to change this)

#log-dir                = /var/log/watchdog

# Email address for sending the reboot reason. This needs sendmail to
# be installed and properly configured. Maybe you should just enable
# syslog forwarding instead?

#admin                  = root

# Lock the daemon in to memory as a real-time process. This greatly
# decreases the chance that watchdog won't be scheduled before your
# machine is really loaded.

realtime                = yes
priority                = 1

# ====================== How to handle errors  =======================
#
# If you have a custom binary/script to handle errors then uncomment
# this line and provide the path. For 'v1' test binary files they also
# handle error cases.

#repair-binary          = /usr/sbin/repair
#repair-timeout         = 60

# The retry-timeout and repair limit are used to handle errors in a
# more robust manner. Errors must persist for longer than this to
# action a repair or reboot, and if repair-maximum attempts are
# made without the test passing a reboot is initiated anyway.

#retry-timeout          = 60
#repair-maximum         = 1

# Configure the delay on reboot from sending SIGTERM to all processes
# and to following up with SIGKILL for any that are ignoring the polite
# request to stop.

#sigterm-delay          = 5

# ====================== User-specified tests ========================
#
# Specify the directory for auto-added 'v1' test programs (any executable
# found in the 'test-directory should be listed).

#test-directory = /etc/watchdog.d

# Specify any v0 custom tests here. Multiple lines are permitted, but
# having any 'v1' programs/scripts discovered in the 'test-directory' is
# the better way.

#test-binary            =

# Specify the time-out value for a test error to be reported.

#test-timeout           = 60

# ====================== Typical tests ===============================
#
# Specify any IPv4 numeric addresses to be probed.
# NOTE: You should check you have permission to ping any machine before
# using it as a test. Also remember if the target goes down then this
# machine will reboot as a result!

#ping                   = 172.16.0.1
#ping                   = 192.168.1.1

# Set the number of ping attempts in each 'interval' of time. Default
# is 3 and it completes on the first successful ping.
# NOTE: Round-trip delay has to be less than 'interval' / 'ping-count'
# for test success, but this is unlikely to be exceeded except possibly
# on satellite links (very unlikely case!).

#ping-count             = 3

# Specify any network interface to be checked for activity.

#interface              = eth0

# Specify any files to be checked for presence, and if desired, checked
# that they have been updated more recently than 'change' seconds.

#file                   = /var/log/syslog
#change                 = 1407

# Uncomment to enable load average tests for 1, 5 and 15 minute
# averages. Setting one of these values to '0' disables it. These
# values will hopefully never reboot your machine during normal use
# (if your machine is really hung, the loadavg will go much higher
# than 25 in most cases).

#max-load-1             = 24
#max-load-5             = 18
#max-load-15            = 12

# Check available memory on the machine.
#
# The min-memory check is a passive test from reading the file
# /proc/meminfo and computed from MemFree + Buffers + Cached
# If this is below a few tens of MB you are likely to have problems.
#
# The allocatable-memory is an active test checking it can be paged
# in to use.
#
# Maximum swap should be based on normal use, probably a large part of
# available swap but paging 1GB of swap can take tens of seconds.
#
# NOTE: This is the number of pages, to get the real size, check how
# large the pagesize is on your machine (typically 4kB for x86 hardware).

#min-memory             = 1
#allocatable-memory     = 1
#max-swap = 0

# Check for over-temperature. Typically the temperature-sensor is a
# 'virtual file' under /sys and it contains the temperature in
# milli-Celsius. Usually these are generated by the 'sensors' package,
# but take care as device enumeration may not be fixed.

#temperature-sensor     =
#max-temperature        = 90

# Check for a running process/daemon by its PID file. For example,
# check if rsyslogd is still running by enabling the following line:

#pidfile                = /var/run/rsyslogd.pid
EOL
echo "----------------------------------------------------------------"
echo "Watchdog installed"
echo "----------------------------------------------------------------"
echo "Setting up Service....."
sudo systemctl enable watchdog
echo "----------------------------------------------------------------"
echo "Service created."
echo "----------------------------------------------------------------"
echo "Starting Starting"
sudo systemctl start watchdog
echo "----------------------------------------------------------------"
echo "use journalctl -u watchdog.service to display the log"
echo "----------------------------------------------------------------"
echo "use :(){ :|:& };: to crash the system on purpose"
echo "----------------------------------------------------------------"
echo "Getting Status Status close with ctrl+c"
echo "----------------------------------------------------------------"
sudo systemctl -l status watchdog





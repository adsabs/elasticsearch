#!/usr/bin/python

import os
import time
import subprocess

def disk_free():
    st = os.statvfs('/etc/hosts')
    return ((st.f_bavail * st.f_frsize))/(1.0e9)

def run_curator(days):
    cmd = ['curator', 'delete', 'indices', '--older-than', '{}'.format(days), '--time-unit', 'days', '--timestring', '%Y.%m.%d']
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    std_out, std_err = process.communicate()
    return std_out, std_err

wanted_disk_space = 1.5

for i in range(31, 6, -1):

    disk_free_now = disk_free()
    if disk_free_now > wanted_disk_space:
        print 'Wanted disk space: {}G reached: {}G'.format(wanted_disk_space, disk_free_now)
        break

    print 'Free disk size: {}G want free space: {}G'.format(disk_free_now, wanted_disk_space)
    print 'Running curator for weeks: {}'.format(i)
    print run_curator(i)
    time.sleep(2)

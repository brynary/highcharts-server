Highcharts Server
=================

Small server for generating Highcharts PNGs server-side (e.g.g for use in emails).

Install
-------

1. Boot an Ubuntu 11.04 Natty instance:

        ec2run -k key_name ami-06ad526f

1. Install CutyCapt and XVFB:

        sudo apt-get install cutycapt xvfb ruby rubygems1.8

1. Setup highcharts-server:

        sudo useradd -d /home/highcharts-server -m highcharts-server
        sudo su highcharts-server
        cd
        git clone git://github.com/brynary/highcharts-server.git
        cd highcharts-server
        sudo foreman export upstart /etc/init
        sudo start highcharts-server

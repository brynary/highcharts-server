Highcharts Server
=================

Small server for generating Highcharts PNGs server-side (e.g.g for use in emails).

Install
-------

1. Boot an Ubuntu 11.04 Natty instance:

        ec2run -t t1.micro -k key_name ami-06ad526f

1. Install CutyCapt, XVFB, Git and Ruby:

        sudo apt-get update
        sudo apt-get upgrade -y
        sudo apt-get install -y cutycapt xvfb ruby rubygems1.8
        sudo gem install bundler --pre

1. Setup highcharts-server:

        sudo useradd -d /home/highcharts-server -m highcharts-server
        sudo su highcharts-server -
        cd
        git clone git://github.com/brynary/highcharts-server.git
        cd highcharts-server
        sudo su
        cd /home/highcharts-server/highcharts/server
        sudo /var/lib/gems/1.8/bin/bundle install --binstubs
        sudo /var/lib/gems/1.8/bin/foreman export upstart /etc/init
        sudo start highcharts-server

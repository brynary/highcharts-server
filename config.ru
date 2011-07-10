$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))
require "highcharts_server"
run HighchartsServer::Server

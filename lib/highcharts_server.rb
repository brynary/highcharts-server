require "sinatra"
require "active_support/all"
require "json"
require "digest"
require "highcharts_server/cuty_capt"

module HighchartsServer
  def self.root
    Pathname.new(File.dirname(__FILE__)).join("..").expand_path
  end

  class Server < Sinatra::Base
    post "/charts" do
      chart_options = JSON.parse(request.env["rack.input"].read)
      hash = Digest::MD5.hexdigest(chart_options.to_json)
      image_path = HighchartsServer.root.join("tmp", "charts-#{hash}-#{Time.now.to_i}-#{$$}.png").to_s
      cuty_capt = CutyCapt.new(chart_options)
      cuty_capt.write_to(image_path)
      send_file image_path, :type => "image/png"
    end
  end
end

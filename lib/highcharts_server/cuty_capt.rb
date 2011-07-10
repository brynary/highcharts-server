require "shellwords"
require "json"
require "pathname"

require "highcharts_server/command_executor"

module HighchartsServer
  class CutyCapt
    attr_reader :chart_options

    def initialize(chart_options, executor = CommandExecutor.new)
      @chart_options = chart_options
      @chart_options["chart"] ||= {}
      @chart_options["chart"]["renderTo"] = "container"
      @executor = executor
    end

    def write_to(path)
      write_html
      capture_png
      html_path.unlink
      crop_to(path)
    end

  private

    def capture_png
      @executor.run!(%Q{cutycapt --url=#{path_to_url(html_path).shellescape} --out=#{capture_tempfile.path.shellescape} --out-format=png})
    end

    def crop_to(path)
      @executor.run!(%Q{convert #{capture_tempfile.path.shellescape} -crop #{width}x#{height}+15+0 #{path.shellescape}})
    end

    def path_to_url(path)
      "file://#{path}"
    end

    def capture_tempfile
      @capture_tempfile ||= Tempfile.new("chart-png")
    end

    def write_html
      html_path.open("w") do |f|
        f.write(html)
      end
    end

    def html
      template = ERB.new(File.read(File.join(File.dirname(__FILE__), "chart.html.erb")))
      template.result(binding)
    end

    def html_path
      working_directory.join("chart_#{$$}.html")
    end

    def working_directory
      HighchartsServer.root.join("tmp")
    end

    def width
      @chart_options["chart"]["width"]
    end

    def height
      @chart_options["chart"]["height"]
    end

  end

end

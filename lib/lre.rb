require 'rake'
require 'fattr'
%w(file_reload rake_ext).each do |f|
  require File.expand_path(File.dirname(__FILE__)) + "/lre/#{f}.rb"
end

module LRE
  class << self
    fattr(:watch_dirs) do
      ["."]
    end
    def load_config!
      dir = Dir.getwd
      config_file = "#{dir}/.lre"
      #Thread.new do 
        puts "starting config load"
        load(config_file) 
        puts "loaded config"
      #end if FileTest.exist?(config_file)
    end
    def start!
      load_config!
      FileReload.run!
      require 'irb'
      IRB.start
    end
    def stop!
      FileReload.stop!
    end
  end
end
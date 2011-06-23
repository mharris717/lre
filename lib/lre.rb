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
      load(config_file) 
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
    def watch(pattern,&b)
      FileReload.watches[pattern] = b
    end
  end
end
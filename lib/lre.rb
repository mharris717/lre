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
    def add_watch_dir(*ds)
      [ds].flatten.each do |d|
        self.watch_dirs << d
      end
    end
    def load_config!
      config_files = ["~/.lre","#{Dir.getwd}/.lre"]
      config_files.each do |f|
        load(f) if FileTest.exists?(f)
      end
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
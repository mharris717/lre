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
    def start_irb!
      return if @start_irb
      require 'irb'
      @start_irb = true
      IRB.start
    end
    def from_cli!(f)
      if f
        load_config!
        load(f)
      else
        start!
      end
    end
    def start!
      load_config!
      FileReload.run!
      
      start_irb!
    end
    def stop!
      FileReload.stop!
    end
    def watch(pattern,&b)
      FileReload.watches[pattern] = b
    end
    def on_every_file(&b)
      FileReload.on_every_file = b
    end
    def name(n=nil)
      if n
        FileReload.instance_name = n
      else
        FileReload.instance_name
      end
    end
  end
end
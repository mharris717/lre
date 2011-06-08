require 'fattr'
%w(file_reload rake_ext).each do |f|
  require File.expand_path(File.dirname(__FILE__)) + "/lre/#{f}.rb"
end

module LRE
  class << self
    fattr(:watch_dirs) do
      ["."]
    end
    def start!
      dir = Dir.getwd
      config_file = "#{dir}/.lre"
      load(config_file) if FileTest.exist?(config_file)
      FileReload.run!
      require 'irb'
      IRB.start
    end
  end
end
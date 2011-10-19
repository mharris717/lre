module FileReload
  def self.method_missing(sym,*args,&b)
    Base.instance.send(sym,*args,&b)
  end
  class Base
    class << self
      fattr(:instance) { new }
    end
    attr_accessor :script, :on_every_file, :instance_name
    fattr(:threads) { [] }
    def should_load?(f)
      str = File.read(f)
      if str =~ /--dontload({.+})?/
        if !$1
          false
        else
          n = $1[1..-2]
          !(instance_name.to_s == n)
        end
      elsif str =~ /--onlyload{(.+)}/
        $1 == instance_name.to_s
      else
        true
      end
    end
    def process_file(f,&b)
      if !FileTest.exists?(f)
        puts "file doesn't exist #{f}"
        return
      end
      if should_load?(f)
        on_every_file[File.expand_path(f)] if on_every_file
        puts "loading #{f}"
        b[f]
      else
        puts "didn't load #{f}"
      end
      print ">"
    rescue => exp
      puts "error loading #{f}"
      puts exp.message + "\n" + exp.backtrace.join("\n")
    rescue SyntaxError => exp
      puts "syntax error loading #{f}"
      puts exp.message + "\n" + exp.backtrace.join("\n")
    rescue RuntimeError => exp
      puts "runtime error"
      puts exp.message
    end
    def stop!
      self.threads.each { |x| x.kill }
      self.threads = []
    end
    fattr(:watches) do
      res = {}
      res[".*\.rb$"] = lambda do |f|
        load f
      end
      res
    end
    def run!
      require 'watchr'
      require 'pathname'
      self.script = Watchr::Script.new
      watches.each do |file_match,proc|
        script.watch(file_match) do |md|
          f = md[0]
          process_file(f,&proc)
        end
      end
      
      self.threads.each { |x| x.kill }
      self.threads = []
      
      LRE.watch_dirs.uniq.each do |d|
        c = Watchr::Controller.new(script, Watchr.handler.new)
        c.base_path = d
        puts "adding thread #{d}"
        self.threads << Thread.new { c.run }
      end
    end
  end
end


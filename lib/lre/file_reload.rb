module FileReload
  def self.method_missing(sym,*args,&b)
    Base.instance.send(sym,*args,&b)
  end
  class Base
    class << self
      fattr(:instance) { new }
    end
    attr_accessor :script
    fattr(:threads) { [] }
    def reload_file(f)
      if !FileTest.exists?(f)
        puts "file doesn't exist #{f}"
        return
      end
      puts "loading #{f}"
      load f 
      print ">"
    rescue => exp
      puts "error loading #{f}"
      puts exp.message + "\n" + exp.backtrace.join("\n")
    rescue SyntaxError => exp
      puts "syntax error loading #{f}"
      puts exp.message + "\n" + exp.backtrace.join("\n")
    end
    def stop!
      self.threads.each { |x| x.kill }
      self.threads = []
    end
    fattr(:watches) do
      res = {}
      res[".*\.rb$"] = lambda do |f|
        reload_file(f)
      end
      res
    end
    def run!
      require 'watchr'
      require 'pathname'
      self.script = Watchr::Script.new
      watches.each do |file_match,proc|
        script.watch(file_match) do |md|
          proc[md[0]]
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


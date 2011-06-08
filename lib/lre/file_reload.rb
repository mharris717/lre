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
      #return if f =~ /watchr_script/
      puts "loading #{f}"
      load f 
      print ">"
    rescue => exp
      puts "error loading #{f}"
      puts exp.message + "\n" + exp.backtrace.join("\n")
    end
    def run!
      require 'watchr'
      require 'pathname'
      self.script = Watchr::Script.new
      script.watch(".*\.rb$") do |md| 
        f = md[0]
        reload_file(f)
      end
      
      LRE.watch_dirs.each do |d|
        c = Watchr::Controller.new(script, Watchr.handler.new)
        c.base_path = d
        self.threads << Thread.new { c.run }
      end
    end
  end
end


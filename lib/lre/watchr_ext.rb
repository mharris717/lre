require 'watchr'

Watchr::Controller.class_eval do
  attr_accessor :base_path
  def monitored_paths
    p = base_path ? "#{base_path}/**/*" : "**/*"
    paths = Dir[p].select do |path|
      @script.patterns.any? {|p| path.match(p) }
    end
    paths.push(@script.path).compact!
    paths.map {|path| Pathname(path).expand_path }
  end
end


require 'rake'
module Rake
  class Task
    def actions=(x)
      @actions = x
    end
  end
end

def gt(n)
  t = Rake::Task[n]
  #puts "action size #{t.actions.size}"
  t.actions = t.actions[-1..-1] if t.actions.size > 1
  t.invoke
end

def gte(n)
  t = Rake::Task[n]
  #puts "action size #{t.actions.size}"
  t.actions = t.actions[-1..-1] if t.actions.size > 1
  t.execute
end
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "pry"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do 
  Pry.start
end  

require 'dotenv/tasks'

task mytask: :dotenv do
    "ruby_wrapper_watson"
end

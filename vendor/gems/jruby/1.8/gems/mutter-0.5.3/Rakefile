require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mutter"
    gem.summary = %Q{the tiny CLI library}
    gem.description = %Q{the tiny command-line interface library with lots of style}
    gem.email = "self@cloudhead.net"
    gem.homepage = "http://github.com/cloudhead/mutter"
    gem.authors = ["cloudhead"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new("spec") do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--color', '--format=specdoc']
end

task :test do
  Rake::Task['spec'].invoke
end

task :default => :spec

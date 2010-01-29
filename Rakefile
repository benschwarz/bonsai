# coding: utf-8
begin
  require File.dirname(__FILE__) + '/vendor/gems/environment'
rescue LoadError
  raise <<-HELP
    Bonsai uses the gem bundler to handle its development dependencies under 
    multiple environments. So if you're testing under 1.8, 1.9, jruby or otherwise
    you should ensure that you have the `bundler` gem installed.
    
    Then run `gem bundle`. Following going through these steps you should
    not see this error message. If you do, please contact me or raise an issue.
      (http://github.com/benschwarz/bonsai/issues)
  HELP
end

require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bonsai"
    gem.summary = %Q{A static site generator that uses the best toolset available}
    gem.description = %Q{A static site generator that uses the best toolset available}
    gem.email = "ben.schwarz@gmail.com"
    gem.homepage = "http://github.com/benschwarz/bonsai"
    gem.authors = ["Ben Schwarz"]
    gem.executables = ['bonsai']
    gem.add_development_dependency "rspec", ">= 1.3.0"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency "tilt", ">= 0.5"
    gem.add_dependency "mustache", ">= 0.5.0"
    gem.add_dependency "builder", ">= 2.1.2"
    gem.add_dependency "watch", ">= 0.1.0"
    gem.add_dependency "sinatra", ">= 0.9.4"
    gem.add_dependency "maruku", ">= 0.6.0"
    gem.add_dependency "less", ">= 1.2.17"
    gem.add_dependency "rack", ">= 1.1.0"
    gem.add_dependency "launchy", ">= 0.3.3"

    gem.post_install_message = %q{

      盆栽
      bonsai, tiny and beautiful



      type `bonsai --help` to get started
    }

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

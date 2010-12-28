# coding: utf-8

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
    gem.has_rdoc = false
    gem.files.exclude 'vendor/gems'
    
    gem.add_development_dependency "rspec", ">= 1.3.0"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency "tilt", ">= 0.5"
    gem.add_dependency "mustache", ">= 0.5.0"
    gem.add_dependency "builder", ">= 2.1.2"
    gem.add_dependency "watch", ">= 0.1.0"
    gem.add_dependency "sinatra", ">= 0.9.4"
    gem.add_dependency "maruku", ">= 0.6.0"
    gem.add_dependency "less", ">= 1.2.17"
    gem.add_dependency "rack", ">= 1.2.1"
    gem.add_dependency "launchy", ">= 0.3.3"
    gem.add_dependency "activesupport", ">= 2.3.5"

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

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

RSpec::Core::RakeTask.new('rcov') do |spec|
  spec.rcov = true
  spec.rcov_opts = %w[--exclude spec]
end

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

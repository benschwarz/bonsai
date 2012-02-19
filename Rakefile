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
    
    gem.add_development_dependency "rspec", "~> 2.8.0"
    gem.add_development_dependency "rake"
    gem.add_development_dependency "yard", "~> 0.7.5"
    gem.add_development_dependency "jeweler", "1.5.2"
    
    
    gem.add_dependency "rack"
    gem.add_dependency "sinatra", ">= 1.0"
    gem.add_dependency "tilt", ">= 1.3"
    gem.add_dependency "liquid", ">= 2.2.2"
    gem.add_dependency "builder", ">= 3.0.0"
    gem.add_dependency "watch", ">= 0.1.0"
    gem.add_dependency "maruku", ">= 0.6.0"
    gem.add_dependency "launchy", ">= 0.3.7"
    gem.add_dependency "activesupport", ">= 3.0.3"
    gem.add_dependency "i18n", ">= 0.5.0"
    gem.add_dependency "sass"
    
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

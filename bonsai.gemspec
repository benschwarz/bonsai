# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bonsai/version"

Gem::Specification.new do |s|
  s.name        = "bonsai"
  s.version     = Bonsai::VERSION
  s.authors     = ["Ben Schwarz"]
  s.email       = ["ben.schwarz@gmail.com"]
  s.homepage    = "http://github.com/benschwarz/bonsai"
  s.summary     = %Q{A static site generator that uses the best toolset available}
  s.description = %Q{A static site generator that uses the best toolset available}

  s.rubyforge_project = "bonsai"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "yard", "~> 0.7.5"
  s.add_development_dependency "jeweler", "1.8.4"
  s.add_development_dependency "rdoc-data"
  
  s.add_dependency "rack"
  s.add_dependency "sinatra", ">= 1.0"
  s.add_dependency "tilt", ">= 1.3"
  s.add_dependency "liquid", ">= 2.2.2"
  s.add_dependency "builder", ">= 3.0.0"
  s.add_dependency "watch", ">= 0.1.0"
  s.add_dependency "maruku", ">= 0.6.0"
  s.add_dependency "launchy", ">= 0.3.7"
  s.add_dependency "activesupport", ">= 3.0.3"
  s.add_dependency "i18n", ">= 0.5.0"
  s.add_dependency "sass"
  
  s.post_install_message = %q{

    盆栽
    bonsai, tiny and beautiful



    type `bonsai --help` to get started
  }
end


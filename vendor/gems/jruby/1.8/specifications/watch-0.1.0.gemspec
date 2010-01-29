# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watch}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Schwarz"]
  s.date = %q{2010-01-01}
  s.description = %q{A dirt simple mechanism to tell if files have changed}
  s.email = %q{ben.schwarz@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = [".document", ".gitignore", "LICENSE", "README.md", "Rakefile", "VERSION", "lib/watch.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/watcher_spec.rb", "watch.gemspec"]
  s.homepage = %q{http://github.com/benschwarz/watch}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A simple directory}
  s.test_files = ["spec/spec_helper.rb", "spec/watcher_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tilt}
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Tomayko"]
  s.date = %q{2010-01-15}
  s.description = %q{Generic interface to multiple Ruby template engines}
  s.email = %q{r@tomayko.com}
  s.extra_rdoc_files = ["COPYING"]
  s.files = ["COPYING", "README.md", "Rakefile", "TEMPLATES.md", "bin/tilt", "lib/tilt.rb", "test/tilt_buildertemplate_test.rb", "test/tilt_cache_test.rb", "test/tilt_erbtemplate_test.rb", "test/tilt_erubistemplate_test.rb", "test/tilt_hamltemplate_test.rb", "test/tilt_lesstemplate_test.rb", "test/tilt_liquidtemplate_test.rb", "test/tilt_mustachetemplate_test.rb", "test/tilt_rdiscounttemplate_test.rb", "test/tilt_rdoctemplate_test.rb", "test/tilt_redclothtemplate_test.rb", "test/tilt_sasstemplate_test.rb", "test/tilt_stringtemplate_test.rb", "test/tilt_template_test.rb", "test/tilt_test.rb", "tilt.gemspec"]
  s.homepage = %q{http://github.com/rtomayko/tilt/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Tilt", "--main", "Tilt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wink}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Generic interface to multiple Ruby template engines}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<contest>, [">= 0"])
      s.add_development_dependency(%q<builder>, [">= 0"])
      s.add_development_dependency(%q<erubis>, [">= 0"])
      s.add_development_dependency(%q<haml>, [">= 0"])
      s.add_development_dependency(%q<mustache>, [">= 0"])
      s.add_development_dependency(%q<rdiscount>, [">= 0"])
      s.add_development_dependency(%q<liquid>, [">= 0"])
      s.add_development_dependency(%q<less>, [">= 0"])
    else
      s.add_dependency(%q<contest>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<erubis>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<mustache>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 0"])
      s.add_dependency(%q<liquid>, [">= 0"])
      s.add_dependency(%q<less>, [">= 0"])
    end
  else
    s.add_dependency(%q<contest>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<erubis>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<mustache>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 0"])
    s.add_dependency(%q<liquid>, [">= 0"])
    s.add_dependency(%q<less>, [">= 0"])
  end
end

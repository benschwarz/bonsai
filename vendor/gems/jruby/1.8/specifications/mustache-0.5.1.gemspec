# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mustache}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath"]
  s.date = %q{2009-12-15}
  s.default_executable = %q{mustache}
  s.description = %q{Mustache is a framework-agnostic way to render logic-free views.}
  s.email = %q{chris@ozmm.org}
  s.executables = ["mustache"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = [".gitignore", ".kick", "CONTRIBUTORS", "HISTORY.md", "LICENSE", "README.md", "Rakefile", "benchmarks/complex.erb", "benchmarks/complex.haml", "benchmarks/helper.rb", "benchmarks/simple.erb", "benchmarks/speed.rb", "bin/mustache", "contrib/mustache.vim", "contrib/tpl-mode.el", "examples/comments.mustache", "examples/comments.rb", "examples/complex_view.mustache", "examples/complex_view.rb", "examples/delimiters.mustache", "examples/delimiters.rb", "examples/double_section.mustache", "examples/double_section.rb", "examples/escaped.mustache", "examples/escaped.rb", "examples/inner_partial.mustache", "examples/inner_partial.txt", "examples/namespaced.mustache", "examples/namespaced.rb", "examples/partial_with_module.mustache", "examples/partial_with_module.rb", "examples/passenger.conf", "examples/passenger.rb", "examples/simple.mustache", "examples/simple.rb", "examples/template_partial.mustache", "examples/template_partial.rb", "examples/template_partial.txt", "examples/unescaped.mustache", "examples/unescaped.rb", "lib/mustache.rb", "lib/mustache/context.rb", "lib/mustache/sinatra.rb", "lib/mustache/template.rb", "lib/mustache/version.rb", "lib/rack/bug/panels/mustache_panel.rb", "lib/rack/bug/panels/mustache_panel/mustache_extension.rb", "lib/rack/bug/panels/mustache_panel/view.mustache", "test/autoloading_test.rb", "test/helper.rb", "test/mustache_test.rb", "test/partial_test.rb"]
  s.homepage = %q{http://github.com/defunkt/mustache}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Mustache is a framework-agnostic way to render logic-free views.}
  s.test_files = ["test/autoloading_test.rb", "test/helper.rb", "test/mustache_test.rb", "test/partial_test.rb", "examples/comments.rb", "examples/complex_view.rb", "examples/delimiters.rb", "examples/double_section.rb", "examples/escaped.rb", "examples/namespaced.rb", "examples/partial_with_module.rb", "examples/passenger.rb", "examples/simple.rb", "examples/template_partial.rb", "examples/unescaped.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

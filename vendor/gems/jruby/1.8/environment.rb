# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["PATH"]     = "#{dir}/../../../../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/polyglot-0.2.9/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/polyglot-0.2.9/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mutter-0.5.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mutter-0.5.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/treetop-1.4.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/treetop-1.4.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/less-1.2.21/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/less-1.2.21/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/syntax-1.0.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/syntax-1.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.3.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rspec-1.3.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/maruku-0.6.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/maruku-0.6.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.1.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.1.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sinatra-0.9.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/sinatra-0.9.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mustache-0.5.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mustache-0.5.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/yard-0.5.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/yard-0.5.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json_pure-1.2.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/json_pure-1.2.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rubyforge-2.0.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rubyforge-2.0.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/git-1.2.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/git-1.2.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/jeweler-1.4.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/jeweler-1.4.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/gemcutter-0.3.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/gemcutter-0.3.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/configuration-1.1.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/configuration-1.1.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/launchy-0.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/launchy-0.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/tilt-0.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/tilt-0.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/watch-0.1.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/watch-0.1.0/lib")

  @gemfile = "#{dir}/../../../../Gemfile"

  require "rubygems" unless respond_to?(:gem) # 1.9 already has RubyGems loaded

  @bundled_specs = {}
  @bundled_specs["polyglot"] = eval(File.read("#{dir}/specifications/polyglot-0.2.9.gemspec"))
  @bundled_specs["polyglot"].loaded_from = "#{dir}/specifications/polyglot-0.2.9.gemspec"
  @bundled_specs["mutter"] = eval(File.read("#{dir}/specifications/mutter-0.5.3.gemspec"))
  @bundled_specs["mutter"].loaded_from = "#{dir}/specifications/mutter-0.5.3.gemspec"
  @bundled_specs["treetop"] = eval(File.read("#{dir}/specifications/treetop-1.4.3.gemspec"))
  @bundled_specs["treetop"].loaded_from = "#{dir}/specifications/treetop-1.4.3.gemspec"
  @bundled_specs["less"] = eval(File.read("#{dir}/specifications/less-1.2.21.gemspec"))
  @bundled_specs["less"].loaded_from = "#{dir}/specifications/less-1.2.21.gemspec"
  @bundled_specs["syntax"] = eval(File.read("#{dir}/specifications/syntax-1.0.0.gemspec"))
  @bundled_specs["syntax"].loaded_from = "#{dir}/specifications/syntax-1.0.0.gemspec"
  @bundled_specs["rspec"] = eval(File.read("#{dir}/specifications/rspec-1.3.0.gemspec"))
  @bundled_specs["rspec"].loaded_from = "#{dir}/specifications/rspec-1.3.0.gemspec"
  @bundled_specs["maruku"] = eval(File.read("#{dir}/specifications/maruku-0.6.0.gemspec"))
  @bundled_specs["maruku"].loaded_from = "#{dir}/specifications/maruku-0.6.0.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.1.0.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.1.0.gemspec"
  @bundled_specs["sinatra"] = eval(File.read("#{dir}/specifications/sinatra-0.9.4.gemspec"))
  @bundled_specs["sinatra"].loaded_from = "#{dir}/specifications/sinatra-0.9.4.gemspec"
  @bundled_specs["mustache"] = eval(File.read("#{dir}/specifications/mustache-0.5.1.gemspec"))
  @bundled_specs["mustache"].loaded_from = "#{dir}/specifications/mustache-0.5.1.gemspec"
  @bundled_specs["yard"] = eval(File.read("#{dir}/specifications/yard-0.5.3.gemspec"))
  @bundled_specs["yard"].loaded_from = "#{dir}/specifications/yard-0.5.3.gemspec"
  @bundled_specs["json_pure"] = eval(File.read("#{dir}/specifications/json_pure-1.2.0.gemspec"))
  @bundled_specs["json_pure"].loaded_from = "#{dir}/specifications/json_pure-1.2.0.gemspec"
  @bundled_specs["rubyforge"] = eval(File.read("#{dir}/specifications/rubyforge-2.0.3.gemspec"))
  @bundled_specs["rubyforge"].loaded_from = "#{dir}/specifications/rubyforge-2.0.3.gemspec"
  @bundled_specs["git"] = eval(File.read("#{dir}/specifications/git-1.2.5.gemspec"))
  @bundled_specs["git"].loaded_from = "#{dir}/specifications/git-1.2.5.gemspec"
  @bundled_specs["jeweler"] = eval(File.read("#{dir}/specifications/jeweler-1.4.0.gemspec"))
  @bundled_specs["jeweler"].loaded_from = "#{dir}/specifications/jeweler-1.4.0.gemspec"
  @bundled_specs["rake"] = eval(File.read("#{dir}/specifications/rake-0.8.7.gemspec"))
  @bundled_specs["rake"].loaded_from = "#{dir}/specifications/rake-0.8.7.gemspec"
  @bundled_specs["gemcutter"] = eval(File.read("#{dir}/specifications/gemcutter-0.3.0.gemspec"))
  @bundled_specs["gemcutter"].loaded_from = "#{dir}/specifications/gemcutter-0.3.0.gemspec"
  @bundled_specs["configuration"] = eval(File.read("#{dir}/specifications/configuration-1.1.0.gemspec"))
  @bundled_specs["configuration"].loaded_from = "#{dir}/specifications/configuration-1.1.0.gemspec"
  @bundled_specs["launchy"] = eval(File.read("#{dir}/specifications/launchy-0.3.5.gemspec"))
  @bundled_specs["launchy"].loaded_from = "#{dir}/specifications/launchy-0.3.5.gemspec"
  @bundled_specs["builder"] = eval(File.read("#{dir}/specifications/builder-2.1.2.gemspec"))
  @bundled_specs["builder"].loaded_from = "#{dir}/specifications/builder-2.1.2.gemspec"
  @bundled_specs["tilt"] = eval(File.read("#{dir}/specifications/tilt-0.5.gemspec"))
  @bundled_specs["tilt"].loaded_from = "#{dir}/specifications/tilt-0.5.gemspec"
  @bundled_specs["watch"] = eval(File.read("#{dir}/specifications/watch-0.1.0.gemspec"))
  @bundled_specs["watch"].loaded_from = "#{dir}/specifications/watch-0.1.0.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end

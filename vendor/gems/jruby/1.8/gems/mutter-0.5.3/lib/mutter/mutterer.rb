module Mutter
  class Mutterer
    @stream = STDOUT  # output stream
    @color = false    # force color

    # Initialize the styles, and load the defaults from +styles.yml+
    #
    # @active: currently active styles, which apply to the whole string
    # @styles: contains all the user + default styles
    #
    def initialize obj = {}
      self.reset
      @defaults = load 'default'

      case obj
        when Hash       # A style definition: expand quick-styles and merge with @styles
          @styles = obj.inject({}) do |h, (k, v)|
            h.merge k =>
              (v.is_a?(Hash) ? v : { :match => v, :style => [k].flatten })
          end
        when Array      # An array of styles to be activated
          @active = obj
        when Symbol     # A single style to be activated
          self << obj
        when String     # The path of a yaml style-sheet
          @styles = load obj
        else raise ArgumentError
      end

      #
      # Create an instance method for each style
      #
      self.styles.keys.each do |style|
        (class << self; self end).class_eval do
          define_method style do |msg|
            say msg, style
          end
        end if style.is_a? Symbol
      end
    end

    def styles
      @defaults.merge @styles
    end

    def clear opt = :all
      case opt
        when :user     then @styles = {}
        when :styles   then @styles, @defaults = {}, {}
        when :active   then @active = []
        when :all      then @active, @styles, @defaults = [], {}, {}
        when :default,
             :defaults then @defaults = {}
        else           raise ArgumentError, "[:user, :default, :active, :all] only"
      end
      self
    end
    alias :reset clear

    #
    # Loads styles from a YAML style-sheet,
    #   and converts the keys to symbols
    #
    def load styles
      styles += '.yml' unless styles =~ /\.ya?ml$/
      styles = File.join(File.dirname(__FILE__), "styles", styles) unless File.exist? styles
      YAML.load_file(styles).inject({}) do |h, (key, value)|
        value = { :match => value['match'], :style => value['style'] }
        h.merge key.to_sym => value
      end
    end

    def color?
      (ENV['TERM'].include?('color') && self.class.stream.tty?) || self.class.color
    end

    #
    # Output to @stream
    #
    def say msg, *styles
      self.write((color?? process(msg, *styles) : unstyle(msg)) + "\n") ; nil
    end
    alias :print say

    #
    # Remove all tags from string
    #
    def unstyle msg
      styles.map do |_,v|
        v[:match]
      end.flatten.inject(msg) do |m, tag|
        m.gsub(tag, '')
      end
    end

    #
    #  Parse the message, but also apply a style on the whole thing
    #
    def process msg, *styles
      stylize(parse(msg), @active + styles).gsub(/\e(\d+)\e/, "\e[\\1m")
    end
    alias :[] process

    #
    # Write to the out stream, and flush it
    #
    def write str
      self.class.stream.tap do |stream|
        stream.write str
        stream.flush
      end ; nil
    end

    #
    # Create a table
    #
    def table *args, &blk
      Table.new(*args, &blk)
    end

    #
    # Add and remove styles from the active styles
    #
    def << style
      @active << style
    end

    def >> style
      @active.delete style
    end

    def + style
      dup.tap {|m| m << style }
    end

    def - style
      dup.tap {|m| m >> style }
    end

    #
    # Parse a string to ANSI codes
    #
    #   if the glyph is a pair, we match [0] as the start
    #   and [1] as the end marker.
    #   the matches are sent to +stylize+
    #
    def parse string
      self.styles.inject(string) do |str, (name, options)|
        glyph, style = options[:match], options[:style]
        if glyph.is_a? Array
          str.gsub(/#{Regexp.escape(glyph.first)}(.*?)
                    #{Regexp.escape(glyph.last)}/x) { stylize $1, style }
        else
          str.gsub(/(#{Regexp.escape(glyph)}+)(.*?)\1/) { stylize $2, style }
        end
      end
    end

    #
    # Apply styles to a string
    #
    #   if the style is a default ANSI style, we add the start
    #   and end sequence to the string.
    #
    #   if the style is a custom style, we recurse, sending
    #   the list of ANSI styles contained in the custom style.
    #
    #   TODO: use ';' delimited codes instead of multiple \e sequences
    #
    def stylize string, styles = []
      [styles].flatten.inject(string) do |str, style|
        style = style.to_sym
        if ANSI[:transforms].include? style
          esc str, *ANSI[:transforms][style]
        elsif ANSI[:colors].include? style
          esc str, ANSI[:colors][style], ANSI[:colors][:reset]
        else
          stylize(str, @styles[style][:style])
        end
      end
    end

    #
    # Escape a string, for later replacement
    #
    def esc str, open, close
      "\e#{open}\e" + str + "\e#{close}\e"
    end

    #
    # Output stream (defaults to STDOUT)
    #   mostly for test purposes
    #
    def self.stream
      @stream
    end

    def self.stream= io
      @stream = io
    end

    def self.color
      @color
    end

    def self.color= bool
      @color = bool
    end
  end
end

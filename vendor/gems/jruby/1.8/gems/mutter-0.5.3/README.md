mutter
======

    $ my words come out, 
        in color and
            style

> mutter takes the concepts of **separation of style & content** to the command-line!

setup
-----

    $ sudo gem install mutter -s http://gemcutter.org

synopsis
--------

    require 'mutter'

    mut = Mutter.new                # creates a new 'Mutterer', who talks in command-line language
    mut.say "hello _world_"         # underlines 'world'
    mut.say "hello world",   :bold  # bolds the whole string
    mut.say "hello [world]", :cyan  # inverts 'world', and colors the string cyan
    mut.print "bonjour!"            # alias of `say`
    mut["_hola_"]                   # return the stylized string without printing, alias of #process

### Tables

Define your table structure, arguments are optional.

    table = Mutter::Table.new(:delimiter => '|') do    # Strings which don't fit the column width will be truncated
      column :width => 15, :style => :green            # with '..' by default, you can change that with the :truncater
      column :style => :yellow                         # option.
      column :width => 15, :align => :right
    end

Add some rows

    table << ["gaspar", "morello", 1976]
    table << ["eddie", "vedder", 1964]
    table << ["david", "bowie", 1947]
    
Print.

    print table.to_s

If you want something barebones, you can also do

    t = Mutter::Table.new
    t.rows = (1..10).map {|n| [n, n **2, n **3] }
    t.print

And it'll make sure everything is aligned nicely

styles
------
mutter supports these styles:

    :bold, :underline, :inverse, :blink

and these colors:

    :red, :green, :blue, :yellow, :cyan, :purple, :white, :black

customization
-------------

    styles = {
      :warning => {                     # an alias you can use anywhere in mutter
        :match => ['*!', '!*'],         # will match *!mutter!*
        :style => ['yellow', 'bold']    # these styles will be applied to the match
      },
      :error => {
        :match => '!!',                 # will match !!mutter!!
        :style => ['red', 'underline']
      }
    }
    
    mut = Mutter.new(styles)
    mut.say     "warning, the dogs have escaped!", :warning  # These two are
    mut.warning "warning, the dogs have escaped!"            # equivalent
    mut.say     "gosh, we have an !!error!!"

### YAML
    
The previous example could have (and should really have) been written in a separate .yml file, like so:
    
    warning:
      match: 
        - '*!'
        - '!*
      style:
        - yellow
        - bold

    error:
      match: '!!'
      style:
        - red
        - underline

and then loaded like this:

    Mutter.new("styles.yml")
    
### quick styles

    mut = Mutter.new :yellow => '~'
    mut.say "~[black on yellow!]~"
    
### add/remove styles from an instance

    mut = Mutter.new(:blink)
    mut >> :blink               # remove :blink
    mut << :bold << :underline  # add :bold and :underline
    mut.say "hello mutter."     # bold and underlined
    
That's it!
----------

_have fun_

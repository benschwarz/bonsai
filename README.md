# bonsai

![Build status](https://secure.travis-ci.org/benschwarz/bonsai.png?branch=master "Build status")

Bonsai is a static web site generator, it uses the best tools available for site construction and adheres to best web practices.

## What it does

  * Provides a tiny HTML5, [liquid](http://liquidmarkup.org/) driven template set.
  * Implies a simple structure to get started faster.
  * An inbuilt server for development. No setup required.
  * Tasks to export the site to `output`. Upload the contents of `output`. Job done.
  * Access to page hierarchy through `children`, `siblings`, `ancestors` and `navigation`.
  * Generates `sitemap.xml` ready for search engines to spider your site.
  * Generates `robots.txt` to be friendly to search engines.  
  
## Getting started

  * Install bonsai 

    `gem install bonsai --source http://gemcutter.org`

  * Run the generator

    `bonsai --plant [NAME]`

Type `bonsai --help` for any help with commands

## Presentation

* Introducing Bonsai - at Melbourne Ruby, January 2010

  * [Video](http://vimeo.com/9537550) (with slides)
  * [Slides](http://www.slideshare.net/benschwarz/introducing-bonsai)


## Development server

Unlike other static generators, bonsai provides you with a built in web server. Once you've generated the necessary files (generator included) you can simply start developing. Type `bonsai --cultivate` in the root of the generated site, a web server (rack, with thin) will start up. 

It will also watch for when you save files - taking care of processing your [sass](http://sass-lang.com/) files - kind of like [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/).

## Production server

This is the cool part. Drop a bonsai generated site under pretty much anything. Apache, Nginx, Lighttpd - I don't care.

The generator will provide you with a .htaccess file that will turn on gzip/deflate compression for static assets as well as set long standing http caching timestamps and etags.

### Deployment
  * Run `bonsai --repot`
  * Upload the contents of `site-root/output` to your production server
    * For example: `rsync -ave ssh ./output/ tinytree.info:/var/www/tinytree.info`
    
## Ruby implementations

Bonsai runs under a number of Ruby implementations, MRI (1.8.7, 1.9.1, 1.9.2, 1.9.3), RBX (1.8 mode), JRuby (1.8 mode, 1.9 mode). Check [travis](http://travis-ci.org/#!/benschwarz/bonsai) to see the specifics. 

## Have you used this for a real job? 

Yes. I built (and content filled) a web site with around 160 pages in 5 days.

When I found something that didn't quite work, was too slow or perhaps not even possible I wrote a spec and implemented it later. Better software from real requirements. (I used every feature I implemented)

## Links

  * [Tilt](http://github.com/rtomayko/tilt)
  * [SASS](http://sass-lang.com/)
  * [YUI CSS/Javascript compressor](http://developer.yahoo.com/yui/compressor/)


## Thanks
  
  * [Anthony Kolber](http://github.com/kolber) for writing, then rewriting [Stacey](http://github.com/kolber/stacey) from scratch. We spent many hours talking about best practice and software UX.
  * [Lincoln Stoll](http://github.com/lstoll) for reminding me to use the tools that I know best
  
## Credits
  * [Rohit Arondekar](http://github.com/rohit)
  * [Justin Ridgewell](git://github.com/somedumbme91)
  * [Ralph von der Heyden](http://github.com/ralph)
  * [David Goodlad](http://github.com/dgoodlad)
  * [Philip Harrison](http://github.com/Harrison)

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.  

## Copyright

Copyright (c) 2010 Ben Schwarz. See LICENSE for details.

# bonsai

Bonsai is a static web site generator, it uses the best tools available for site construction and adheres to best web practices.

## Getting started

  * Install bonsai 
  
    `gem install bonsai --source http://gemcutter.org`
  
  * Run the generator
    
    `bonsai --plant [NAME]`
    
Type `bonsai --help` for any help with commands

## Development server

Unlike other static generators, bonsai provides you with a built in web server. Once you've generated the necessary files (generator included) you can simply start developing. Type `bonsai --cultivate` in the root of the generated site, a web server (rack, with thin) will start up. 

It will also watch for when you save files - taking care of processing your [lesscss](http://lesscss.org/) files - kind of like [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/).

## Production server

This is the cool part. Drop a bonsai generated site under pretty much anything. Apache, Nginx, Lighttpd - I don't care.

The generator will provide you with a .htaccess file that will turn on gzip/deflate compression for static assets as well as set long standing http caching timestamps and etags.

### Deployment
  * Run `bonsai --repot`
  * Upload the contents of `site-root/output` to your producton server

## Technology used to make your site better

  * [Mustache](http://github.com/defunkt/mustache)
  * [Less CSS](http://lesscss.org/)
  * [YUI CSS/Javascript compressor](http://developer.yahoo.com/yui/compressor/)
  
## Have you used this for a real job? 

Yes. I built (and content filled) a web site with around 160 pages in 5 days.

When I found something that didn't quite work, was too slow or perhaps not even possible I wrote a spec and implemented it later. Better software from real requirements. (I used every feature I implemented)


## Thanks
  
  * [Anthony Kolber](http://github.com/kolber) for writing, then rewriting [Stacey](http://github.com/kolber/stacey) from scratch. We spent many hours talking about best practice and software UX.
  * [Lincoln Stoll](http://github.com/lstoll) for reminding me to use the tools that I know best


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.  

## Copyright

Copyright (c) 2009 Ben Schwarz. See LICENSE for details.

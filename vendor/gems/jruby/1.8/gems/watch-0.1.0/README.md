# Watch, dirt simple mechanism to tell if files have changed

Pass Watch a Dir.glob friendly path and a block that you'd like to 
be executed when something changes

    Watch.new("**/*") { puts "file added, removed or changed" }

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

# LRE

When debugging or poking around in a project, I often do several things

* Start an IRB session.
* Load some files at the beginning to setup my environment.
* When the code I'm writing gets too long to comfortably write at the IRB prompt, move the code to a file and repeatedly load the file after making changes.
* Make changes to existing files and load those changes.
* Make changes to libraries and load those changes.

LRE makes these things easy.

## Basics

Start LRE with the lre command at the command prompt.

On startup, LRE

* Looks for .lre files in the root of the current directory and the home directory, and loads them if present.  These files are plain ruby files.  Put environment setup code and helper functions here.
* Monitors the current directory for changes to .rb files, and automatically loads changed files.
* Starts an IRB prompt. 

## Additional Features

You can monitor additional directories and file types.

To monitor additional directories, add them in your .lre file.  This will watch for .rb files.


    LRE.add_watch_dir "/code/something", "/code/something_else"

To monitor addtional file types, add a watch in your .lre file

    LRE.watch(".*/run_on_change/.*\.sql") do |f|
      require 'sws'
      str = parse_erb_str(File.read(f))
      SWS.execute_str! str
    end

LRE won't automatically pick up on new files, only changed files.  Calling LRE.start! will cause new files to be monitored going forward.

    LRE.start!


## Installing

    gem install lre
    
## Other

LRE is short for Little Ruby Environment or nothing, depending on my mood.

## Contributing to lre
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 mharris717. See LICENSE.txt for
further details.


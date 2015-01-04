== Running development mode

    bundle install
    rackup

== Running the test suite

First, make sure you have phantomjs installed if you want to run cukes tagged as @javascript(those who are in the features/webapp directory.

Have `memcached` run on `localhost:11211` then run:

    bundle exec rake

== Roadmap(stuff you can do)

* Add search icon next to search input
* Add some formatting to forms
* Do the notification system correctly using angular.js
* Develop frontend & artwork (almost done)

== Making a pull request?
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

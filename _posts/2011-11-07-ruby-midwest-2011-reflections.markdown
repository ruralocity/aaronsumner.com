---

date: 2011-11-07
layout: page
title: "Reflections on Ruby Midwest 2011"
excerpt: "Things I learned and/or thought about in Kansas City last week."
tags: [ "Ruby", "Programming" ]

---

-   Ruby’s <code>enumerable</code> methods are incredibly useful; learn
    them all and use them or else you’re probably duplicating logic.
    (Plus lots of other stuff I still haven’t thoroughly processed from
    [Ruby
    Safari](http://olabini.com/presentations/RubySafari-RubyMidwest2011.pdf)
    by Ola Bini)
-   Use a personal assets gem to add frequently-used Javascript
    libraries, CSS, etc. to your asset pipeline in Rails 3.1. I’m going
    to try this clever approach. I’ve used an assets server in the
    past&mdash;good when you’ve got applications using a variety of
    languages and frameworks, but can be difficult to maintain. (From
    [Rails Is the New Rails](http://mbleigh.com/rails-is-the-new-rails/)
    by Michael Bleigh)
-   <code>find_each</code> and <code>find_in_batches</code> can speed
    up large queries; use them. (Note to self: Stop forgetting about
    them.) (From Ethan Gunderson’s ActiveRecord Anti-Patterns for Fun
    and Profit; reinforced by James Edward Gray II in [Life on the
    Edge](http://speakerdeck.com/u/jeg2/p/life-on-the-edge))
-   [query_reviewer](https://github.com/nesquena/query_reviewer) and
    [consistency_fail](https://github.com/trptcolin/consistency_fail)
    are useful gems for finding database issues in Rails code.
    (Gunderson)
-   Observation: It’s sometimes hard to feel like you’re a part of the
    Ruby community when you’re not working for a startup.
-   GitHub is probably all the project management I need. (From [How
    GitHub Uses GitHub to Build
    GitHub](http://zachholman.com/talk/how-github-uses-github-to-build-github)
    by Zach Holman)
-   Slides for tech talks don’t have to suck. (Holman)
-   Observation: I probably need to just get over my dislike of
    Cucumber.
-   I’m sorry, but getting berated about how I’m doing it wrong (and so
    is everyone else) for an hour was not a pleasant way to close out a
    long first day. Or maybe I’m just not a computer scientist. I did,
    however, appreciate the bit about a good architecture allowing major
    decisions to be deferred and maximizing the number of decisions not
    made. (Bob Martin’s keynote)
-   Observation: Lawrence has enough people using Ruby for us to start
    doing something locally every now and then, or at least do a better
    job coordinating rides to KC Ruby.
-   The Ruby Debugger is actually very useful, especially when run
    within specs! This would have saved me an hour or two last week.
    (From Jim Weirich’s Mastering the Ruby Debugger)
-   Observation: If you’re a Ruby developer and you’re not writing code
    from tests/specs, you really are in the minority.
-   Don’t treat scripts like throwaways; be kind to “future you” and
    make them first class applications with real UIs; good design,
    documentation, and distribution systems; and careful planning. (From
    [Use Ruby to Start Making Awesome Command Line
    Applications](http://awesome-cli-ruby.heroku.com/#1) by Dave
    Copeland; I’m really looking forward to this book)
-   Apply a consistent structure to your code. In order: Gather input,
    Perform work, Deliver results, Handle failure. This is not about
    being concise; it’s about being expressive&mdash;so it may wind up
    being longer. (Along with other stuff to think about from Avdi
    Grimm’s [Confident
    Code](http://avdi.org/talks/confident-code-railsconf-2011/))
-   <code>nil</code> is best avoided as a return value; avoid it as much
    as possible and return <code>Array(Enumerable)</code> instead.
    ([James Edward Gray
    II](http://speakerdeck.com/u/jeg2/p/life-on-the-edge); covered
    previously by Avdi Grimm)
-   Make sure your usual tests are close to the edge cases, and make
    edge cases impossible when you can. Don’t add extra edge tests if
    they’re not necessary. (Gray)
-   Andy Hunt’s keynote provided excellent closure to the event. It was
    good to hear him remind the room that Agile isn’t a slogan or a set
    of tools; it’s an ever-shifting, ever-changing, ever-responding
    approach. Generating continuous, meaningful feedback, evaluating it
    appropriately, and making the appropriate changes are what matter in
    the end.
-   Observation: It kind of seems like Rails is catching flak for
    becoming bloated. Wasn’t adding features and flexibility the big
    drive behind Rails 3, though? Regardless, if you’re a Rails
    developer, remember there are a lot of other things you could be
    doing with Ruby&mdash;web apps or otherwise.
-   Observation: For all the talk about safaris, it looked like pretty
    much everybody was using Chrome.


---

date: 2010-02-07
layout: page
title: "Rails testing in the real world"
tags: [ "Rails", "Web Development" ]

---

I’ve been in the web development racket since the mid-90s, but I’m
really not a programmer (even if I’ve held jobs that state otherwise). I
know *how* to at least do many things expected of a programmer, but it’s
not something I do at my job for more than, say, eight hours a week.
There are just too many things to do. That said, I *have* been doing
this for more than 15 years now, and I know a thing or two about how
things should work. It took time and experience and learning the hard
way at times, but these days I’m solidly convinced that if you’re not
using~~~~and *embracing*~~~~a framework of *some* kind you’re making
life more difficult than it has to be. And part of that embracing is
writing tests for your code to pass.

Everyone knows test-driven development (TDD) is the way to go, right?
Like all the other big player web frameworks, Rails has built-in support
for tests (Test::Unit) and a bevy of third-party test frameworks (Rspec,
Shoulda, Cucumber). TDD evangelists preach TDD as *the* way to go about
your business. I’ve read their statements and worked through the
tutorials, but whenever a new project came along, I’d start the same way
as always: Draft a data model, write some code, check it out in my
browser, and hope I didn’t miss anything.

I attribute this behavior to two things. First, I’d become set in my
ways as a slapdash, spaghetti code developer; and second, the demos and
tutorials intended to get you hooked on Rails~~~~be it the [15-minute
blog in Rails](http://rubyonrails.org/screencasts) demonstration that
got everyone excited in the first place or the book *[Agile Web
Development in
Rails](http://pragprog.com/titles/rails2/agile-web-development-with-rails_)
that was the first hands-on exposure to Rails for many of us~~~~testing
is either not done or is an add-on. Even Ryan Bates’ essential
[Railscasts](http://railscasts.com) series omits testing unless the
week’s topic is about a testing framework. I know why this is
so~~~~people don’t come to Railscasts to see Ryan write a bunch of tests
and make them pass; they come to see him implement a useful controller
feature or neat drag-and-drop interface. At the end of the day I got it,
but I didn’t*get\_ it, and so I didn’t *do* it. A whole book on the
subject of testing in Ruby, *“The RSpec
Book”,[http://pragprog.com/titles/achbd/the-rspec-book\_](http://pragprog.com/titles/achbd/the-rspec-book_),
couldn’t convince me, but I knew I needed convincing, so I kept trying
to find testing enlightenment.
\
Everything clicked for me after watching a few episodes of
[BDDCasts](http://bddcasts.com/), an ongoing screencast series that
gives you the opportunity to look over the shoulders of two seasoned,
test-driven Rails developers as they put together an application,
feature by feature. It’s not always pretty, but watching and listening
to the two talk through implementation decisions, leading off with
defining features through tests, helped me realize that the only way I
was going to really put tests to use on my own was to make the process
work*for\_ me~~~~not the other way around.

Here’s the development process I’ve come up with for myself to test
Rails code. Your mileage may vary.

1.  **Create a new Rails app and prepare it for the testing frameworks
    of your choice.** I’m currently using
    [Cucumber](http://cukes.info/),
    [Webrat](http://github.com/brynary/webrat), and
    [Pickle](http://github.com/ianwhite/pickle) for behavior tests,
    [RSpec](http://rspec.info/) to spec out and test the particulars of
    my models, and [Factory
    Girl](http://github.com/thoughtbot/factory_girl) to create my test
    data. At this time I don’t do a whole lot of controller testing, as
    I’m still figuring how to work that into my system, but at this
    point Cucumber has kept things afloat on that end for me.
2.  **Draft a data model.** I know this is probably against many TDDers’
    rules, but I need a general lay of the land before I get started. I
    do this on paper, with lines between tables to mark relationships.
3.  **Begin writing feature files using Cucumber.** I’ve been fuzzy on
    the preferred way of organizing behavior tests are~~~~should I use a
    few files with several features each, or many files with a handful
    of features per? I’ve gone the latter route. This lets me focus on
    features in more manageable bundles, and also makes it easier for me
    to take advantage of Cucumber’s useful <code>Background</code>
    feature. I don’t know if this is the *right* way to do it, but it’s
    the way that works for me.\
    \# **Crank out the required scaffolds.** Scaffolds? Aren’t those
    just for beginners? Maybe they are, but scaffolds do a *lot* of
    grunt work I’d prefer not to do. This might be my biggest
    veering-off point from what the demos and tutorials say you’re
    *supposed* to do. Instead of writing a test and then writing the
    code to make it pass, I write a test, create a scaffold using Bates’
    awesome [Nifty Generators](http://github.com/ryanb/nifty-generators)
    gem, then peel back what I don’t need. At this point I create my
    factories, write the code need to write to make my Cucumber tests
    pass, remove the rest, and do a round of refactoring.\
    \# **Clean up my models.** I use RSpec to verify that things like
    validations and <code>after\_create</code> calls are working as
    intended. I could do this in Cucumber, but these tests make more
    sense to me within RSpec. Another important thing to note here is
    that I don’t test things that I can safely assume have been tested
    thoroughly by the Rails framework itself, such as
    ActiveRecord-specific calls, and ideally if a plugin or gem is
    well-tested I trust those tests as well. Another round of
    refactoring follows, as needed.\
    \# **Move on to the next bundle of features**~~~~it’s back to
    Cucumber, writing another set of related features, and making them
    pass.

That’s my process, in a nutshell. I don’t obsess over coverage
statistics, but I still think by and large this process is covering the
parts of my Rails code that need to be covered pretty well. Since I
still use scaffolding, I don’t think testing adds a whole lot of time to
my development cycle, and if anything I see it saving time down the road
when tracking down errors that might not be found with old school
browser-side testing. I know I’ve got some things to improve upon,
particularly in user interface testing, but I feel like I can continue
down that road once I’m sure that my applications’ underpinnings are
sound.

### Retrofitting old applications

Over the last few months I’ve been revisiting projects I still support
but didn’t necessarily do a great job of testing, putting my system to
use to check my work by writing tests and seeing if they actually pass
the way I expect they should. I work backwards in these cases, testing
my models with RSpec and then writing behavior tests. Interestingly, I
do find things that I’ve missed from time to time that I’m surprised
haven’t already come back to bite me in implementation, but it’s better
that they’re found here than by an end user.

Retrofitting your existing applications is also a good way to learn the
syntaxes and nuances of your chosen testing frameworks, since you should
have a pretty good idea of how they’re currently working~~~~that way
when a test doesn’t pass, and you know it’s supposed to, you can focus
more of your attention on the test you’ve written as opposed to the code
you’ve written that should make it pass.
\
Try to dedicate a portion of your day or week to revisiting old projects
and bolstering them through tests. It’s a good learning exercise and can
save you a lot of time and embarrassment down the road.
\
h3. How do you test?
\
Like I said, I think the best way to embrace testing is to find a method
that works best for *you*~~~~so what’s yours? Are you by the book? If
not, what parts of the workflow have you customized? If you’re not
testing, what’s stopping you?

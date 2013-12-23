---
 
wordpress_id: 290
date: 2009-04-20
layout: page
title: "Ruby on Rails: What a difference three years make."
wordpress_url: http://www.aaronsumner.com/?p=290
tags: [ Rails ]

---

![B3236CB4-276B-43C7-922D-12CBE428CE5A.jpg](http://www.aaronsumner.com/uploads/2009/03/b3236cb4-276b-43c7-922d-12cbe428ce5a.jpg)I've
been working on a major update of a project I originally completed in
2006--same basic interface, same basic functionality; new version of
Rails. Specifically, I'm going from version 1.2.6 to 2.2.2.

So what's happened since then that's so useful? Two immediate things
come to mind:

-   **REST**: It's amazing how many things just *happen* like magic when
    you're developing Rails apps and you've accepted a REST-based
    architecture into your workflow, especially when using gems I've
    [mentioned in the
    past](http://www.aaronsumner.com/2009/03/5-useful-ruby-gems-for-ruby-on-rails/)
    like restful\_acl and nifty\_generators. Before Rails, work I did in
    PHP that took a day now took a couple of hours in 2006. Now it takes
    about 30 minutes. If you still haven't quite figured out why REST is
    a big deal, spend a little time [viewing a Railscast or
    two](http://railscasts.com/episodes?search=rest) or [reviewing this
    (slightly dated) PDF
    tutorial](http://www.google.com/url?sa=t&source=web&ct=res&cd=10&url=http%3A%2F%2Fwww.b-simple.de%2Fdownload%2Frestful_rails_en.pdf&ei=blHtSbGeMtaJtgfaovnEDw&usg=AFQjCNFXDbgWOVKcjZzUwxIG9ZLTynyCxA&sig2=YAQN5t4Tew7tfgJMvT8CzQ),
    which is what really hammered the whole thing home for me.
    Seriously, if you're using Rails (or any framework) and you're not
    RESTful, *you're doing it wrong.*
-   **named\_scope**: Perhaps the greatest thing to come to ActiveRecord
    since, well, *ever*. named\_scope was introduced in Rails 2.1 and
    [covered nicely in Railscast no.
    108](http://railscasts.com/episodes/108-named-scope). What makes
    named\_scope extra-awesome is how you can string them together to
    create rather complex SQL queries without resorting to any sort of
    custom code. named\_scope has saved me with plugins/gems that don't
    have key features I need (like being able to scope a user's timeline
    events with
    [timeline\_fu](http://github.com/giraffesoft/timeline_fu/tree/master))
    a few times, not to mention making it easier to DRY up quite a bit
    of ActiveRecord/database-related custom code.

And keep in mind: I'm still developing productional apps for Rails
2.2.2; I've barely even scratched what 2.3 does (or what Rails 3 will
do).

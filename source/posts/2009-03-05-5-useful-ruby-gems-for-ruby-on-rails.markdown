---


date: 2009-03-05
layout: page
title: 5 useful Ruby gems for Ruby on Rails

tags: [ Rails ]

---

![B3236CB4-276B-43C7-922D-12CBE428CE5A.jpg](/uploads/2009/03/b3236cb4-276b-43c7-922d-12cbe428ce5a.jpg){: .floater }

To follow up on my list of [useful plugins for--by-on-rails-plugins.html),
I'd like to share a few gems that make my Rails development work much
easier.

1.  **[nifty-generators](http://github.com/ryanb/nifty-generators/):**
    The first thing I do in a project (after version control and the
    database) is run nifty-generators' useful duo of nifty\_layouts,
    which yields a clean, ready-to-roll application.html.erb and
    corresponding CSS; and nifty\_config, a simple way to control
    constants in the application. Then I use nifty\_scaffold to create
    all my models/views/controllers. This gem was created by Ryan Bates
    of [Railscasts](http://railscasts.com/) fame; I can't rave about it
    enough.
2.  **[mdarby-restful\_acl](http://github.com/mdarby/restful_acl/):** My
    method of choice for adding access control layers (ACL) to my
    applications. I generally try to avoid roles-based mechanisms, in
    favor of a simpler "admins, users, and everyone else" approach.
    restful\_acl, formerly a plugin and now a gem, handles this
    wonderfully. Version 2.0.2 is even easier to use. It works great
    with the restful-authentication plugin I mentioned the other day.
3.  **[will\_paginate](http://github.com/mislav/will_paginate/):** The
    best way to paginate returned results in your \#index views so they
    span over multiple pages; the defacto standard after pagination
    support was removed from Rails' core.
4.  **[chronic](http://github.com/mojombo/chronic/):** A natural
    language parser for Ruby. I've only used this one a few times but it
    will eventually make its way into other applications as I work my
    way through keeping them updated and current.
5.  **[starling](http://railscasts.com/episodes/128-starling-and-workling):**
    The simplest way I've found to run background processes in your
    apps, such as converting media files. I admit that I have a
    love-hate relationship with Starling, particularly running in tandem
    with the Workling plugin in production on an Ubuntu server, but once
    everything is set up properly it's just magic.

Those are my current five--I use others here and there to help with the
likes of Atom parsing, CSV generation, and so on, but the five above
make their way into my apps more than any other.

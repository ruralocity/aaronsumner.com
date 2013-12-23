---
 

date: 2009-03-03
layout: page
title: 5 useful Ruby on Rails plugins

tags: [ Rails ]

---

![B3236CB4-276B-43C7-922D-12CBE428CE5A.jpg](/uploads/2009/03/b3236cb4-276b-43c7-922d-12cbe428ce5a.jpg)I've
been using [Ruby on Rails](http://www.rubyonrails.org/) since 2005. I
honestly don't know how I survived the first decade-plus of the web
developer part of my career without it. Rails handles at least 80% of
the humdrum routine of application development and, by enforcing
constraints, makes you a better coder (in my opinion--honestly, the core
Rails contributors are better programmers than I'll ever be, so I try to
emulate their styles and decisions rather than question them).

Over my next few posts I'm going to share some useful resources for web
developers either new to Rails or folks who've worked with other
platforms who'd like to know more. First, I'm going to share a few
plugins I've noticed being installed in most of my Rails apps. Remember:
There's no shame in using plugins!

1.  **[restful-authentication](http://github.com/technoweenie/restful-authentication/tree/master):**
    This has become the default user account creation utility for most
    of the Rails community. After installation, you can have a
    fully-functional username/password system working in your
    application within two minutes. I usually extend it a bit to make it
    possible for users to edit their account settings (in tandem with
    the restful\_acl plugin I'll talk about in my next Rails post).
    restful-authentication has been around for awhile (previously known
    as acts\_as\_authenticated) and is in active development.
2.  **[forgot\_password](http://github.com/greenisus/forgot_password/tree/master):**
    Pretty much every restful-authentication tutorial out there includes
    a section on how to help your users reset forgotten passwords. This
    plugin takes care of it for you, generating the required controller,
    views, model, and migration to handle the magic. forgot\_password
    should work with any authentication system, in theory, but I've only
    tried it with restful-authentication.
3.  **[paperclip](http://github.com/thoughtbot/paperclip/tree/master):**
    Inevitably, you'll want to allow users to upload files to your
    application. Paperclip makes this incredibly easy. If you've got
    ImageMagick installed, you can use paperclip to automatically resize
    images. I usually veer from the default settings and store files
    outside of the public folder, in such a way that I can protect the
    files with restful-authentication and restful\_acl--perhaps I'll
    write a tutorial on how to do this sometime.
4.  **[has\_many\_polymorphs](http://github.com/fauna/has_many_polymorphs/tree/master):**
    Polymorphs are a semi-advanced topic in Rails development, but
    has\_many\_polymorphs simplifies the process. If you need to use
    tags in your app, this plugin could be invaluable. I usually tweak
    some settings, and I've come across a few bits of weirdness, but for
    my apps this plugin has worked pretty well.
5.  ~~**[google\_analytics](http://github.com/rubaidh/google_analytics/tree/master):**
    If you're using Google Analytics to track site usage, install this
    plugin.~~ I forgot, this is a handy gem now.

If you found this at all useful, be sure to tell others via your
favorite social applications.

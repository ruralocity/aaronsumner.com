---

date: 2011-04-15
layout: page
title: "Recent web work: Kansas Project Success"
tags: [ "Portfolio,Web Development" ]

---

![cover](/images/content/project-success.png){: .floater }

### What it is

[Project Success](http://kansasprojectsuccess.org/) is a
new joint initiative between the [Beach Center on
Disability](http://beachcenter.org/) and the [Center for Research on
Learning](http://kucrl.org/) (both housed at the University of Kansas)
to improving school performance for kids in special education. The
website collects and promotes learning resources identified by project
staff to assist these students, their parents, teachers, and school
administrators.

### What I did

For this site, I developed the end-user interface for
browsing and searching resources, and for registering to attend live
events hosted by Project Success (though implemented, this feature is
not yet being used as of this writing). I designed the layout and chose
a basic color scheme based on a logo provided to me. A backend interface
is in place for project staff to add new resources, with a simple
approval system in place to allow staff to OK resources for sharing.
Underneath that I did the application and database work and set up a
dedicated virtual private server for the project.

### Tools I used

[Rails 3](http://rubyonrails.org/) for a web
application framework. [Devise](https://github.com/plataformatec/devise)
and [CanCan](https://github.com/ryanb/cancan) for authentication and
authorization. [RSpec 2](https://github.com/rspec/rspec) with [Factory
Girl](https://github.com/thoughtbot/factory_girl),
[Webrat](https://github.com/brynary/webrat), and
[Autotest](http://rubygems.org/gems/autotest) for testing.
[MetaSearch](https://github.com/ernie/meta_search) for search.
[Ancestry](https://github.com/stefankroes/ancestry) for hierarchical
browsing. [FriendlyId](https://github.com/norman/friendly_id) for pretty
URLs. [Transitions](https://github.com/qoobaa/transitions) for resource
state (pending, approved, rejected).
[Paperclip](https://github.com/thoughtbot/paperclip) for image uploads.
A little bit of [JQuery](http://jquery.com/).
[Haml](http://haml-lang.com/) and [Sass](http://sass-lang.com/) for
markup. The [1Kb CSS Grid](http://1kbgrid.com/).
[Capistrano](https://github.com/capistrano/capistrano) for deployment.

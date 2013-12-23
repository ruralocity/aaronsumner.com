---

date: 2010-01-11
layout: page
title: "How I migrated my blog to Jekyll"
tags: [ Jekyll, "Web development"]

---

As I mentioned last night, I’ve moved this blog from using WordPress on
the backend to [Jekyll](http://github.com/mojombo/jekyll/), my new
favorite way to publish on the web. Jekyll’s made web publishing fun for
me again. It’s a throwback in many ways to the ways we used to do things
back in the early days of the web~~~~lots of command line and text
editors~~~~while providing modern conveniences like an intelligent
templating system and local server for development. If you’re frustrated
with WordPress security or performance issues, or think that other
content management system offerings are more complex than they need to
be (or at least more complex than you need them to be) I recommend
giving Jekyll a shot.

I’ve been using Jekyll to publish some sites for work for a month or two
now, but those were fresh sites that didn’t have content to carry into a
new system. For this blog, I had posts and comments to move over,
ideally in a way that would preserve as much content as possible. Henrik
Nyh wrote a good [post on migrating from WordPress to
Jekyll](http://henrik.nyh.se/2009/04/jekyll) that provided much of the
detail of the migration process for me, but I learned a few things on my
own:

#### Markdown oddities after import

After importing content from the WordPress database, my posts with
images or other embedded media in them caused Jekyll to error out when
trying to generate my site. I was able to resolve these, at least in the
short term, by changing a given post’s markup to HTML. I’m not religious
about my markup/markdown methods so I doubt I’ll change this unless
necessary.

#### Permalinks

This one wasn’t a big deal—the default permalink structure for Jekyll is
different than how I had my permalinks set up in WordPress. This
conflicted with the comments I’d transferred over to
[Disqus](http://disqus.com/) (and, theoretically, any standings I had on
the search engines). Easy fix: Make a note of your WordPress permalink
settings, and edit the permalink value in your Jekyll **\_config.yml**
file accordingly. In my case this was just a matter of setting it to

    /:year/:month/:title

I’m not sure what you need to do if you’re not using search-friendly
URLs in your blog, though.

### To do

I still have things to sort out as I have the time:

-   Implement site search. Is Google’s service work 100 bucks a year for
    such a small traffic site? I don’t know; in the meantime you can
    check out [my archives](http://www.aaronsumner.com/archives.html).
-   Add some sort of comments form, I guess, though I’d rather people
    leave comments or contact me on Twitter. It’s easier.
-   Add code to [GitHub](http://github.com/). It’ll happen eventually.

Anything else you think I should do?

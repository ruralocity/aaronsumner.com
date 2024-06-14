---

date: 2010-12-05
layout: page
title: "Make iPad e-books with Baker and Jekyll"
tags: [ "iPad", "HTML" ]

---

A few weeks ago I started looking into
[Baker](http://bakerframework.com/), a new open source, HTML5-based
framework for creating e-books. Baker takes HTML files and compiles them
into native iPad applications, ready for you to sell through the iTunes
App Store. (We’re talking apps here, not ePub-formatted books you’d read
in iBooks) If you know HTML, and want to get started with
self-publishing for the iPad, Baker is worth looking into. You’ll need a
Mac with XCode and the iOS installed&mdash;you can [download these tools
for free from Apple](http://developer.apple.com/), but to make your
e-book available to customers in the App Store you’ll need to pony up
$99 to [join the iOS Developer Program](http://developer.apple.com/).

Since you’ll be using HTML and CSS to format your content, putting
together an e-book with Baker isn’t much more complex than making a
static website (that is, one without something dynamic going on
server-side). So, given that, why not make things even simpler by using
a static site generator? I experimented with this using
[Jekyll](https://github.com/mojombo/jekyll), the same static site
generator I use to manage this blog and [Everyday
Rails](http://everydayrails.com/).

The nice thing about this approach is you can let Jekyll handle things
like headers and footers, so you can concentrate on your book’s content.
You can also use an alternate markup language like Textile or Markdown
to make it easier to put content together, as Jekyll converts these
formats into HTML for you.

In theory, you might be able to use a commercial HTML editor like
Dreamweaver to accomplish this, but before investing too much money give
Jekyll a try.

---
title: An MVP for two
date: 2015-06-07 17:39 UTC
tags:
---

<a href="https://www.flickr.com/photos/fixedgear/2289746471" title="Colson Tandem by Pete, on Flickr"><img src="https://c3.staticflickr.com/3/2405/2289746471_70fa5e363d_o.jpg" width="650" height="416" alt="Colson Tandem"></a>

<div class="photo-credit">
  <em>Photo Credit: <a href="https://www.flickr.com/photos/74201745@N00/2289746471/">fixedgear</a> via <a href="http://compfight.com">Compfight</a> <a href="https://creativecommons.org/licenses/by-nc-sa/2.0/">cc</a></em>
</div>

## Current status

Working on a super-secret, stealth-mode startup.

Not really. Sort of, but not really. I've been working on a little
application/service that I needed in my household. Its target audience consists
of two people: My wife and me. I shipped just ahead of a June 1 deadline, and
have been using the app multiple times a day this past week.

If it shows promise, I may look into expanding that customer base--but for now,
so far, it's doing what it needs to do to start getting feedback on the general
idea. A true Minimum Viable Product, in that sense.

## What I'm using

- **[Ruby on Rails](http://rubyonrails.org)**: I suspect there are better
  frameworks and languages for this project. I was intrigued by
  [Meteor](https://www.meteor.com), in part because of its built-in support for
  Phonegap. (I also looked into the up-and-coming
  [Volt](http://voltframework.com/) framework, but ran into just enough
  cognitive dissonance that it was going to slow down my tight shipping
  schedule.)

  And I don't need a downloadable app yet anyway; mobile web is just fine. By
  accepting that, and using a framework I know well, I was able to knock out the
  first version in a couple of hours, and make a couple of changes based on
  feedback within another.

- **[Bootstrap 3](http://getbootstrap.com/)**: But, but, but! Every Bootstrap
  application looks the same! CSS frameworks are evil!

  I don't care. I needed a decent-looking web UI, and Bootstrap still looks
  better and functions than Zurb Foundation and Materialize. And I'd rather
  focus on the general idea versus well-structured Sass right now, so Bourbon
  and friends are out.

- **[Heroku](http://getbootstrap.com/)**: Free hosting, simple deployment, and
  simple SSL support in about 15 minutes. I'm using a *herokuapp.com* domain, so
  SSL is free, and won't have to worry about bumping up dynos or database
  storage for some time based on my current customer base.

  Waiting for a web dyno to spin up can be a drag sometimes, but it's not a
  deal-breaker. Much nicer than the Capistrano-induced hell I've been dealing
  with the past couple of weeks on a paying gig--and if the lag *does* become an
  issue, [Heroku's new Hobby
  tier](https://blog.heroku.com/archives/2015/5/7/new-dyno-types-public-beta)
  should keep me well-provisioned for awhile.

- **Public domain clipart**: I needed an app icon. I found one in ten minutes. I
  like it so much that, if and when I expand it, I'll probably keep the same
  icon.

## Costs so far

- **Time:** About six hours tracked; about two hours sketching out ideas before
  I added it as a project in [Harvest](http://try.hrv.st/6-85571) (referral
  link).

- **Money:** $0.00. Ain't software grand?

- **Test coverage:** This one admittedly hurts a little. I didn't TDD this
  little app, but it's still small enough that I can know pretty quickly when I
  break things. I do plan to add some smoke test coverage, though, as some of
  the first round of functionality gets validated and I move forward on part
  two.

## The takeaway

Sometimes I get annoyed by the *Learn to Code* movement. It's not just about
acquiring skills necessary to compete in an evolving job market (though that's
important). It's also about *knowing what's possible* with computers and
programming, and knowing that *when the offerings in the App Store aren't what
you need, you have other options*--even if it means opening up an editor or IDE
and building it yourself.

I also wish more professional developers and self-labeled entrepreneurs would
state out loud that, sometimes, you need to make a mess before you know what
you really need to build. And that's OK. If I spent all my time scheming the
perfect architecture and mocking the most delightful UX and building landing
pages, I wouldn't ship for months.

I know it's an apples and oranges comparison, and that not every product idea
can start out at a scale of two. But maybe yours can. I honestly don't know
right now if this product will ever be a public offering. The first step is to
make something I know *two people* find useful. I'll scale up from there, if it
looks promising, and revisit my decisions as needed.

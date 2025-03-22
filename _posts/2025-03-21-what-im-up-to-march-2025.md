---
layout: page
title: "What I'm up to (March 2025)"
---

The world is a mess, and the country in which I live is extra a mess, and I'm not trying to ignore that by any means. It fucking sucks.

But I _am_ riding a small burst of manic productive energy, so stepping back for a sec to think about what I'm working on and what I've accomplished in the past couple of weeks.

In no particular order:


## Porting Everyday Rails to Ghost

I've published [Everyday Rails](https://everydayrails.com/) using Jekyll since the day I started it, moving hosts over time. It's been on Netlify for awhile now. I actually like this combo. It's just Markdown, it's fast, it's stable.

But I hate that I have to deal with Mailchimp every time I want to send an email out to people to let them know about new blog posts or book updates. I've never found joy in Mailchimp's user interface, and I'm pushing up against my grandfathered-in subscriber cap, anyway.

[Ghost](https://ghost.org) has been on my radar for awhile. I've set up a self-hosted version to experiment with, and am figuring it out. It's certainly more involved than Jekyll, but so much more powerful--it'll handle my newsletter much better as it scales. And I can use a professionally-designed theme instead of hacking together my own front-end code. I don't have time for hacking together my own front-end code these days!

Not making any promises, but at minimum I'd like this change to help me post more frequently, and actually let you know when I do. I won't lie--I've thought about what subscriber-only content might look like, and I'm not ruling that out. But I'm also not worrying about it too much.

There's no set timeline on this, but maybe by end of summer I'll have things moved over.


## Hosting Sound Refound with Dokku

My pet project [Sound Refound](https://soundrefound.com/) has been on Digital Ocean's platform-as-a-service for a few years. It's been fine, but it's kind of expensive for something I keep around to amuse myself. I considered moving to a VM and deploying via [Kamal](https://kamal-deploy.org), but the app itself is a little dusty, and I still kind of find Kamal confusing/annoying in some aspects. And I don't like how DHH is its primary spokesperson.

So I'm rocking it kind of old school with [Dokku](https://dokku.com), the original open-source Heroku alternative! It feels like a great alternative for projects that need to get out of an expensive PaaS, or away from Apache+Capistrano-style hosting on the server itself, and toward a container-based system. I may revisit Kamal once I've got Sound Refound up to Rails 8, but for now, Dokku is winning it for me.

I hope to write more about this in Everyday Rails later this year.

## Updating my RSpec book

I am finally, finally in the home stretch of the updates to [Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec) that I started last year. It's been a lot more work than I had anticipated. Good work, though, and much more than a code-only update to the last version from 2017. I mean, I've written a lot of code, a lot of tests, and mentored a lot of people on testing since then. My thinking about what matters has evolved so much, and if you've downloaded any updates to the book recently, you're getting my latest thinking around test-driven development.

I'm wrapping up the all-new chapter on mocking now, then just a couple more chapters before calling this edition done. Then an update to whatever the latest Rails 8.x version is at that point, then I'm going to take a breather.

## Day job

July 2025 will mark my 12th year with [O'Reilly Media](https://www.oreilly.com/), and I can't think of a more hectic, but fun, stretch of work in that time than what we're working on these days. It's humbling that, thirty years after starting my career with a cubicle full of O'Reilly print books, I now manage the team responsible for making sure those books keep flowing out into the world. I'm not sure how much I'll be able to share about this, but my team is doing some really neat things right now that you'd probably not even notice otherwise. And I mean that in the best way possible--when my team does its job, then things just work.

And I wouldn't have it any other way.

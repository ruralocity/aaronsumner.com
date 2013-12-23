---
date: 2012-12-14
layout: page
title: "Sound Refound: November 2012's Project a Month Project"
tags: [ "Project a Month Project" ]
---

As mentioned separately, I have initiated a [Project a Month Project](/posts/2012/12/project-a-month-project.html) to help kickstart myself into getting more ideas and side projects out into the wild. The inaugural project was a total rebuild of **[Sound Refound](http://soundrefound.com/)**, my online gallery of concert flyers I collected from the streets and venue walls of Lawrence and Seattle back when I used to go to a lot of shows.

The rest of this post is mostly technical detail of the project. Be forewarned.

I'd been meaning to do a rewrite of the application for awhile now. The original work happened awhile back--maybe three or four years ago? I wrote the original in Rails 2.3 and hosted it on Heroku and it quietly did its thing all that time. However, the behind-the-scenes infrastructure was kind of messy. I was using Heroku for parts of it, a Dreamhost-hosted MySQL database for part (this was before Heroku offered its own SQL support, as memory serves), and Amazon S3 for storing and serving the actual images. And when Heroku announced they were discontinuing the Aspen stack, I determined it to be a sign to get the ball rolling on something new.

So here we are:

- The new application is written in Rails 3.2.9 and ready to bump to 4.0 when the time comes.
- I'm now using a [Linode-hosted](http://www.linode.com/?r=d3a98e56fb377eb9f9b52455f069b0b6029908b9) VPS to serve the application, data, and images instead of spreading things around--honestly, I don't need to worry about scale for this and am not a fan of premature optimization.
- Front-end web developers will no doubt recognize a barely-tweaked Bootstrap interface. I don't normally use Devise for authentication, but did in this case since I could install it and be done.
- I used my usual testing stack of RSpec, Capybara, and Factory Girl.

Want to see the source? [Head on over to the GitHub repository](https://github.com/ruralocity/soundrefound) and poke around.

There are a few things I'd still like to do when time allows:

- Do some form of pagination so you're not loading every flyer, every time.
- Add some SEO-friendly metadata.
- Maybe figure out a clever way to hook this into my Amazon Associates account to refer business and get a small cut.

Speaking of getting a cut, and **speaking of Linode, if you're in the market for a Linux virtual server I strongly, strongly recommend them.** I use them for both day job and free time activities and have been thoroughly pleased. [Use my referral link](http://www.linode.com/?r=d3a98e56fb377eb9f9b52455f069b0b6029908b9) and I'll get a small kick-back (and use it to buy you a beer the next time I see you).
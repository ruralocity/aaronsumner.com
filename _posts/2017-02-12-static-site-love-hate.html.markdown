---
title: My love-hate relationship with static site generators
date: 2017-02-12 13:06 UTC
tags:
---

I've been on the road for the past few days, and it's messed up my regular blogging routine that I'd worked to re-establish. It's hard enough to find time to write when you spend most of a weekend driving. Depending on the authoring and publishing tools you choose, it can become downright impossible without significant additional work.

I use static site generators for this site and my technical blog, Everyday Rails. Plenty has been written about the benefits of going the static site route. They're inherently faster and more secure than something that requires dynamic (and hackable) scripts to run on a server. That also means they're portable--no special programming languages required to spit out static files over HTTP. They're cheap--I run my static sites all on a single, inexpensive virtual server on [Linode](https://www.linode.com/?r=d3a98e56fb377eb9f9b52455f069b0b6029908b9), but many people use GitHub's free static site hosting for blogs and project sites. And if you're a software developer, it can be nice to use the same tools you use daily to write code to write about code (and other things, too, maybe).

But there are drawbacks. And when they hit, they hit hard.

If you're like me, the first annoyance you'll run into is handling in-site search. There's a simple enough solution; wire up a [free custom search with Google](https://cse.google.com/cse/). It's extra work, though. So far, I've chosen to not do anything about this issue, though I probably should.

My second pain point is with the general tooling. While it is indeed nice to use my preferred editor and Markdown to write, instead of a text field on a WYSIWYG web form, I have to have the static site tools installed where I want to write. I'm not one to open my laptop while I eat a quick lunch at some fast food place in the middle of Missouri, but I am apt to type a few ideas on my phone. Sure, I can write from anywhere, but I still need to be at my computer to push.

My big hassle is scheduling out blog posts. I've come to realize that, in my most productive days as a blogger, I would concentrate my writing time, get my posts ready for a week at a time, and then let my blogging engine do the rest. This can be done with static site generators, but it's not trivial. There are a lot of moving parts. If I haven't found the time to set up a simple Google custom search, I'm probably not going to find the time to build this out.

Someday, I may set all of this up one day for my static sites. Meanwhile, for a new writing project, I went the hosted WordPress route. This is the first I've used WordPress is more than four years. It's got its annoyances. It's not free (though it's still pretty cheap), and I miss out on some nitpicky styling control. But I can write for it in batches, and have posts go live while I'm still asleep (or driving past [Aullville, Missouri](https://en.wikipedia.org/wiki/Aullville,_Missouri), where the highway exit signs note there are no services).

My point isn't that you should always pick WordPress (or Blogger, or whatever) over a static site generator. Just know that some extra work will probably be required to do things you've taken for granted with publishing software in the past.

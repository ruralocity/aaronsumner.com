---
date: 2012-12-31
layout: page
title: "Docent: December 2012's Project a Month Project"
---

For December's [Project a Month Project](/2012/12/project-a-month-project/) I decided to tackle an idea I've been meaning to work on for a few years now. Back in 2008 I built a contextual help system into a Rails 2-point-something application. The idea was a simple one--I created an external knowledge base of tutorials for the application. My application assigned a URL for a specific tutorial to a Rails controller-action combination. Finally, the Help link present in the application's layout file intelligently linked to a context-specific tutorial based on where the user was within the application. It worked well, and since then I've had other uses for such a technique. I just never got around to doing anything with it until now.

Rather than just embedding such an approach in future applications, I can now use [Docent](https://github.com/ruralocity/docent). To build Docent I took advantage of mountable engines in Rails, meaning that it technically runs as a small, separate application within a main Rails app. I hadn't yet done much with mountable engines, so this was a good opportunity to learn more about them.

As it turns out, mountable engines are easy to get started with. I'm going to write some more technical information in an upcoming [Everyday Rails](http://everydayrails.com) post. I also took the opportunity to publish my first gem--which means [it's easy for anyone to install Docent into their own Rails 3.2 applications](http://rubygems.org/gems/docent). Not suggesting that anyone *should*--I've still got more real-world testing to do, but hopefully making it accessible will help others make improvements on the concept.

My big takeaways:

- Engines--mountable or otherwise--are an excellent way to extract functionality from medium-to-larger Rails applications and make for more manageable codebases.
- Engines are also great opportunities to contribute your work to open source.

I do have a couple of things I'd like to keep messing around with in Docent:

- I'd like to figure out how to replace the HTTP basic authentication I'm using with the host application's authentication. Still looking around for different approaches to this--the challenge is the separation inherent between the mounted and host applications.
- Big ticket: I'd someday like to be able to post directly from the likes of [ScreenSteps](http://www.bluemangolearning.com/screensteps/) into a knowledge base contained within Docent itself. I figure this involves fun stuff like XMLRPC (as ScreenSteps supports it), handling file uploads in the process.

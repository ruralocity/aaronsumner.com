---
title: Initial impressions after migrating this site to Netlify
date: 2019-03-09 05:54 UTC
tags:
---

Not sure why it took me so long to learn that [Netlify](https://www.netlify.com) is a thing, but after hearing it mentioned in a podcast last week, I decided to see what would be involved with moving a site or two over to it. Turns out, not much: As of about an hour ago, this site has been moved from an old VPS to Netlify.

## Yeah, but why?

This site, my personal site, is published via a _static site generator_ called [Middleman](https://middlemanapp.com). Static site generators have been the hip alternative to heavy content management systems for awhile. Remember the days when you'd use Dreamweaver or FrontPage to create a site, then FTP it up to your server, instead of using WordPress or Drupal or Wix or Squarespace? Static site generators are sort of like that, except they use the command line and require a little more coding and carry way more street cred. I moved this site from WordPress to Middleman in 2013. I've been using another static site generator called Jekyll for [Everyday Rails](https://everydayrails.com) since 2010.

The beauty of tools like Middleman, Jekyll, and tons of tools that have followed them, is that they just generate plain old HTML (and maybe CSS and JavaScript, if configured to do so). And plain old HTML, CSS, and JavaScript can be served up pretty much anywhere, fast--you don't need special programming languages or frameworks or content management systems installed on a server. Hell, once upon a time, you didn't even need to manage your own server to chuck some HTML up on the web.

You get a sense of control when publishing plain ol' HTML, without the trappings of a modern CMS. As long as computers can read basic text files, they'll be able to read HTML. No database required; they're just files, easily moved from one system to another. I'm maybe getting overly nostalgic now for a time when a text editor _was_ the HTML editor, and publishing meant copying files up to a server manually, so I'm going to stop. If you get it, you get it, my comrades. If you don't, then the rest of this post probably isn't for you.

Up to now, I've been using a virtual host on a virtual private server that hosted this site, along with Everyday Rails and a couple of other small pet projects. This is a fine setup, but managing a server for your small pet projects is an increasingly thankless job. You're on the hook for locking down the system, and installing regular patches to make sure it stays locked down. Tools like Puppet, Chef, and Ansible make this more automatable and repeatable, but it's still extra work and cognitive overhead. And I have other things to do with my life than manage servers for personal projects. (Yes, I get the irony of me saying this after touting the benefits of plain text and HTML over a CMS, but there's a difference between format and delivery mechanism, OK?)

If you're still reading, you probably know about [Heroku](https://www.heroku.com) as an easy-to-use service that abstracts away the details of setting up a web application. Think of Netlify as Heroku, but for static HTML, CSS, and JavaScript. Create content, commit and push to your Git repository, and it's published within minutes. No server management involved.

I've been tired of managing my own servers for awhile, and regretting my decision a few years ago to let go of a grandfathered hosting account that offered unlimited bandwidth. Netlify doesn't offer unlimited bandwidth, but my status as an influencer these days isn't such that it's going to drive up my hosting bill any time soon. (And if it does, maybe that's a good problem to have?)

I'm still new to Netlify, but here's what I've liked so far:

## Deploying with Netlify

Deployment is super-easy. Connect your site's repository to Netlify and specify a branch to watch. I just use my master branch, but yours could be whatever. `git push`, then deployment kicks off in moments. I'm using GitHub for this site; Bitbucket and GitLab are also supported.

## Mixed content detection

As part of the deploy, Netlify scans files for potential mixed content issues, and warns about them in the deploy log and via an email. I wasn't expecting this, but it's a nice extra value. I have a lot to clean up from old photos hosted at Flickr; something to tidy up in the coming weeks.

## SSL with Netlify

Serving sites over HTTPS with Netlify is totally simple if you switch your domain to use their name servers. I'd originally planned to continue using DNS as provided by my registrar, but ran into issues. They went away instantly by switching to Netlify's DNS--and since this site is the only thing I ever plan to host from aaronsumner.com, there's not much reason not to at this point.

## Forms!

One downside of static sites is you've got no means of server-side interactivity--so no back-end scripts for things like processing feedback forms. There are services that provide this, but they've always been either too pricey or too kludgey for me and a personal website. I'd been running with a `mailto` link, but now that I'm on Netlify, I've switched back to a contact form. Getting everything set up took a couple of deploys, but it's working well now. A [blog post on setting up forms](https://www.netlify.com/blog/2017/09/19/form-handling-with-the-jamstack-and-netlify/) on Netlify's site helped a lot.

Netlify has [more features](https://www.netlify.com/features/) that I don't need right now, but may someday. I'm happy with what I've seen so far, and recommend trying it out for your next (or current) static site project.

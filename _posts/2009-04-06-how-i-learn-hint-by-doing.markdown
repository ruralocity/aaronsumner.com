---

date: 2009-04-06
layout: page
title: "How I learn (hint: by doing)"

tags: [ Portfolio, Learning, Rails ]
---
Last Thursday, the first ever meeting of the Lawrence Ruby on Rails group (or whatever it'll be called) was held at Zen Zero. It was fun to hear about what other folks are doing with Rails, and it made me decide to share one of my projects with a larger audience. In my head, this project's called <em>Dash</em> but I know it can never technically be called that since <a href="http://www.fiveruns.com/">FiveRuns</a> already has a project called that, though the two don't overlap in function.

Basically, <em>my</em> Dash is yet-another-project-management-application (see also: Basecamp, My Kahuna, etc.) for the workgroup I manage at KU. I didn't need anything fancy--just a way to create projects and tasks, assign them to people to get done, and watch them get done. After a couple of weeks, Dash is working like a champ (in my opinion, anyway). I can easily see what's on the table and what gets done without having to look over two other people's shoulders. Dash serves another purpose, though--it's a live testing ground for new things I want (or need) to learn in web application development. I've found it's much more fulfilling to create something and then use it rather than have a folder on my local drive full of tutorials from books, websites, and podcasts (not to devalue them by any means--I'm just telling you what works for me).

Here are a few screen shots of Dash, running in a SSB (I use <a href="http://www.fluidapp.com/">Fluid</a>). First up is the dashboard: It provides everything I have to do in the next two weeks, links to my current projects, and an activity stream (more on that in a minute).

<p><img src="/assets/uploads/2009/04/stratepedia-dashscreensnapz002.jpg" alt="Stratepedia DashScreenSnapz002.jpg" border="0" width="534" height="374" /></p>

The navigation bar at the top is a floating div and features dropdown CSS menus (a first for me; I'm generally not a fan). Red tasks mean they're due today (or are late). Aside from getting me to try some different things with CSS, nothing new here.

<p><img src="/assets/uploads/2009/04/stratepedia-dashscreensnapz003.jpg" alt="Stratepedia DashScreenSnapz003.jpg" border="0" width="534" height="374" /></p>

Here's a little form for quickly adding new tasks; it appears and disappears via Prototype Javascript fun. On the back end, I'm using the Chronic gem so you can type in a friendly date format ("4/7/09," "Tuesday," "tomorrow," etc.) instead of being stuck with the rather inconvenient default Rails date selector.

<p><img src="/assets/uploads/2009/04/stratepedia-dashscreensnapz004.jpg" alt="Stratepedia DashScreenSnapz004.jpg" border="0" width="534" height="374" /></p>

Here's the aforementioned activity feed. This one is heavy on <em>my</em> activity in the interest of not incriminating my coworkers, though most of you know who they are. I'd cobbled together something similar by hand last fall for my master's project, and then in February stumbled across a plugin/gem called <a href="http://github.com/giraffesoft/timeline_fu/tree/master">timeline_fu</a>. After streams of micro-content (Twitter, FriendFeed, the new-look Facebook, etc.) being all the rage at SXSW last month, I wanted to give it another try. So now Dash is "social." Most actions render a timeline event, which is posted on relevant pages in the application, as well as a relevant Atom feed. I figured out a few ways to really trick out timeline_fu to do what I wanted; I'm going to try to write up a brief tutorial later this week to share what I learned.

So that's it, pretty much, so far. It's got some other stuff that's pretty old hat, like polymorphic comments for projects and tasks and a complete login system. I've got more work to do, though, like continuing to hone the user interface (with the goal of using it as a new standardized UI for my work applications), cleaning up some of my code by implementing a state machine, incorporating the <a href="http://github.com/binarylogic/authlogic/tree/master">authlogic</a> authentication system, making a mobile version (because hey, why not?), and so on.

It's my project and I'll do what I want to, right?

If you have the means, I recommend thinking of a need of <em>yours</em> and start writing an application with <em>you</em> as the client. (And if it's just for you, you can maybe even run it from localhost, so no server required.) Who knows, it might turn into something bigger, but in the meantime you've got a great sandbox to try things out, use them, and then see what sticks. Just be sure to share what you learn!

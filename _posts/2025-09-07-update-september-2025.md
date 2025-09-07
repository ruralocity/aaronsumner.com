---
layout: page
title: "What I'm up to (September 2025)"
---

![Late summer morning sky in St. Louis, MO. Pink clouds over an old brick building.](/assets/images/content/morning-sky-20250831.jpg)

Boy oh boy, [I was pretty ambitious in March](/posts/2025/03/what-im-up-to-march-2025). Fast forward to now. Summer was a wash. Here in St. Louis, it rained most of June, and started feeling like fall by mid-August. I _love_ summer. I love the heat and even some humidity. Maybe we'll get a little last gasp of the season in the next few weeks?

Anyway, I didn't get as much done as I thought I would this time-ish last spring. But let's not dwell on that. Let's talk about now. Here are a lot more words than I planned on writing.


## RSpec book updates almost done, for real!

I think I've mentioned that the updates to _[Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec/)_ that I announced more than a year ago wound up being much more of an overhaul than I expected. Like, it's pretty much a whole new book. So I've blown through all my self-defined deadlines. The good news: I am almost done. I'm working on the last chapter now, and should have it out the door soon.

The other good news--yes, I know Rails 8.1's first beta just dropped. And I know I missed 7.2 and 8.0 entirely (2024 was a busy year for Rails). But part of the overhaul was to structure the book and the sample application accompanying it to be less burdensome to keep up-to-date. Not easy, but also not as much of a drudge that I resent it. So, hopefully, that means I'll have the 8.1 edition out the door by end-of-year. From there I still hope to ship an update annually, as long as there's demand.


## Thinking about: context engineering

_**Disclaimer:** I know there are a lot of feelings about using LLMs and agents in general, and for software engineering in particular. Below is a small summation of my experience to date. I have a fuck ton of concerns, too, but am not interested in getting into a debate about this. If you don't like a tool, don't use it._

I'm still pragmatically bullish on agent-assisted software development (or, pair-coding with an AI). At work, my team maintains nearly fifty discrete software systems and associated libraries. Keeping them all in our brains has never been realistic. AI agents are changing that--but with great power, yada yada.

This year I've been using agents (first [Aider]; currently [Crush]) to build long-lost _context_ to systems that are old enough to vote, have test suites that stopped working more than a decade ago, and lack documentation. Systems that were someone's idea late on a Friday, and in production the following Monday--and that someone hasn't been with the company in more than a decade. Agents have gotten _really good_ at examining an entire system and building some starter context, from which I can glean additional context and insight through dialog with the agent, along with diagrams! Projects that even a year ago were insurmountable are now wrapped in weeks.

But here's the rub: I've felt emboldened to take bigger swings, which usually means bigger diffs for my fellow human team members and me to review. So I've been working to get better at, for lack of a better term, _mindful vibe coding_. Or if that's too woo-woo for you, then _thoughtful_. Or _Golden Rule_. And it starts with a buzz term that's picked up steam over the summer: Context engineering.

It's great to tackle larger projects, but don't get lazy. Build that context up-front. Don't start writing production-bound code until you, the human, _actually understand the problem you're trying to solve_. Ask questions. Critique the answers. Refine, refine, refine.

Then, break it up into chunks. Work on a chunk, make sure it's reasonably solid, then move on to the next. This results in a change (and corresponding request for code review) that's much more humane--and less likely to sneak bugs into production. I know "be the human in the loop" has become trite, but _be the damn human in the damn loop_ for the sake of your team and the long-term viability of your work.

Jake Nations has written my favorite article on context engineering so far, [Vibe Coding Our Way to Disaster]. It's reasonably short for the attention-inhibited, has nice diagrams, and builds from past wisdom and research on simplicity and creative thinking. It concludes with a three-phase approach to, ahem, _thoughtful_ agent-assisted programming. All in words much more eloquent than I've been able to muster so far.

I could talk a lot more about this, like how it's become important again to understand underlying principles like algorithms, design patterns, and data structures. Because when asking an LLM to help you solve a problem, words matter. I might, someday.

[Aider]:https://aider.chat
[Crush]:https://github.com/charmbracelet/crush
[Vibe Coding Our Way to Disaster]:https://www.arthropod.software/p/vibe-coding-our-way-to-disaster


## Thinking about: Making Django more Rails-like

Speaking of big swings, at my day job I've been busy building new software to modernize workflows for today's publishing needs. As much as I would've loved to do this work in Ruby, alas, I work at a Python-first shop. But I am a team player, so the new tooling is Django-based.

I like some things about Django. I like how it encourages modularized applications much more than Rails likely ever will (we have engines, but they're not the default and they're not simple). I think I like how Django builds migrations; I'm just not used to it yet. And the built-in admin is nifty and can go a long way, particularly for internal-facing software.

But Django's default behavior of glomming all your models into _models.py_, all your admins into _admin.py_, and so on do not scale when you're talking a legacy database with dozens of tables. So I wrote a simple scaffold generator that works sort of like `rails g scaffold:<model>`, but for tables in the database we're building on top of. And we use Just as our task runner, so the scaffolding tool looks something like `just add-scaffold <app-name>:<table-name>`. The underlying Django task uses `inspectdb` to build a model from the table, then creates a standalone model file, admin file, and corresponding starter test files in the app's directory, with some added logic to handle the quirks of the database's design and other conventions we want everything to follow. In most cases, this is enough to have a working admin UI to poke at. And it's been a _huge_ productivity boost.

I've also broken up settings into development, testing, and production, but that doesn't seem as different-thinking in Django land?


## Having fun with: PICO-8!

Back in June when I was feeling bitter about those annoying rainy days, I decided to learn more about video game development. Writing video games is much different than writing back-end web applications, for the uninitiated! After looking at my options, I was reminded of [PICO-8], an intentionally constrained system for writing and sharing retro-style games. (Think somewhere between the Atari 2600 and the original Nintendo Entertainment System, fellow old-timers.) PICO-8 has been around for more than a decade--so I'm late to the party, sure, but I'm glad I got here eventually.

I'm going to admit something--I haven't _enjoyed_ writing software in some time. Writing with agents for work has helped change that, but PICO-8 has been actual _fun_. I don't worry about code quality and well-structured commits. I don't do the work in a _real_ editor; I use PICO-8's built-in tooling.

It's a blast. It's bringing out the better parts of 12-year-old me, hunched over a TRS-80 trying to figure out how to make it do what I want.

I've got a few games I've been noodling with here and there, when I need a break from life and work and other things. When I get stuck or bored on one, I switch to another to tinker with. The most fully-formed is _Some People Call Him the Space Cowboy_, a shoot-em-up where you, the eponymous Space Cowboy, defends a space ranch from alien space slugs.

![Animated GIF of Space Cowboy retro-style video game, in which the player shoots at pink space slugs](/assets/images/content/space-cowboy-20250906.gif)

The PICO-8 community is super-supportive and generous with their knowledge. (It reminds me at times of the earlier days of Ruby.) [Lazy Devs Academy] is the best PICO-8 learning resource I've found. I started _Space Cowboy_ over while working through the Shmup Tutorial--my original was more feature-complete, but had flaws I didn't know how to work around. And it didn't have the explosions, splats, and shakes I now know how to make.

Because I like to amuse myself, I will be publishing my games via [Bandageman Studios], my I-owned-the-domain-name-already-so-might-as-well-do-something-with-it indie studio. I would love to have _Space Cowboy_ out in the world by end-of-year.

That's all for now. I'm going to take my dog to the park. See you next time.

[PICO-8]:https://www.lexaloffle.com/pico-8.php
[Lazy Devs Academy]:https://www.youtube.com/channel/UCdT68dsulMFouI2InvXWM5w
[Bandageman Studios]:https://bandageman.com

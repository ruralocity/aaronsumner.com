---
title: Track your learning with a personal research board
date: 2015-12-29 19:00 UTC
tags:
---

A new year is upon us, and for many that means a new slate of goals and resolutions. If you're a software developer, you may be planning to learn a new language or framework in 2016. Even if you're not, you may have designs on learning a musical instrument, craft, or other skill in the coming year.

In that spirit, I want to share an approach to personal learning I've been tinkering with for the past couple of months. It's inspired by [thoughtbot's research board](https://playbook.thoughtbot.com/#research) for experimenting with and adopting fresh ideas, and adapted to my personal use. It's still very much a work-in-progress, but if you like the idea, too, maybe you can adapt it for your own learning this coming year (and beyond). I'd love to hear your ideas; please [let me know](/pages.contact.html) if you adapt this approach to your own learning.

## The personal research board

I'm a fan of [Kanban](https://en.wikipedia.org/wiki/Kanban) for tracking projects, and David Allen's [Getting Things Done](http://amzn.to/1VlNE0t) for putting the rubber to the road and actually knocking things out. Kanban makes it easy to see how far along a project is, and where things might be bottling up or breaking down. And GTD makes you think about the details—*what's the first thing I need to do to show progress on this project?*—and breaking them down into doable chunks. That said, I don't think you need to fully understand Kanban or GTD to get started with a personal research board. In fact, this might be a good project to help you get started with either or both discipline.

[Trello](https://trello.com/asumner/recommend) is the best software I've found so far to use Kanban and GTD together. It's what thoughtbot uses for their research board, and what I've been using for my personal board. Trello's free service tier will handle everything I cover here.

You don't need to use Trello for this approach, though. A whiteboard, or index cards, or pencil and paper, or some other Kanban-type software may work just fine for you (I'm adapting this to JIRA Agile at work). The key is to **record the information in some way you can define why you're interested in something, then visually monitor your progress toward understanding it**.

Tracking research in this format consists of two steps:

1. **Defining the interest**, the questions to answer, and the intended outcomes of researching that interest
2. **Tracking progress** on researching that interest

## Defining an interest

### The topic of (potential) interest

What is it you want to learn more about? An up-and-coming programming language? The JavaScript framework *du jour?* How to can and preserve vegetables? Create a card for it, using your Kanban tool of choice, and stick it in the *Interests* column. Don't worry about prioritization or detail just yet.

In Trello, I just fill out the card's *Title* field. I also like that Trello lets me enter multiple cards/research interests quickly. Get them in the queue now; fill in the details later when and if they become priorities.

### Why is this interesting?

Before I formally start researching a topic, I make sure I can answer why I want to do so.

This is your research project's *mission statement*, more or less. *Why* are you interested in it? What do you hope to gain from spending time and energy on researching it? If you have trouble answering this question, then maybe this topic isn't a candidate for research (yet).

I use Trello's *Description* field to record this. As an example, here's what I recorded on my research card for [Codeship](https://codeship.com/), a hosted continuous integration service I'd been wanting to check out:

> I hear good things about Codeship; it has a free tier that may be sufficient for many of my projects. It's always nice to see alternative CI tools to Jenkins.

### Research tasks

Next, I'll quickly review the resources I have available to me to learn more about this topic—books, screencasts, blog posts, etc. I build a *Research* list for these resources, and add them to the card. Trello's checklist functionality makes this easy to track. I create a task for each item to review, and check things off as I go.

Checking everything off from this list isn't mandatory—in fact, for the most part, *done researching* doesn't necessarily mean that every item has been checked off. This list serves as a convenient reference, to help me remember what resources are out there.

### Questions

It's inevitable that questions will arise while researching a topic. To keep myself from wandering too far off the tracks with Google searches each time one of these questions pop into my head, I use a *Questions* checklist to record them for later research.

For example, I'm currently studying the Phoenix web application framework, but I don't know the programming language it's written in all that well (Elixir). The authors of the book I'm reading refer to tools and terms common to Elixir programmers, but that aren't immediately necessary for the depth of understanding I'm working toward at the moment. So each time I come across one of those references, I'll add an item to the Questions checklist to look into it later.

Again, Trello's checklist functionality works great for this. You can add multiple checklists to a card, to help keep things separate.

### Deliverables

The last list is perhaps the most important. *How* am I going to show to myself (and others) that I've got at least some knowledge or understanding of the subject? Another checklist—this one's for listing possible outcomes of the research. Think about it in terms of being in school—back then, a report, essay, or project might have been what you turned in to demonstrate understanding. In today's world, maybe this is a blog post, a repository on GitHub, a demonstration at your local meetup or users group, or a working application to share with friends, families, or even potential employers.

So far, I tend to be pretty loose with my deliverables. If something's getting too frustrating, I'll back out and try something different. There's no point in making something unnecessarily difficult or just plain not fun. Learning breaks down when it's not fun.

## Tracking progress

In my Kanban board, I use these columns, or swim lanes, to track where a given interest is in the learning process:

### Interests (backlog)

What do I want to learn more about? Any time I hear about something I'd like to research, I add a card to this column. My personal board is heavy on tech stuff, but there's no reason it has to be. **Anything I find worth getting to know better is fair game**. At this point, all a card needs is a title.

### Researching

As time and interest allow, and I'm not researching something else, I'll move a card from the Interests column into Researching. I don't try to keep Interests prioritized—if something is interesting and/or relevant at the moment, and is something I have the energy to research, then it's a good candidate to move into the Researching column. For example, some interests can be covered in a few hours, while others like new programming languages or frameworks may take weeks just to cover the basics.

The important thing is **there should really only be one card in the Researching column at a time**, or maybe two if I'm researching one interest at work and one on my own time. If you're adapting this to a group learning experience, I think you could have multiple cards in this column, but any given person shouldn't have more than one card assigned to them. (I haven't experimented with this for myself; just an idea at the moment.)

At this time, I'll also take some time to fill in details on the card, as already described. The *Questions* checklist may (and will, hopefully) grow as I dig into a topic.

### Holding

Let's face it, change happens. An interest in the backlog may suddenly become high-priority, or a change in energy levels may decrease your capacity for studying a large topic. That's what the *Holding* column is for. It lets me **put something off for a bit while I study something more appropriate at the moment**.

When tracking this in Trello, I like to enable the card aging power-up. As a card sits unchanged too long, it'll begin to fade. A faded card in the Holding column suggests it's time to either pull it back into the Researching column, or down to the *Abandoned* column (described below).

### Producing

Each successful research project should result in a demonstrable artifact. That could be a blog post talking about it, or a code sample on GitHub, or a presentation at a local users group. The key is **doing something showing that you can put whatever you've learned into your own words**.

### Done

Yes! That blog post is published, or that presentation is done. Nice work! Move the card to Done and pick something new to learn.

### Abandoned

It's not uncommon for a research interest to just not pan out. Maybe it's not as interesting as it sounded on the surface, or maybe now is not the right time to invest attention into it. Instead of forcing a card along the board from *Researching* to *Done*, **it's perfectly fine to let it go and move on to more interesting things**. That's what the *Abandoned* column is for. I like this better than deleting an interest entirely—you never know when you'll need to go back and look at those notes.

There's also no reason you can't revive an abandoned interest. I have a card sitting in my own Abandoned column for a certain web framework I *may* need to understand better at a future date, but not right now. **If and when that day comes, I'll be happy to pull it back in.**

## Tips

As I've been working on and in this system, I've found a couple of things to keep in mind:

- **Keep things reasonable:** I try to scope cards to be doable in no more than a month. Further study in a topic can be done in future cards, perhaps riffing off of the Questions that arise during preliminary study. This is where GTD's inspiration on the approach plays in—the key is to break things down into simple, manageable actions.
- **Be willing to let go:** Don't make things not fun. If a topic is boring, let it go and move it to the Abandoned column. If it's interesting but over your head, put it on hold and study a prerequisite instead.

## Summary

That's it so far. I've been running this system for a couple of months now. As I write this, I have 29 cards in Interests, one in Researching, one in Holding, one in Producing (waiting on a blog post), two in Done, and two in Abandoned. I can't prove it just yet, but it seems like my tweaks have settled down and the system is working reasonably well at the moment.

Again, none of this is proven by science or even from evidence by anyone using it besides me. I plan to keep using this approach for my own learning, and hope it inspires others to give it a try and fork it for their own use.

I also have a few forks of my own in mind, at some point:

- Right now, I keep my personal research board private, mainly because I'm still sorting through many parts of it. Now that I've aired the idea and current approach, though, is there any reason I shouldn't make my board public (but read-only; it's *my* board, after all) and link it from my blog and social media outlets? Would it add to accountability, or just increase anxiety?
- As mentioned, I'm curious to try this in a group setting. I hope to chat with someone at thoughtbot about this at some point, but am also planning to roll it out to some degree in one or more of my various groups in the coming months.

I hope this sounds interesting or helpful to some of you. Whether you give it a try yourself or not, I wish you the best of luck in your own learning goals and other resolutions for 2016 (or whatever year it is as you read this). Thanks for reading!

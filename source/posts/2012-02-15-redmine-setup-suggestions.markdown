---

date: 2012-02-15
layout: page
title: "Returing to Redmine: Suggestions for better workflows and productivity"
tags: [ "Project Management", "Work" ]

---

<img src="/images/content/redmine.png" alt="" class="right" />After
experimenting with a number of issue tracking methods (some I’d label
*antimethods\_) and products I’ve returned to
[Redmine](http://www.redmine.org/) for both team-oriented and solo
projects. Out of the box, Redmine is a good fit for me in a number of
ways:
\
\* I can host it myself . And since it’s written in Ruby I can deploy it
on existing hardware without worrying about a lot of new dependencies.\
\* Redmine’s interface isn’t overloaded with Javascript for the sake of
Javascript. So what if I see the page refresh every now and then&mdash;I
know what Redmine’s doing.\
\* Redmine doesn’t try to become my daily to-do list .\
\* It doesn’t enforce any ideology on me&mdash;[Pivotal
Tracker](http://pivotaltracker.com/) is great for capital-A Agile teams,
but if you work in an environment that doesn’t quite do Agile by the
letter you may get lost in the lingo. \
\* Redmine makes it easy to collect the good kinds of
documentation&mdash;conversations, lessons learned, procedures to
inevitably replicate. This is my chief complaint about upstart
[Asana](http://asana.com/), which unless I’m missing something isn’t
much more than a glorified group to-do list. Its note-taking features
are lacking.
\
That said, a fresh installation of Redmine is likely going to need some
tweaks before it can help you effectively track issues and products. In
my case, I wanted it to be as easy as possible to record an issue and
get back to whatever is the task at hand. As anyone who’s installed
Redmine and poked around its settings can tell, the software itself is
pretty flexible. The trick is knowing how to make those settings work
with your workflow.
\
To do this, I strongly recommend Eric Davis’ e-book*[Redmine
Tips](http://www.redminetips.com/_). As both a core Redmine developer
and daily user of the software, Eric does a good job walking through not
just *how* to adjust Redmine’s settings, but also good reasons *why* to
adjust them in certain ways.

After going through the tips in the book I did the following:

-   **Feature is the default tracker:** As I mentioned, the bulk of what
    shows up in my inbox are feature requests. Some are good ideas, some
    not so much, some are intriguing but not feasible (at least for the
    moment). My other trackers are Bug, Support, and Technical Debt
    (more on that in a moment).
-   **Proposed is the default status:** This makes more sense in my
    workflow than New. My other status options are Approved, In
    Progress, Resolved, Feedback, Closed, and Declined.
-   **Wish List is the default priority:** Again, since most of what I
    get are feature requests, I don’t want to assign them a regular
    priority by default. Unless something is a bug it most likely goes
    in as a wish list feature. I also reduced the other priorities to
    Low, Normal, and High&mdash;everything beyond that was redundant.
-   **Remove unnecessary defaults:** Current date as issue start date
    comes to mind. I prefer to have it blank until an issue gets
    approved and assigned. Note: If your Redmine installation is out of
    date you may not have the option to change this setting.
-   **Workflow setting adjustments:** Don’t forget, if you make changes
    to Redmine’s default trackers and issue statuses you’ll need to
    update workflows accordingly.

A few more suggestions:

-   I’ve implied this already, but don’t try to make Redmine (or any
    issue tracker) serve as a to-do list. It’s not intended for things
    like recurring tasks, for example, and breaking things down to
    GTD-level minutiae is a sure-fire way to an overwhelming issues
    list. Use Redmine for the big picture and your task list of choice
    for the details. (And managers, don’t try to dictate task list
    software on employees; as long as things are getting done people
    should use whatever system works for them. Again, hate mail
    welcome.)
-   Make good use of Redmine’s other modules, when it makes sense to do
    so. Project wikis are an easy way to collect random scraps of
    information under one roof, for example.
-   Turn off the modules your project doesn’t use. Otherwise they’re
    just interface noise. You can always activate them later.
-   Be as open as possible. In our case, that means requiring login to
    access Redmine&mdash;but all projects are set to public, so
    non-project members can see what’s going on.

### Redmine for non-technical projects?

My next step is to explore Redmine’s possibilities as a management tool
for non-software projects&mdash;specifically, proposal writing and
instructional design. If you have experience with using Redmine or a
similar product outside of typical technical products I’d love to hear
from you.

---

date: 2011-06-11
layout: page
title: "TextMate snippets for CanCan (and other Ruby things)"
excerpt: "I shared some handy snippets for CanCan, Jekyll, Factory Girl, and Haml this week on GitHub; here's the lowdown."
tags: [ "Rails", "Ruby", "Programming", "Open Source" ]

---

In the interest of keeping my TextMate snippets synced better between my
work and home computers, I decided to share a couple of bundles on
GitHub this week. The first is a [bundle of several random
snippets](https://github.com/ruralocity/Ruralocity.tmbundle) I use with
Haml, Jekyll, and Factory Girl. See the README for details. Nothing
fancy, but definitely timesaving for me.

I split out my snippets for the CanCan authorization gem, rounded them
out a bit, and put them in [a bundle of their
own](https://github.com/ruralocity/cancan-tmbundle). Here’s the list of
tab-complete shortcuts as it currently stands:

#### Defining abilities in <code>ability.rb</code>:

    can :manage       cm
    can :read         cr
    can :index        ci
    can :create       cc
    can :update       cu
    can :destroy      cd
    can (array)       c
    can (block)       cb
    cannot :manage    ctm
    cannot :read      ctr
    cannot :index     cti
    cannot :create    ctc
    cannot :update    ctu
    cannot :destroy   ctd
    cannot (array)    ct
    cannot (block)    ctb

#### Checking abilities in views and controllers:

    if can? :manage    cm
    if can? :create    cc
    if can? :update    cu
    if can? :destroy   cd
    if can? :index     ci

#### Protecting controllers and actions:

    load_and_authorize_resource       lar
    skip_load_and_authorize_resource  slar
    load_resource                     lr
    skip_load_resource                slr
    authorize_resource                ar
    skip_authorize_resource           sar

If you try them out please let me know what you think.

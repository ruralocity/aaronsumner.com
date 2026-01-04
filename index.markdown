---
layout: default
title: Home
---

<div id="projects">
  <div class="row">
    <div class="project project-featured col-md-6">
        <a href="https://leftofthe.dev/"><img src="/assets/images/left-of-the-dev.png" alt="Everyday Rails" style="width:100px" /></a>
        I've blogged at
        <a href="https://leftofthe.dev/">Left of the Dev</a> (formerly Everyday Rails)
        since 2010. It's about whatever's grabbing my attention right now as a software developer,
        with a healthy blend of pragmatic and fun.
    </div>
    <div class="project project-featured col-md-6">
      <a href="https://bandageman.com/"><img src="/assets/images/bandageman.png" alt="Bandageman Studios" style="width:100px" /></a>
      <a href="https://bandageman.com/">Bandageman Studios</a>
      is my extremely serious video game empire. Or maybe it's just an excuse for me to learn video game development through silly little games about obscure Pacific Northwest cryptids, and/or my dog.
    </div>
  </div>

<div class="row">
    <div class="project col-md-4">
        <a href="https://leanpub.com/everydayrailsrspec"><img src="/assets/images/rspec-book-2024-xl.jpg" class="book" style="width: 100px" alt="Everyday Rails Testing with RSpec" /></a>
        Get productive with test-driven development in Rails with
        <a href="https://leanpub.com/everydayrailsrspec">Everyday Rails Testing
        with RSpec</a>! Learn how to <strong>test with confidence</strong> through core fundamentals and
        simple, readable tests that pass.
    </div>

    <div class="project col-md-4">
      <a href="https://lowoverheadwood.etsy.com/"><img src="/assets/images/low-overhead-square.png" style="width: 100px" alt="Low Overhead Industries" /></a>
<a href="https://lowoverheadwood.etsy.com/">Low Overhead Industries</a>
is my woodworking side project, currently focused on fun
trinkets created from ordinary scrap wood. Just a lightly-populated Etsy shop for now, hopefully more in 2026.
    </div>
    <div class="project col-md-4">
      <a href="https://soundrefound.com/">Sound Refound</a> is an online gallery
      of promotional flyers for concerts. I've collected these over the years,
      primarily in the Lawrence, Kansas, and Seattle, Washington areas.
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-12 project-featured">
    👋 <strong>I do not subscribe to mainstream social media platforms,</strong> so as an independent author and artist, I really appreciate your support! If I've shared anything here you find amusing or interesting, please share it in kind with your friends, family, and colleagues. You can follow my projects on <a href="https://mastodon.social/@ruralocity">Mastodon</a> or <a href="https://bsky.app/profile/ruralocity.bsky.social">Bluesky</a>. 🤗
  </div>
</div>

<hr />

<div class="row">
  <div class="col-md-6">
    <h3>Recent posts</h3>

    <ul>
      {% for post in site.posts limit: 3 %}
        <li>
          <a href="{{ post.url }}">{{ post.title }}</a>
          <time>({{ post.date | date: '%B %e, %Y' }})</time>
        </li>
      {% endfor %}
    </ul>

    <p>
      <a href="/pages/archives.html">Hit the archives for more</a>
    </p>

    <h3>Now reading</h3>
    <ul>
      {% assign recent = site.reading | reverse %}
      {% for post in recent limit: 3 %}
        <li>
          <a href="{{ post.purchase_url }}">{{ post.title }}</a>
          {% assign attribution = "" | split: "," | push: post.author | push: post.publisher %}
          ({{ attribution | join: "; "}})
        </li>
      {% endfor %}
    </ul>

    <p>
      <a href="/pages/reading.html">Complete reading list</a>
    </p>
  </div>

  <div id="bio" class="col-md-6">
    <h3>Biography</h3>

    <img src="/assets/images/mug2022.jpg" width="175" height="175" alt="photo of the author" class="floater" />

    <p>
      I'm Aaron Sumner: Hackity-hack woodworker, low-and-slow cooker, tiny-scale
      gardener, Jayhawk, run/walk/runner, and cat herder, currently residing in
      Saint Louis, Missouri, USA. Also: A former league bowler and Olympic speed
      walker.
    </p>

    <p>
      I still write a lot of code in my role as a Software Engineering
      Manager at
      <a href="https://www.oreilly.com/">O’Reilly Media</a>. Some of the other
      times I write about writing software as an independent technical author at
      <a href="https://leftofthe.dev/">Left of the Dev</a>.
    </p>

    <p>
      Previous stops include Astoria, Oregon; Lawrence, Kansas; Seattle, Washington;
      and Jersey County, Illinois.
    </p>

    <p>
      All of the above statements are true.
    </p>
  </div>
</div>

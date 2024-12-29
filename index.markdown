---
layout: default
title: Home
---

<div id="projects">
  <div class="row">
    <div class="project project-featured col-md-6">
      <a href="https://leanpub.com/everydayrailsrspec"><img src="/assets/images/rspec-book-2024-xl.jpg" class="book" style="width: 100px" alt="Everyday Rails Testing with RSpec" /></a>
      Ready to be productive with test-driven development in Rails? Check out my book
      <a href="https://leanpub.com/everydayrailsrspec">Everyday Rails Testing
      with RSpec</a>! Learn how to test your
      Rails applications the way I did and <strong>test with confidence</strong>, by focusing on core technologies and
      simple, readable tests that pass. <a
      href="https://leanpub.com/everydayrailsrspec">Learn more</a>.
    </div>
    <div class="project project-featured col-md-6">
      <a href="https://lowoverheadwood.etsy.com/"><img src="/assets/images/low-overhead-square.png" style="width: 100px" alt="Low Overhead Industries" /></a>
      <a href="https://lowoverheadwood.etsy.com/">Low Overhead Industries</a>
      is my semi-dedicated-but-not-entirely-serious approach to woodworking
      within constraints, and/or my attempt to
      subsidize ongoing projects. Follow along as I build a simple, functional workshop
      with limited space and budget, or just buy something to
      <a href="https://lowoverheadwood.etsy.com/">support my woodworking habit</a>!
    </div>
  </div>

  <div class="row">
    <div class="project col-md-4">
    <a href="https://everydayrails.com/"><img src="/assets/images/everyday_rails.png" alt="Everyday Rails" style="width:100px" /></a>
      <a href="https://everydayrails.com/">Everyday Rails</a> is a blog for
      people who need to build stuff with Rails and get on to their next
      project. Sometimes it's still about Ruby and Rails, though these days I
      tend to think and write about broader topics there.
    </div>
    <div class="project col-md-4">
      <a href="https://soundrefound.com/">Sound Refound</a> is an online gallery
      of promotional flyers for concerts. I've collected these over the years,
      primarily in the Lawrence, Kansas, and Seattle, Washington areas.
    </div>
    <div class="project col-md-4">
      <a
         href="https://marketplace.visualstudio.com/items?itemName=everydayrails.everyday-rails-rspec-snippets">Everyday Rails RSpec Snippets</a>
      is a collection of snippets to speed up and simplify writing tests in Visual Studio Code,
      as taught in <a href="https://leanpub.com/everydayrailsrspec">my Rails testing book</a>.
      I use these snippets every day to speed up my test-driven development!
    </div>
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
      Sometimes I write software in my role as an Associate Software Engineering
      Manager at
      <a href="https://www.oreilly.com/">O’Reilly Media</a>. Some of the other
      times I write about writing software as an independent technical author at
      <a href="https://everydayrails.com/">Everyday Rails</a>.
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

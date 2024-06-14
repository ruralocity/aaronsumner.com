---
date: 2013-03-01
layout: page
title: "Everyday Rails Testing with RSpec book updates: February 2013's Project a Month Project"
---

Keeping up with the [Project a Month Project](/projects.html), I took time in February to complete a much-needed round of updates to my self-published book [Everyday Rails Testing with RSpec](https://leanpub.com/everydayrailsrspec). If you have already purchased the book and weren't aware, you can head over to Leanpub and download an updated copy. Here's a rundown of what was addressed in this update:

- Throughout the book, I replaced the older `.should` syntax with the preferred `expect().to` syntax--in other words, `some_known_truth.should be_true` becomes `expect(some_known_truth).to be_true`. Even though there are still books and tutorials out there using the older syntax, I wanted to get things moving in the right direction--it was also a good way to get myself to quit memory-typing `.should` all the time in my tests.
- I updated the chapter on Capybara to cover changes in version 2.0. This means that what were formerly request specs are now feature specs, complete with `feature` and `scenario` blocks, along with gotchas from Capybara's dislike of ambiguous matching.
- The early chapters have been reworked. Instead of jumping right into factories, I start things off by using basic Ruby objects to build up test data. Factories get their own chapter following that, and are used throughout the remainder of the book.
- I made copy edits throughout the book; if I didn't like how something read I updated it to hopefully make it better. (Some of the content in the book is almost a year old by now!)
- Code samples for the affected chapters have been updated to reflect a more recent version of Rails 3.2, the latest versions of RSpec, Capybara, and FactoryGirl, the aforementioned change from `.should` to `expect().to`, and other dependencies.

A couple of things still in progress:

- I'm still ironing out a few things in the *Speeding Up Specs* chapter--primarily an expansion on the previous content.
- *Testing the Rest* also has some new content; right now I'm still reviewing the older stuff to make sure it still applies.

The plan is to get these knocked out in the next few days, then it's on to the last edit: Updating the Rails 3.2-based application with a 4.0-base. I think I'm going to start with a fresh code base and build up the new application. The good news is I've been playing with the beta of Rails 4.0 and so far haven't found any major issues with my existing approach. Look for the final edits around the time Rails 4.0 goes final.
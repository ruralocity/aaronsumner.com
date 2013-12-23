---

date: 2010-05-06
layout: page
title: "Rails Test Prescriptions is going to be the best book on Rails testing"
tags: [ "Rails", "Books" ]

---

This week I went through *[Rails Test Prescriptions: Keeping Your
Application
Healthy](http://pragprog.com/titles/nrtest/rails-test-prescriptions_) by
Noel Rappin, from Pragmatic Programmers. It’s still a beta book, and has
only been out for a couple of weeks, but I think I’ve finally found a
book that will help me write and maintain tests for my Rails app .
\
For starters, it may be helpful to me that I already understand the
basic philosophies behind TDD. Outside-in design, red-green-refactor, I
get all that. However, it always seemed to me that those approaches
didn’t always reflect real-world development. At least, they didn’t
reflect*my\_ real world of development. As much as I *wanted* to test my
code, it didn’t happen at the rate I wanted~~~~either because I got sick
of helping Cucumber understand English, or working around Webrat’s
finickiness, or waiting for *The RSpec Book* to get done. So I put
together test suites as best as I could, using tools I understood,
testing the things I knew how to test while fully acknowledging that
there were other things that *should* be tested, but writing possibly
flawed tests would be worse than writing no tests. That’s been my system
for the past year.
\
Imagine my delight, then, when Rappin admits that while outside-in and
red-green-refactor may be the gold standards, in real life they don’t
always work out. *As long as your feedback loop between test and code is
relatively tight, you’re probably doing OK.* I don’t know why, but
seeing this in electronic print was a huge relief to me~~~~not that I
needed validation from other developers, but mainly for my own sanity as
I continue to chip away at a couple of years’ worth of code that needs
testing. I think I’m going to get this all figured out. The explanation
of mocks versus stubs alone is worth the price of the e-book.

The book, by my estimation, is probably about half done, with chapters
specific to RSpec, Shoulda, Selenium, Cucumber, and legacy testing still
to be written. What’s in place now may not be for the reader who wants
to follow along as the author codes—there are code samples, but it’s not
structured in a set-and-app-up-from-scratch way like other computer
texts are. I don’t know if the book will be in this same format once
it’s out of beta, but as-is it lends itself more to a read-and-refresh
than a tutorial or reference book. However, I’ve yet to see anything
better for explaining Rails testing from a high level, and look forward
to subsequent updates to the beta book.

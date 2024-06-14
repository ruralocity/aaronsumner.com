---
date: 2013-01-30
layout: page
title: "Sales visualizations for Leanpub authors: January 2013's Project a Month Project"
---

This month's Project a Month Project was a small one, with a very small intended audience: Me. As you may know, I began selling a [self-published book](https://leanpub.com/everydayrailsrspec) last May, via a publishing service called Leanpub. Leanpub offers a CSV of sales data for authors, updated upon every new sale. I wanted to look at this data graphically as opposed to tabularly--and since Rails is my hammer and this problem was a nail, I wrote a [dirty little Rails app](https://github.com/ruralocity/leanpub_analytics) to create some basic charts of my sales and royalty data.

*Standard disclaimer: This is not a Leanpub product! I'm only using the name Leanpub since this application is useless without a Leanpub sales data file. [Leanpub](https://leanpub.com/) is a service of Ruboss Technology Corporation, a corporation incorporated in British Columbia, Canada. I self-publish a book using this service, but am otherwise not affiliated with them in any way.*

I run the application locally on my computer, so there was no need to fret about authentication or other security measures. Once data are updated via a basic file upload, then parsed with Ruby's CSV library, the convenient [Highcharts](http://www.highcharts.com/) Javascript library (via the [Lazy Highcharts gem](http://rubygems.org/gems/lazy_high_charts)) display data month-over-month. I also break things down day-over-day within a selected month.

The code is ugly with no test suite. The user interface is spartan at best. But I didn't write this to show off any software development prowess. I wrote it because I needed it. I [open sourced it](https://github.com/ruralocity/leanpub_analytics) in case someone else might need it.

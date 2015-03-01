---
title: Learning Vim, one year later
date: 2015-03-01 12:24 UTC
tags:
---

A little more than ago, I wrote a post about [the approach I was taking to learn
Vim](http://aaronsumner.com/posts/2014/02/learning-vim-a-little-at-a-time.html).
At the time, my TextMate 2-to-Vim ratio across all projects was probably 7:3.
Now, they're just about flipped--there are still times when I reach for my old
standby, but, increasingly, I'm opening Vim first. What helped me break through?

**Continued practice**: As mentioned a year ago, I (still) take a little time,
every day, for deliberate practice in Vim (and other tools; more on that
someday). When I know there must be a better way to do something, I look it up
and either write it down or add it to my `vimrc` for future use. (Example: While
writing this entry, I wondered about ways to show a word count on the current
document. I found three.)

**Continued customization**: That blank `vimrc` file I started with still isn't
as large as that of a seasoned Vim user, but it's got a lot more than it did
this time last year. It's a constant process. Some things stick, and some get
deleted. I also experiment liberally with plugins like
[ctrlp](https://github.com/kien/ctrlp.vim),
[vim-bundler](https://github.com/tpope/vim-bundler), and
[vim-rails](https://github.com/tpope/vim-rails). Vim's been around a long time,
and if there's something you want to tweak, chances are somebody's already
tweaked it. It's up to you to pick and choose and cobble into your own
functioning setup. A tip: Document your `vimrc` file as you go, at least in the
early going. Among other things, this has helped me as I tinker with my status
line--each section is commented so I can remember what it does and, sometimes,
where I learned the technique.

**Continued learning**: I've learned the most by pairing with other Vim users
and asking them how they do certain things. I also got a lot out of [Mastering
Vim](http://shop.oreilly.com/product/110000687.do) by Damian Conway (published
by O'Reilly Media, my employer). The [Vim Tips
Wiki](http://vim.wikia.com/wiki/Vim_Tips_Wiki) is so indispensable that I
created a [custom Alfred
search](alfred://customsearch/Search%20Vim%20Wiki%20for/vw/utf8/noplus/http://vim.wikia.com/wiki/Special:Search?search={query}&fulltext=Search&resultsLang=en)
for it. Finally, thoughtbot regularly shares [vim
  tips](https://robots.thoughtbot.com/tags/vim) particularly germane to my own
work.

Learning vim, like learning just about anything else, is knowing what you don't
know--and then, knowing the right places to look for answers. From there, it
just takes some persistence to stick with it and keep getting better. Good luck!

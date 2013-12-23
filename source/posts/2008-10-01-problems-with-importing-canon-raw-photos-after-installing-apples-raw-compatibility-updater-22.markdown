--- 
wordpress_id: 93
date: 2008-10-01
layout: page
title: Problems with importing Canon RAW photos after installing Apple's Raw compatibility updater 2.2
wordpress_url: http://www.aaronsumner.com/?p=93
tags: [ Macintosh, Photography ]
---
I'm adding a new category to share things I've had to hunt and dig for, in hopes it makes it easier for others who run into similar problems.

Long story short: My Canon Rebel XTi wouldn't connect with iPhoto or Image Capture. Turns out Apple's Raw Compatibility Updater 2.2 totally messed with the camera's ability to connect to my computer. It took some major digging, but here's what I wound up doing:

<ol>
<li>Locate the 2.2 version of Apple's Raw drivers at <code>/System/Library/CoreServices/RawCamera.bundle</code> and trash it. You may need to restart at this point.</li>
<li><a href="http://www.apple.com/support/downloads/digitalcamerarawcompatibilityupdate21.html">Download the older, 2.1 version of the Raw compatibility updater</a> and install it. The first few times I tried I got an error message saying I already had a newer version installed. Eventually, though, it worked.</li>
<li>See if iPhoto and/or Image Capture (or whatever utility you use) works now.</li>
</ol>

I hope this helps somebody--seriously, it took a lot of searching before I finally found a discussion post on <a href="http://support.apple.com/">Apple's support site</a> explaining what was going on. I've already re-lost the link to it, but thanks to the person who posted this suggestion somewhere on that site.

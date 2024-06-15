Source for my personal website, [aaronsumner.com](https://aaronsumner.com).

## History

- July 2008: Site started as self-hosted WordPress. Good idea at the time.
- January 2010: Converted site from WordPress to Jekyll and moved to git.
- November 2013: Converted site from Jekyll to Middleman. I was enamored by
  Middleman's support for multiple blogs on a single site.
- June 2024: Converted site back to Jekyll from Middleman. I was way behind
  on security patches, the work to move to a newer Middleman was arguably
  heavier than moving back to Jekyll, and Jekyll's new-to-me support for
  using "collections" for splitting up writing posts vs. reading lists
  posts was good enough.

## For my reference

```
rake -T
rake book         # Create a new reading list entry
rake build        # Build site
rake clean        # Clean up generated site files
rake post[title]  # Create a new blog post
rake serve        # Serve site locally
```

## License

All content [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US), unless otherwise noted.

See LICENSE for code licensing.

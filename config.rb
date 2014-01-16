###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

with_layout :page do
  page "/pages/*"
end

page "/atom.xml", :layout => false

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'images'

# Handle redirects from old post format in development
require 'rack/rewrite'
use Rack::Rewrite do
  r301 '/projects.html', '/pages/projects.html'
  r301 '/archives.html', '/pages/archives.html'
  r301 '/colophon.html', '/pages/colophon.html'
  r301 %r{^/(\d+)/(\d+)/(.*)\/}, '/posts/$1/$2/$3.html'
  r301 %r{^/(\d+)/(\d+)/(.*)}, '/posts/$1/$2/$3.html'
end

activate :blog do |blog|
  blog.name = "posts"
  blog.prefix = "posts"
  blog.permalink = ":year/:month/:title.html"
  blog.layout = "page"
end

activate :blog do |blog|
  blog.name = "reading"
  blog.prefix = "reading"
  blog.permalink = ":title.html"
end

configure :development do
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end

configure :build do
  activate :google_analytics do |ga|
    ga.tracking_id = "UA-1291847-4"
    ga.debug = false
    ga.anonymize_ip = true
    ga.domain_name = "aaronsumner.com"
    ga.allow_linker = true
  end
end

helpers do
  def author_and_publisher(data)
    [data.author, data.publisher].join('; ')
  end
end

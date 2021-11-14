page "/pages/*", :layout => :page
page "/atom.xml", :layout => false


set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'

# Handle redirects from old post format in development
require 'rack/rewrite'
use ::Rack::Rewrite do
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

helpers do
  def author_and_publisher(data)
    [data.author, data.publisher].join('; ')
  end
end

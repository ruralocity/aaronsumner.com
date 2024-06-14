require "rake"
require "date"

desc "Serve site locally"
task :serve do
  exec "jekyll serve"
end

desc "Build site"
task :build do
  exec "jekyll build"
end

desc "Clean up generated site files"
task :clean do
  rm_rf "build"
end

task :default => :serve

desc "Create a new blog post"
task :post, [:title] do |t, args|
  title = args.title
  filename_title = title.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
  date_prefix = Date.today.strftime("%Y-%m-%d")
  filename = "_posts/#{date_prefix}-#{filename_title}.markdown"

  open(filename, "w") do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title}\""
    post.puts "---"
    post.puts ""
  end
end

desc "Create a new reading list entry"
task :book do
  puts "Book title:"
  title = $stdin.gets.strip
  puts "Author:"
  author = $stdin.gets.strip
  puts "Editor:"
  editor = $stdin.gets.strip
  puts "Publisher:"
  publisher = $stdin.gets.strip
  puts "Purchase URL:"
  purchase_url = $stdin.gets.strip
  puts "Image ID:"
  image_id = $stdin.gets.strip

  image_url = "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"

  filename_title = title.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
  filename_author = (author || editor).downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
  date_prefix = Date.today.strftime("%Y-%m-%d")
  filename = "_reading/#{date_prefix}-#{filename_title}.markdown"

  open(filename, "w") do |post|
    post.puts "---"
    post.puts "title: \"#{title}\""
    post.puts "author: \"#{author}\""
    post.puts "editor: \"#{editor}\""
    post.puts "publisher: \"#{publisher}\""
    post.puts "purchase_url: \"#{purchase_url}\""
    post.puts "image: \"#{image_url}\""
    post.puts "---"
  end
end

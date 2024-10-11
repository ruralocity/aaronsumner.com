require "date"

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
puts "Image URL:"
image_id = $stdin.gets.strip.split("/").last.split(".").first

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

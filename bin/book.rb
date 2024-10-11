require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "prompts"
end

require "date"
require "prompts"

title = Prompts::TextPrompt.ask(label: "Title:", required: true)
author = Prompts::TextPrompt.ask(label: "Author:")
editor = Prompts::TextPrompt.ask(label: "Editor:")
publisher = Prompts::TextPrompt.ask(label: "Publisher:", required: true)
purchase_url = Prompts::TextPrompt.ask(label: "Purchase URL:", required: true)
image_id = Prompts::TextPrompt.ask(label: "Image URL:")

if image_id
  image_id.split("/").last.split(".").first
  image_url = "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
end

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

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "prompts"
  gem "nokogiri"
  gem "open-uri"
  gem "json"
end

require "date"
require "prompts"
require "yaml"
require "nokogiri"
require "open-uri"
require "net/http"
require "json"

def extract_frontmatter(file_path)
  return {} unless File.exist?(file_path)

  content = File.read(file_path)
  if content =~ /\A---\s*\n(.*?)\n---\s*\n/m
    begin
      YAML.safe_load($1)
    rescue
      {}
    end
  else
    {}
  end
end

# Function to scrape book data from Amazon URL
def scrape_amazon_book_data(url)
  book_data = {}

  begin
    if url.include?("amzn.to")
      # Follow the redirect to get the actual Amazon product page
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request_head(uri.path)

      if response['location']
        url = response['location']
        puts "Redirected to: #{url}"
      end
    end

    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
    doc = Nokogiri::HTML(URI.open(url, "User-Agent" => user_agent))

    title_element = doc.css("#productTitle").first
    book_data[:title] = title_element ? title_element.text.strip : nil

    author_element = doc.css("#bylineInfo .author a").first
    book_data[:author] = author_element ? author_element.text.strip : nil

    details = doc.css("#detailBullets_feature_div li, #productDetailsTable .content li")
    details.each do |detail|
      text = detail.text.strip
      if text.include?("Publisher") || text.include?("Published by")
        publisher_text = text.split(":").last.strip
        book_data[:publisher] = publisher_text.split("(").first.strip
      end
    end

    image_data = nil
    script_tags = doc.css("script").select { |s| s.text.include?("imageGalleryData") }
    if !script_tags.empty?
      script_text = script_tags.first.text
      if script_text =~ /imageGalleryData.*?(\[.*?\])/m
        begin
          image_data_json = $1.gsub("'", '"')
          image_data = JSON.parse(image_data_json)
        rescue JSON::ParserError
          # noop
        end
      end
    end

    if image_data && !image_data.empty? && image_data.first["mainUrl"]
      main_image_url = image_data.first["mainUrl"]
      if main_image_url.include?("images-na.ssl-images-amazon.com") || main_image_url.include?("images-amazon.com")
        image_id = main_image_url.split("/").last.split("_").first.split(".").first
        book_data[:image_id] = image_id
        book_data[:image_url] = "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
      end
    else
      image_element = doc.css("#imgBlkFront, #landingImage, #main-image").first
      if image_element
        image_url = image_element['src'] || image_element['data-a-dynamic-image'] || image_element['data-old-hires']

        if image_element['data-a-dynamic-image']
          begin
            image_json = JSON.parse(image_element['data-a-dynamic-image'])
            image_url = image_json.keys.first if image_json.is_a?(Hash) && !image_json.empty?
          rescue JSON::ParserError
            # noop
          end
        end

        if image_url && (image_url.include?("images-na.ssl-images-amazon.com") || image_url.include?("images-amazon.com"))
          image_id = image_url.split("/").last.split("_").first.split(".").first
          book_data[:image_id] = image_id
          book_data[:image_url] = "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
        end
      end
    end

    if !book_data[:image_id]
      doc.css("img").each do |img|
        src = img['src']
        if src && (src.include?("images-na.ssl-images-amazon.com") || src.include?("images-amazon.com")) &&
           (src.include?("/I/") || src.include?("/P/"))
          image_id = src.split("/").last.split("_").first.split(".").first
          if image_id && image_id.length > 8  # Likely a valid Amazon image ID
            book_data[:image_id] = image_id
            book_data[:image_url] = "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
            break
          end
        end
      end
    end

  rescue => e
    puts "Error scraping data: #{e.message}"
    puts e.backtrace.join("\n")
  end

  book_data
end

sample_file = Dir.glob("_reading/*.markdown").sort.last
frontmatter = extract_frontmatter(sample_file)

purchase_url = Prompts::TextPrompt.ask(label: "Amazon URL:", required: true)
puts "Scraping data from #{purchase_url}..."
book_data = scrape_amazon_book_data(purchase_url)

title = Prompts::TextPrompt.ask(
  label: "Title:",
  required: true,
  default: book_data[:title]
)

author = Prompts::TextPrompt.ask(
  label: "Author:",
  default: book_data[:author] || frontmatter["author"]
)

editor = Prompts::TextPrompt.ask(
  label: "Editor:",
  default: frontmatter["editor"]
)

publisher = Prompts::TextPrompt.ask(
  label: "Publisher:",
  required: true,
  default: book_data[:publisher] || frontmatter["publisher"]
)

publisher = publisher.to_s.gsub(/[[:cntrl:]]/, '').strip

publication_date = Prompts::TextPrompt.ask(
  label: "Publication Date (YYYY-MM-DD):",
  default: Date.today.to_s
)

image_url = book_data[:image_url]
if !image_url && frontmatter["image"] && frontmatter["image"].include?("images-na.ssl-images-amazon.com")
  image_id = Prompts::TextPrompt.ask(
    label: "Amazon Image ID (e.g. 51zG4F1G0BL):",
    default: frontmatter["image"].split("/").last.split("_").first
  )
  image_url = image_id.empty? ? nil : "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
else
  if book_data[:image_id]
    image_id = Prompts::TextPrompt.ask(
      label: "Amazon Image ID (e.g. 51zG4F1G0BL):",
      default: book_data[:image_id]
    )
    image_url = image_id.empty? ? nil : "https://images-na.ssl-images-amazon.com/images/I/#{image_id}._SL75_.jpg"
  end
end

filename_title = title.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
filename_author = (author || editor).to_s.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")

date_prefix = Date.parse(publication_date).strftime("%Y-%m-%d")
filename = "_reading/#{date_prefix}-#{filename_title}.markdown"

tags = frontmatter["tags"]
tags_line = tags ? "tags: #{tags.inspect}" : "tags:"

open(filename, "w") do |post|
  post.puts "---"
  post.puts "title: \"#{title}\""
  post.puts "purchase_url: #{purchase_url}"
  post.puts "author: \"#{author}\"" if author && !author.empty?
  post.puts "editor: \"#{editor}\"" if editor && !editor.empty?
  post.puts "publisher: \"#{publisher}\""
  post.puts "date: #{publication_date}"
  post.puts "image: #{image_url}" if image_url
  post.puts tags_line
  post.puts "---"
  post.puts
end

puts "Created #{filename}"
puts "Scraped data summary:"
puts "- Title: #{title}"
puts "- Author: #{author}"
puts "- Publisher: #{publisher}"
puts "- Image: #{image_url ? 'Found' : 'Not found'}"
puts "- Image ID: #{book_data[:image_id] || image_id}" if book_data[:image_id] || image_id

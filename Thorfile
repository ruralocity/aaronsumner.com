require 'thor'
require 'active_support/inflector'

class Generator < Thor
  include Thor::Actions
  Thor::Sandbox::Generator.source_root('templates')

  # A work in progress ...
  desc "reading", "add a new book to the reading list"
  def reading
    title = ask 'Title:'
    author = ask 'Author:'
    publisher = ask 'Publisher:'
    @reading = Book.new(title, author, publisher)

    template('reading.tt', "source/reading/#{@reading.filename}")
  end
end

# A series of quick Thor tasks I used to convert the site from its legacy Jekyll
# format to the current Middleman version you can see at
# http://www.aaronsumner.com/

class Converter < Thor
  include Thor::Actions
  desc "dateize", "add a date attribute to each post, based on its old filename"
  def dateize
    Dir['source/posts/*'].each do |path|
      next if path == "." or path == ".."
      dir1, dir2, file = path.split("/")
      year, month, day = file.split("-")
      puts "converting #{file} ..."

      inject_into_file path, "date: #{year}-#{month}-#{day}\n", before: "layout: post\n"

      gsub_file path, "layout: post", "layout: page"
      puts "#{file} converted."
    end
  end

  desc "detextilize", "convert Textile-formatted posts to Markdown, using Pandoc"
  def detextilize
    Dir['source/posts/*.textile'].each do |file|
      oldfile = file.split("/")[2]
      frontmatter = /(\A-{3})(.*?)(-{3})/m.match(File.open(file).read)[2]
      gsub_file file, /(\A-{3})(.*?)(-{3})/m, ""
      puts "converting #{oldfile} ..."
      newfile = oldfile.split(".")[0] + ".markdown"
      inside "source/posts" do
        run "pandoc -f textile -t markdown -o #{newfile} #{oldfile}"
        prepend_to_file newfile, "---\n#{frontmatter}\n---\n\n"
      end
      remove_file file
    end
  end

  desc "dehtmlize", "convert HTML-formatted posts to Markdown, using Pandoc"
  def dehtmlize
    Dir['source/posts/*.html'].each do |file|
      oldfile = file.split("/")[2]
      frontmatter = /(\A-{3})(.*?)(-{3})/m.match(File.open(file).read)[2]
      gsub_file file, /(\A-{3})(.*?)(-{3})/m, ""
      puts "converting #{oldfile} ..."
      newfile = oldfile.split(".")[0] + ".markdown"
      inside "source/posts" do
        run "pandoc -f html -t markdown -o #{newfile} #{oldfile}"
        prepend_to_file newfile, "---\n#{frontmatter}\n---\n\n"
      end
      remove_file file
    end
  end

  desc "dewordpressize", "delete old metadata from previous WordPress conversion"
  def dewordpressize
    Dir['source/posts/*'].each do |file|
      puts "converting #{file} ..."
      gsub_file file, /^wordpress_id: \d*$/, ""
      gsub_file file, /^wordpress_url: .*$/, ""
    end
  end

  desc "deabsoluteize", "remove absolute references to aaronsumner.com"
  def deabsoluteize
    Dir['source/posts/*'].each do |file|
      puts "converting #{file} ..."
      gsub_file file, /http:\/\/w*\.*aaronsumner.com\//, "/"
    end
  end
end

class Book
  extend ActiveSupport::Inflector

  attr_reader :title
  attr_reader :author
  attr_reader :publisher
  attr_reader :date

  def initialize(title, author, publisher)
    @title = title
    @author = author
    @publisher = publisher
    @date = Time.new
  end

  def filename
    "#{date_param}-#{title_param}-#{author_param}.html.markdown"
  end

  private

  def title_param
    @title.parameterize
  end

  def author_param
    @author.parameterize
  end

  def date_param
    @date.strftime('%Y-%m-%d')
  end
end

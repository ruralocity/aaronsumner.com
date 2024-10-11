alias run := serve

# List available recipes
default:
  @just --list

# Setup dependencies
[group("development")]
setup:
  bundle install

# Serve site locally
[group("development")]
serve:
  bundle exec jekyll serve

# Build site
[group("maintenance")]
build:
  bundle exec jekyll build

# Clean up generated site files
[group("maintenance")]
clean:
  rm -rf _site

# Create new post
[group("content")]
@create-post TITLE:
  touch "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"

  echo "---" > "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"
  echo "layout: page" >> "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"
  echo "title: \"{{TITLE}}\"" >> "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"
  echo "---" >> "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"
  echo "" >> "_posts/{{datetime('%Y-%m-%d')}}-{{kebabcase(lowercase(TITLE))}}.md"

# Add new reading entry
[group("content")]
@add-book:
  ruby bin/book.rb

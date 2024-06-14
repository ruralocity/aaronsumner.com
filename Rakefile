require "rake"

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

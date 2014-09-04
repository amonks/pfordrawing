#!/bin/ruby

require "optparse"
require "date"

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: ruby ./generate.rb FILENAME [OPTIONS]"
  opt.separator  ""
  opt.separator  "FILENAME: post filename, ie 'reverse2'"
  opt.separator  ""
  opt.separator  "Options"

  # opt.on("--category CATEGORY", "-c CATEGORY", "Set post category to CATEGORY") do |category|
  #   options[:category] = category
  # end

  opt.on("-p","--post","Create file in _posts/ (default is to print to stdout)") do
    options[:post] = true
  end

  opt.on("-d","--draft","Create file in _drafts/ (default is to print to stdout)") do
    options[:draft] = true
  end

  opt.on("-t TITLE","--title TITLE","Set post title (defaults to filename)") do |title|
    options[:title] = title
  end

  opt.on("-c CATEGORY","--category CATEGORY","Set post category (defaults to flowchart)") do |category|
    options[:category] = category
  end

  opt.on("-h","--help","Display this message") do
    options[:help] = true
    puts opt_parser
  end
end

opt_parser.parse!

unless ARGV[0].is_a? String
  puts opt_parser unless options[:help]
else
  title = options[:title] || ARGV[0]
  category = options[:category] || "flowchart"
  filename = Date.today.to_s + "-" + ARGV[0] + ".html"
  template = "---" + "\n" +
    "layout: processingjs" + "\n" +
    "title:  \"" + title.gsub(" ", "\ ") + "\"" + "\n" +
    "date:   " + Time.now.to_s + "\n" +
    "filename: \"" + filename + "\"" + "\n" +
    "categories: " + category + "\n" +
    "---" + "\n" +
    "\n" +
    "processing.setup = function() {" + "\n" +
    "\n" +
    "};" + "\n" +
    "\n" +
    "processing.draw = function() {" + "\n" +
    "\n" +
    "};" + "\n" +
    "\n" +
    "processing.keyPressed = function() {" + "\n" +
    "  console.log(processing.key);" + "\n" +
    "};" + "\n" +
    "\n" +
    "processing.mousePressed = function() {" + "\n" +
    "\n" +
    "};" + "\n" +
    "\n" +
    "processing.mouseReleased = function() {" + "\n" +
    "\n" +
    "};"
  if options[:post]
    %x( echo '#{template}' > _posts/#{filename} )
  elsif options[:draft]
    %x( echo '#{template}' > _drafts/#{filename} )
  else
    puts template
  end
end

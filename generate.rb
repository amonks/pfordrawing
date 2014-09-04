#!/bin/ruby

require "optparse"
require "date"

  options = {}

  opt_parser = OptionParser.new do |opt|
    opt.banner = "Usage: generate FILENAME [OPTIONS]"
    opt.separator  ""
    opt.separator  "FILENAME: post filename, ie 'reverse2'"
    opt.separator  "Options"

    # opt.on("--category CATEGORY", "-c CATEGORY", "Set post category to CATEGORY") do |category|
    #   options[:category] = category
    # end

    opt.on("-m","--make","Create file in `_posts`") do
      options[:make] = true
    end

    opt.on("-t TITLE","--title TITLE","Set post title (defaults to filename)") do |title|
      options[:title] = title
    end

    opt.on("-c CATEGORY","--category CATEGORY","Set post category (defaults to 'flowchart')") do |category|
      options[:category] = category
    end

    opt.on("-h","--help","Display this message") do
      puts opt_parser
    end
  end

  opt_parser.parse!

  unless ARGV[0].is_a? String
    puts opt_parser
  else
    title = options[:title] || ARGV[0]
    category = options[:category] || "flowchart"
    template = "---" + "\n" +
      "layout: processingjs" + "\n" +
      "title:  '" + title + "'" + "\n" +
      "date:   " + Time.now.to_s + "\n" +
      "filename: '" + Date.today.to_s + "-" + ARGV[0] + ".html'" + "\n" +
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
    if options[:make]
      filename = options[:filename] || ARGV[0]
      `echo '#{template}' > _posts/#{Date.today.to_s}-#{ARGV[0]}.html`
    else
      puts template
    end
  end

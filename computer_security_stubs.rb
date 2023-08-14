#!/usr/bin/env ruby
# author: eleAche
# recopile computer security stubs from wikipedia

require 'nokogiri'
require 'httparty'

def scraper(url)
	unparse = HTTParty.get(url)
	parse = Nokogiri::HTML(unparse.body)
	return parse
end

def mining()
	index = scraper("https://en.wikipedia.org/wiki/Category:Computer_security_stubs")
	list = index.css('div.mw-category-group li')
	list_cnt = list.count
	cnt = 1
	while cnt <= list_cnt
		path = list.css('a')[cnt]["href"]
		article = scraper("https://en.wikipedia.org#{path}")
		article_title = article.css('span.mw-page-title-main').text
		article_content = article.css('p').text
		puts "#{article_title}:\t #{article_content}\n\n"
		cnt += 1
	end
end

mining

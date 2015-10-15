require "mechanize"
require 'pry'
require "./db/setup.rb"
require "./lib/all"



class Page<ActiveRecord::Base
  validates_presence_of :name ,:url
validates_uniqeness_of :url
  has_many :links
 attr_reader :list


def self.save_random new_url = nil
agent = Mechanize.new
    #search for random page

if new_url
    page = agent.get(".org/wiki/Special:Random")
else
      page = agent.get("https://www.wikipedia.org/wiki/mainpage")
      link = page.link_text(text: 'random article')
      page - link.click

    # body_text = page.search("div#mw-content-text")
    # results = []
    # body_text.each do |para|
    #   p_results = para.search ('p')
    #   results.push(p_results.text)
    end

i = Page.create(
    name: page.title,
    prelude: page.search("p").first,
    url: page.url
    )

i.save
  end
 def follow_link nums
agent = Mechanize.new
page = agent.get(self.url)
list = (page.search("p").search("a")).to_a
list = list.map{|l|"https://www.wikipedia.org"+l.attributes["href"].value}
list.url.sample(nums).each do|u|
  page.save_random u 
end

 end


end
  Page.save_random

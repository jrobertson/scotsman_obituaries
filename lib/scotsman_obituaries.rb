#!/usr/bin/env ruby

# file: scotsman_obituaries.rb

require 'nokorexi'
require 'open-uri'

# desc: Web scrapes the search results from the Scotsman and 
#       Edinburgh Evening News obituary annoucements from
#       http://announce.jpress.co.uk/?source=jpsc_scot

class ScotsmanObituaries

  def initialize()

    raw_cookie = {
      Name: 'acceptsCookies',
      Value: 'accepts',
      Host: 'www.edinburghnews.scotsman.com',
      Path: '/',
      Expires: 'Fri, 10 Oct 2025 16:53:34 GMT',
      Secure: 'No',
      HttpOnly: 'No'
    }

    @cookie = raw_cookie.to_a.map {|key,val| "%s=%s" % [key, val]}.join '; '

    @url_base = 'http://announce.jpress.co.uk'
    
  end

  def search(title: '', date_range: :last_week)

    raise "ScotsmanObituaries: Please enter a title to search" if title.empty?

    days = {
      today: 1,
      last_week: 7,
      last_month: 31
    }

    search_url = @url_base + "/search?keywords=#{title}&" + \
     "date_limit=#{days[date_range.to_sym]}&date=" + \
          "&type=obit&_fstatus=search&s_source=jpsc_scot"

    s = open(search_url, "Cookie" => @cookie).read
    doc = Nokorexi.new(s).to_doc
    e = doc.at_css '.results'

    e.xpath('li/div[@class="notice"]').inject([]) do |r,notice|
      
      heading = notice.text('h2/a')
      short_text = notice.text('p').strip
      pubdate = Date.parse(notice.\
           element('meta[@itemprop="datePublished"]').attributes[:content])
      id = notice.element('div/a').attributes[:href][/\/(\d+)\?/,1]

      r << {id: id, heading: heading, short_text: short_text, pubdate: pubdate}
    end
    
  end
  
  def more_info(id)

    url = @url_base + '/edinburgh-evening-news-and-' + \
                                     'scotsman-publications/obituary/' + id
    s = open(url, "Cookie" => @cookie).read
    Nokorexi.new(s).to_doc.at_css('.notice_text').text('p')
    
  end

end
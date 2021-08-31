#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.text.split(' - ').first.tidy
    end

    def position
      noko.xpath('following-sibling::text()[1]').text.split(/ and (?=Minister)/).map(&:tidy)
    end
  end

  class Members
    def member_container
      noko.css('#collapse0 strong')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv

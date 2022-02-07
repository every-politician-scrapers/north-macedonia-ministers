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
      raw_position.split(/ and (?=Minister)/).map(&:tidy)
    end

    private

    def raw_position
      noko.xpath('following::text()').map { |node| node.text.sub(/^[[:space:]]?[–-][[:space]]?/, '').tidy }.reject(&:empty?).first
    end

  end

  class Members
    def member_container
      noko.css('#collapse0 a')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv

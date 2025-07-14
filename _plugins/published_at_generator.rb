# frozen_string_literal: true

require 'fileutils'
require 'pathname'

module PublishedAt
  # Generate published date information for all markdown pages
  class Generator < Jekyll::Generator
    def generate(site)
      items = site.collections['notes'].docs
      items.each do |page|
        # Get the file creation time (published date)
        published_time = File.birthtime(page.path) rescue File.ctime(page.path)
        # Format as ISO 8601
        timestamp = published_time.utc.strftime('%FT%T%:z')
        page.data['published_at_timestamp'] = timestamp
      end
    end
  end
end
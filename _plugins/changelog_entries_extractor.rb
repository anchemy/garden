# frozen_string_literal: true

require 'json'
require 'date'

module ChangelogExtractor
  class Generator < Jekyll::Generator
    def generate(site)
      changelog_entries = []
      
      # Process all changelog files
      changelog_files = Dir.glob(File.join(site.source, '_changelogs', '**', '*.md'))
      
      changelog_files.each do |file|
        content = File.read(file)
        # Extract front matter
        if content.start_with?('---')
          parts = content.split('---', 3)
          front_matter = parts[1]
          body = parts[2]
          
          # Parse YAML front matter
          fm = YAML.safe_load(front_matter) || {}
          
          note_title = fm['note_title'] || 'Unknown'
          
          # Extract changelog entries from the body using regex
          # Look for patterns like: title="...", date_published="...", date_updated="..."
          # This handles the Liquid template syntax
          entry_pattern = /title="([^"]+)"\s+date_published="([^"]+)"\s+date_updated="([^"]+)"/m
          
          body.scan(entry_pattern).each do |match|
            entry_title = match[0]
            date_published = match[1]
            date_updated = match[2]
            
            begin
              # Parse dates - use the more recent date (date_updated) for sorting
              published_date = Date.parse(date_published)
              updated_date = Date.parse(date_updated)
              sort_date = updated_date
              
              changelog_entries << {
                'note_title' => note_title,
                'entry_title' => entry_title,
                'date_published' => published_date,
                'date_updated' => updated_date,
                'sort_date' => sort_date,
                'date_str' => sort_date.to_s
              }
            rescue ArgumentError
              # Skip entries with invalid dates
              next
            end
          end
        end
      end
      
      # Sort entries by date (newest first)
      changelog_entries = changelog_entries.sort_by { |e| e['sort_date'] }.reverse
      
      # Store changelog entries in site data
      site.data['changelog_entries'] = changelog_entries
      
      # Group entries by date for the calendar
      entries_by_date = {}
      changelog_entries.each do |entry|
        date_str = entry['sort_date'].to_s
        entries_by_date[date_str] ||= []
        entries_by_date[date_str] << entry
      end
      
      site.data['changelog_entries_by_date'] = entries_by_date
      
      # Get today's entries
      today = Date.today.to_s
      site.data['today_changelog_entries'] = entries_by_date[today] || []
    end
  end
end


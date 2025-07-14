# frozen_string_literal: true

module TopicPages
  class Generator < Jekyll::Generator
    def generate(site)
      topics = Set.new
      notes = site.collections['notes'].docs

      # Collect all unique topics
      notes.each do |note|
        if note.data['topics'].is_a?(Array)
          note.data['topics'].each { |topic| topics << topic }
        end
      end

      # Generate a page for each topic
      topics.each do |topic|
        site.pages << TopicPage.new(site, site.source, topic)
      end
    end
  end

  class TopicPage < Jekyll::Page
    def initialize(site, base, topic)
      @site = site
      @base = base
      @dir  = File.join('topics', topic.downcase.gsub(' ', '-'))
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'topic.html')
      self.data['topic'] = topic
      self.data['title'] = "Notes discussing the topic: \"#{topic}\""
      self.data['permalink'] = "/topics/#{topic.downcase.gsub(' ', '-')}/"
    end
  end
end
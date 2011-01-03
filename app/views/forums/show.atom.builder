# http://www.papodenerd.net/creating-atom-feeds-with-ruby-on-rails/
atom_feed do |feed|
  feed.title(@forum.name)

  feed.updated(@forum.topics.first.created_at) if @forum.topics

  @forum.topics.each do |topic|
    feed.entry([@forum,topic]) do |entry|
      entry.title(h(topic.title))
      entry.summary(truncate(strip_tags(topic.body), :length => 100))
      entry.content(topic.body, :type => 'html')
      entry.updated(topic.created_at)
      entry.author do |author|
        author.name(topic.user.name)
      end
    end
  end
end
# http://www.papodenerd.net/creating-atom-feeds-with-ruby-on-rails/
atom_feed do |feed|
  feed.title("#{@forum.name} : #{@topic.title}")

  feed.updated(@topic.posts.first.created_at) if @topic.posts

  @topic.posts.each do |post|
    feed.entry([@forum,@topic,post]) do |entry|
      entry.title(h("Post by #{post.user.name} on #{@topic.title}"))
      entry.summary(truncate(strip_tags(post.body), :length => 100))
      entry.content(post.body, :type => 'html')
      entry.updated(post.created_at)
      entry.author do |author|
        author.name(post.user.name)
      end
    end
  end
end
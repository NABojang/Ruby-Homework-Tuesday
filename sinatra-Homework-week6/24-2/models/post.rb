class Post

  attr_accessor :title, :author, :description

  def self.open_connection
    conn = PG.connect(dbname: "blog", user: "postgres", password: "Acad3my1")
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM boooks ORDER BY title"
    results = conn.exec(sql)
    posts = results.map do |tuple|
      self.hydrate(tuple)
    end
    return posts
  end

  def self.find author
    conn = self.open_connection
    sql = "SELECT * FROM boooks WHERE author= #{author}"
    result = conn.exec(sql)
    post = self.hydrate(result[0])
    return post
  end

  def self.hydrate(post_data)
    post = Post.new
    post.title = post_data['title']
    post.author = post_data['author']
    post.description = post_data['description']
    return post
  end

  def save
    conn = Post.open_connection
    if (!self.title)
    sql = "INSERT INTO boooks (title, author, description) VALUES ('#{self.title}', '#{self.author}', '#{self.description}')"
  else
    sql = "UPDATE boooks SET author = '#{self.author}', description = '#{self.description}' WHERE title = '#{self.title}'"
  end
    conn.exec(sql)
  end


  def destroy
    conn = Post.open_connection
    sql = "DELETE FROM boooks  WHERE title = #{title}"
    conn.exec(sql)
  end
end

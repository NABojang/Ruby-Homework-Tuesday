class Post

  attr_accessor :id, :title, :author, :description

  def self.open_connection
    conn = PG.connect(dbname: "blog", user: "postgres", password: "Acad3my1")
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM booklist ORDER BY title"
    results = conn.exec(sql)
    posts = results.map do |tuple|
      self.hydrate(tuple)
    end
    return posts
  end

  def self.find(id)
    conn = self.open_connection
    sql = "SELECT * FROM booklist WHERE id= #{id}"
    result = conn.exec(sql)
    post = self.hydrate(result[0])
    return post
  end

  def self.hydrate(post_data)
    post = Post.new
      post.id = post_data['id']
    post.title = post_data['title']
    post.author = post_data['author']
    post.description = post_data['description']
    return post
  end

  def save
    conn = Post.open_connection
    if (!self.id)
    sql = "INSERT INTO booklist (title, author, description) VALUES ('#{self.title}', '#{self.author}', '#{self.description}')"
  else
    sql = "UPDATE booklist SET title = '#{self.title}',author = '#{self.author}', description = '#{self.description}' WHERE id = '#{self.id}'"
  end
    conn.exec(sql)
  end


  def destroy
    conn = Post.open_connection
    sql = "DELETE FROM booklist  WHERE id= #{id}"
    conn.exec(sql)
  end
end

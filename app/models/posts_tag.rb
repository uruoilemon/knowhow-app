class PostsTag

  include ActiveModel::Model
  attr_accessor :title,:text,:answer,:user_id,:image, :name

  with_options presence: true do
    validates :title
    validates :text
    validates :name
  end

  def save
    post = Post.create(title: title,text: text,answer: answer,user_id: user_id,image: image)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    
    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end

end
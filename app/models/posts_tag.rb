class PostsTag

  include ActiveModel::Model
  attr_accessor :title,:text,:answer,:user_id,:image, :tag_names,:name,:post_id,:tag_id

  with_options presence: true do
    validates :title
    validates :text


  end

    # postがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
    delegate :persisted?, to: :post

 # initializeでFormオブジェクトの値を初期化し、更新の際はdefault_attributesを呼び出す設定
  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      # mapメソッドを使いsplit_tag_namesをtagの情報に変換
      tags = split_tag_names.map { |name| Tag.find_or_create_by!(name: name) }
      post.update!(title: title,text: text,answer: answer,image: image,tags: tags,user_id: user_id)

    end
  rescue ActiveRecord::RecordInvalid
    false
  end

    #  formを飛ばす場所を（#createか#updateか）を判別して、切り替えている
    def to_model
      post
    end

    private

    attr_reader :post
  
    def default_attributes
      {
        title: post.title,
        text: post.text,
        answer: post.answer,
        image: post.image,
        tag_names: post.tags.pluck(:name).join(',')
      }
    end
  
    def split_tag_names
      tag_names.to_s.split(',')
    end

  #   post = Post.create(title: title,text: text,answer: answer,user_id: user_id,image: image)
  #   tag = Tag.where(name: name).first_or_initialize
  #   tag.save
    
  #   PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  # end
  
end
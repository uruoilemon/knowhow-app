class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :post_tag_relations,dependent: :destroy
  has_many :tags, through: :post_tag_relations

  with_options presence: true do
    validates :title
    validates :text
  end

  def self.search(search)
    if search != ""
      Post.where('text LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

end

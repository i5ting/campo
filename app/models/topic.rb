class Topic < ActiveRecord::Base
  include Trashable

  belongs_to :user
  has_many :comments, as: 'commentable'
  has_many :posts
  has_one :main_post, -> { where post_number: 1 }, class_name: 'Post'

  accepts_nested_attributes_for :main_post

  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_i / 45000
  end

  def calculate_hot!
    update_attribute :hot, calculate_hot
  end
end

class Blog < ApplicationRecord
  enum status: {draft: 0,  published: 1}
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :comments, dependent: :destroy 
  belongs_to :topic

  validates_presence_of :title, :body, :topic_id

  # scope :published, ->{where(status: 'published').order('created_at DESC')}
  scope :recent , -> {order('status DESC, created_at DESC')}
end

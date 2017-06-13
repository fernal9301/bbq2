class Event < ApplicationRecord

  belongs_to :user

  has_many :comments, dependent: :delete_all
  has_many :subscriptions, dependent: :delete_all
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :delete_all

  validates :user, presence: true

  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true


  def visitors
    (subscribers +  [user]).uniq
  end
end

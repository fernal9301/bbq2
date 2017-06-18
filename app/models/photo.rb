class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validate :photo_exist

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> {where "id IS NOT NULL"}

  def photo_exist
    errors.add(:base, I18n.t('.errors.messages.photo_not_present')) if photo.blank?
  end
end

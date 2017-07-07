class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true,
                         format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
                         unless: 'user.present?'
  validates :user, uniqueness: { scope: :event_id }, if: 'user.present?'
  validates :user_email, uniqueness: { scope: :event_id }, unless: 'user.present?'

  validate :email_exist, on: :create, unless: 'user.present?'
  validate :author?, on: :create

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  def author?
    errors.add(:base, :must_not_be_author) if user == event.user
  end

  def email_exist
    errors.add(:base, I18n.t('.errors.messages.already_exist')) if event.subscribers.where(email: user_email).exists?
  end
end

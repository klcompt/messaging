class Message < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true


  scope :active, where(rescended: false)
end

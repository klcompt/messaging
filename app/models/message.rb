class Message < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :message_logs

  scope :active, -> { where(rescinded: false) }

  def as_json(*args)
    super.merge( { 'call_count' => message_logs.count } )
  end
end

class Point < ActiveRecord::Base
  belongs_to :globe

  validates :state, presence: true
  validates :country, presence: true
  validates :magnitude, presence: true, numericality: true

  geocoded_by :address
  after_validation :geocode
  before_save -> { [city, state, country].each { |atr| atr.capitalize!} }

  def address
    [city, state, country].join(', ')
  end
end

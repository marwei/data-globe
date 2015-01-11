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

  def self.get_json(points)
    max_mag = 0

    points.each do |point|
      max_mag = point.magnitude if point.magnitude > max_mag
    end

    data = points.each_with_object([]) do |point, memo|
      memo.push point.latitude
      memo.push point.longitude
      memo.push (point.magnitude / max_mag)
    end
    data.as_json
  end
end

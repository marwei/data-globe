class Point < ActiveRecord::Base
  require 'csv'
  belongs_to :globe

  validates :state, presence: true
  validates :country, presence: true
  validates :magnitude, presence: true, numericality: true

  before_save -> { [city, state, country].each { |atr| atr.capitalize!} }

  def self.add_or_build(params)
    lat, lng = self.get_coordinates_for(params[:city], params[:state], params[:country])
    point = self.fetch_point_record_for lat, lng
    if point
      point.magnitude += params[:magnitude].to_f
    else 
      point = self.new(city: params[:city],
                      state: params[:state],
                      country: params[:country],
                      magnitude: params[:magnitude],
                      latitude: lat,
                      longitude: lng)
    end
    point
  end

  def self.import(file)
    last = self.last
    found_last = false

    CSV.foreach(file.path, headers: true, encoding: 'windows-1251:utf-8') do |row|
      data = row.to_hash

      unless last && found_last
        if (data["city"].downcase == last.city.downcase && 
          data["state"].downcase == last.state.downcase && 
          data["country"].downcase == last.country.downcase)
          found_last = true
        else
          p data["city"] + data["state"] + data["country"]
          next
        end
      end
      begin
        lat, lng = self.get_coordinates_for(data["city"], data["state"], data["country"])
        point = self.fetch_point_record_for lat, lng
        if point
          point.magnitude += data["count"].to_f
          point.save!
        else 
          point = self.create(city: data["city"],
                          state: data["state"],
                          country: data["country"],
                          magnitude: data["count"],
                          latitude: lat,
                          longitude: lng)
        end
      rescue
        sleep 1
        retry
      end
    end
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

  private
    def self.get_coordinates_for(city, state, country)
      location = Geocoder.search "#{city}, #{state}, #{country}"
      location[0].coordinates.map! { |cor| cor.round(3) }
    end

    def self.fetch_point_record_for(lat, lng)
      self.where(latitude: lat, longitude: lng).first
    end
end

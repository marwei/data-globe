class Globe < ActiveRecord::Base
  has_many :points

  validates :name, presence: true

end

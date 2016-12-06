class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end

  def show_first_photo(size)
    if self.photos.length == 0
      'http://cdnassets.hw.net/dims4/GG/c900fb2/2147483647/resize/876x%3E/quality/90/?url=http%3A%2F%2Fcdnassets.hw.net%2Fd9%2F06%2Feccce1b84b3fa086cb40137aecf1%2F2016-04-20-the-met-psychobarn-1.jpg'
    else
      self.photos[0].image.url(size)
    end
  end
end

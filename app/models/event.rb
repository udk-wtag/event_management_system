class Event < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :image_file_name, format: { with: /\w+\.(jpg|png)\z/i, message: 'must be a JPG or PNG image' }

end

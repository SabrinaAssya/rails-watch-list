class Movie < ApplicationRecord
  has_many :bookmarks
  validates :title, uniqueness: true
  validates :title, presence: true
  validates :overview, presence: true
end

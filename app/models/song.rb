class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, presence: true , if: :released
    validates :title, uniqueness: {scope: [:artist_name, :release_year]}
    validates :release_year, numericality: { less_than_or_equal_to: Date.current.year}, if: :released
end

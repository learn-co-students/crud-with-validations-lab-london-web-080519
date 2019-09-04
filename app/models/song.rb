class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: {scope: [:artist_name, :release_year]}
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, presence: true, if: :released, numericality: {less_than: Date.today.year}
    validates :artist_name, presence: true
    validates :genre, presence: true

    def full_details
        if released
            self.title + " by " + self.artist_name + " released in " + self.release_year
        else
            self.title + " by " + self.artist_name
        end
    end
end

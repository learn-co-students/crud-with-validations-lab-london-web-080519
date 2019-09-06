class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validate :unique_titles
    validates :released, inclusion: {in: [true, false]}
    validate :release_year_for_released
    validate :no_future_released


    def unique_titles
        if self.is_repeat?
            errors.add(:title, "cannot be repeated by the same artist in the same year")
        end
    end

    def is_repeat?
        Song.all.find{|song| song.title == self.title && song.artist_name == self.artist_name && self.release_year == song.release_year}
    end

    def release_year_for_released
        if self.released == true && !self.release_year
            errors.add(:release_year, "must be present if song is released.")
        end
    end

    def no_future_released
        if self.release_year && self.release_year > Time.now.year
            errors.add(:release_year, "cannot be in the future")
        end
    end



end
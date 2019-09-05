class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validate :no_repeat_title
    validates :released, inclusion: {in: [true, false]}
    validate :required_year_if_released
    validate :release_year_in_future


    def no_repeat_title
        if self.find_repeats
            errors.add(:title, "cannot be repeated by the same artist in the same year")
        end
    end

    def find_repeats
        Song.all.find{|song| song.title == self.title && song.artist_name == self.artist_name && self.release_year == song.release_year}
    end

    def required_year_if_released
        if self.released == true && !self.release_year
            errors.add(:release_year, "must be present if song is released.")
        end
    end

    def release_year_in_future
        if self.release_year && self.release_year > Time.now.year
            errors.add(:release_year, "cannot be in the future")
        end
    end
    


end

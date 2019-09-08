class Song < ApplicationRecord
    validates :title, presence: true, uniqueness:  {scope: [:artist_name, :release_year]}
    validates :released, inclusion: {in: [true, false]}
    validates :artist_name, presence: true
    validates :release_year, presence: true, if: :released, numericality: {less_than: Date.today.year}
    # title Cannot be repeated by the same artist in the same year
    # release_year Optional if released is false
    # release_year Must be less than or equal to the current year

    def current_year
        Time.current.year
    end
end

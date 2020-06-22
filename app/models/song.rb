class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :artist_name, presence: true
    validates :released, inclusion: { in: [true, false] }
    #validate :release_year_present_if_released
    # validate :release_year_must_be_before_today
  
  #  validates :release_year #optional if released == false
    #must not be blank if released == true
    # <= current year

    with_options if: :released? do |release|
      release.validates :release_year, presence: true
      release.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
    end
 
    def released?
      released == true
    end

end

class Breed < ApplicationRecord
    has_many :listings, dependent: :destroy
end

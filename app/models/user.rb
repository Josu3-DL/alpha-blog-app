class User < ApplicationRecord
    before_save {self.email = email.downcase}
    has_many :articles

    validates :username, presence: true,
                         uniqueness: {case_sensitive: false},
                         length: {minimum:3, maximum:25}
    validates :email, presence: true,
                      uniqueness: {case_sensitive: false},
                      length: {maximum:105},
                      format: { with:  /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
end
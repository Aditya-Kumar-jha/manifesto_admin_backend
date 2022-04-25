class User < ApplicationRecord
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
    #validations :password, 
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end

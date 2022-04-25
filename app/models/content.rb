class Content < ApplicationRecord
    has_one_attached :small_img
    has_one_attached :big_img

    validates :heading, presence: true
    validates :desc, presence: true
    validates :small_img, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
    validates :big_img, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

    
end

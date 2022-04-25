class Manifesto < ApplicationRecord
    has_one_attached :pdf

    validates :pdf, attached: true, content_type: { in: 'application/pdf', message: 'is not a PDF' }
end

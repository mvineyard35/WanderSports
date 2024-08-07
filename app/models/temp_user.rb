class TempUser < ApplicationRecord
  has_one :cart, dependent: :destroy
end

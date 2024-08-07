class Waiver < ApplicationRecord
  validates :first_name, :last_name, :birth_date, :email, :signature, presence: true
  validates :email, uniqueness: false
  validates :authorized, acceptance: { message: "must be authorized to proceed" }
end

class Cat < ActiveRecord::Base

  COLORS = [
    "tabby", "tortoiseshell", "harlequin", "tuxedo", "smoke", "black"
  ]

  validates :name, :presence => true
  validates :sex, inclusion: ["M", "F"]
  validates :color, inclusion: COLORS

  has_many :cat_rental_requests, dependent: :destroy

  def age
    Date.today.year - birth_date.year
  end

end

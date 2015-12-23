class Cat < ActiveRecord::Base

  COLORS = [
    "tabby", "tortoiseshell", "harlequin", "tuxedo", "smoke", "black"
  ]

  validates :name, :user_id, :sex, :color, presence: true
  validates :sex, inclusion: ["M", "F"]
  validates :color, inclusion: COLORS

  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :user_id
  )
  has_many :cat_rental_requests, dependent: :destroy

  def age
    Date.today.year - birth_date.year
  end

end

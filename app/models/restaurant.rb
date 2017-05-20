# == Schema Information
#
# Table name: restaurants
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  location_id :integer          not null
#  rating      :integer
#  price       :string           not null
#  hours       :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Restaurant < ApplicationRecord
  validates :name, :location_id, :price, :hours, presence: true
  # validates :hours, numericality: true, length: {is: 8}

  belongs_to :location
  has_many :reviews
  has_many :reservations
  has_many :favorites

  def open_time
    time = self.hours[0..3].to_i
    if time > 1200
      time -= 1200
      time.to_s + " PM"
    elsif time < 100
      time += 1200
      time.to_s + " AM"
    else
      time.to_s + " AM"
    end
  end

  def close_time
    time = self.hours[4..7].to_i
    if time > 1200
      time -= 1200
      time.to_s + " PM"
    elsif time < 100
      time += 1200
      time.to_s + " AM"
    else
      time.to_s + " AM"
    end
  end
  
end

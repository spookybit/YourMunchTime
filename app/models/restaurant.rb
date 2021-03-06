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

  def convertime(string)
    time = string.to_i

    if time == 2400
      time -= 1200
      time = time.to_s
      time[0..1] + ":" + time[2..3] + " AM"
    elsif time == 1200
      time = time.to_s
      time[0..1] + ":" + time[2..3] + " PM"
    elsif time > 1200
      time -= 1200
      time = time.to_s
      "0" + time[0] + ":" + time[1..2] + " PM"
    elsif time < 100
      time += 1200
      time = time.to_s
      time[0..1] + ":" + time[2..3] + " AM"
    elsif time < 1200 && time >= 1000
      time = time.to_s
      time[0..1] + ":" + time[2..3] + " AM"
    else
      time = time.to_s
      "0" + time[0] + ":" + time[1..2] + " AM"
    end

  end

  def open_time
    time = self.hours[0..3].to_i
    self.convertime(time)
  end

  def close_time
    time = self.hours[4..7].to_i
    self.convertime(time)
  end

  def moneys
    dollars = ""
    self.price.times do
      dollars += "$"
    end
    dollars
  end

  def average_rating
    rating = self.reviews.pluck(:rating)
    total = 0
    if !rating.empty?
      rating.each { |rate| total += rate}
      total.fdiv(rating.count).round(2)
    else
      return "no ratings"
    end
  end



end

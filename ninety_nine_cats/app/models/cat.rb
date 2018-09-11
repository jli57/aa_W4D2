require 'date'
require 'active_support/core_ext/date'
# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord

  validates :birth_date, :color, :name, :sex, :description, presence: true

  def age
    ((Date.today- birth_date).to_f/365).to_i
  end

end

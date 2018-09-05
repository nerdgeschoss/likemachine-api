# == Schema Information
#
# Table name: users
#
#  id             :uuid             not null, primary key
#  email          :string           not null
#  first_name     :string           not null
#  last_name      :string           not null
#  facebook_token :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :sessions, dependent: :destroy

  class << self
    def authenticate_facebook(token)
      response = HTTParty.get "https://graph.facebook.com/me", query: { fields: 'id,first_name,last_name,email', access_token: token }
      raise "facebook request error: #{response.code}" unless response.code == 200
      data = OpenStruct.new JSON.parse(response.body).symbolize_keys
      user = User.find_or_initialize_by facebook_token: data.id
      user.assign_attributes email: data.email, first_name: data.first_name, last_name: data.last_name
      user.save!
      user
    end
  end
end

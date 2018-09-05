# == Schema Information
#
# Table name: likes
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  link_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :link, touch: true

  validates :link_id, uniqueness: { scope: :user_id }
end

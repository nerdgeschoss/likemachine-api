# == Schema Information
#
# Table name: links
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :string
#  image_url   :string
#  url         :string           not null
#  author_id   :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Link < ApplicationRecord
  belongs_to :author, class_name: "User"
  
  has_many :likes, dependent: :destroy

  after_create_commit { ScrapeUrlJob.perform_later self }
  after_commit { Link.connection.execute "NOTIFY links, '#{id}'" } 

  class << self
    def on_change
      Link.connection.execute "LISTEN links"
      loop do
        success = Link.connection.raw_connection.wait_for_notify(30) do |event, pid, link_id|
          yield Link.find(link_id)
        end
        yield unless success
      end
    ensure
      Link.connection.execute "UNLISTEN links"
    end
  end
end

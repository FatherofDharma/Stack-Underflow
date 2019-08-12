class Post < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id
  belongs_to :topic, :foreign_key => :topic_id
end

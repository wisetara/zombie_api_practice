class Episode < ActiveRecord::Base
  validates :title, length: { minimum: 10 }
end

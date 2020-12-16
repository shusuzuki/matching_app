class Associate < ApplicationRecord
  belongs_to :follower, class_name: "Company"
  belongs_to :followed, class_name: "User"
end

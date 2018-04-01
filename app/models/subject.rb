class Subject < ApplicationRecord
  has_many :tasks
  belongs_to :user, dependent: :destroy
end

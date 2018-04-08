class Subject < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user, dependent: :destroy
  
  validates :name, presence: true

end

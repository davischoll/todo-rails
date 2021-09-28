class Task < ApplicationRecord
  validates_presence_of :description
  validates :done, inclusion: [true, false]
end

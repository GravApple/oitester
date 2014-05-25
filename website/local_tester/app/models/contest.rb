class Contest < ActiveRecord::Base
  has_and_belongs_to_many :problems
  has_many :submissions, dependent: :destroy
end

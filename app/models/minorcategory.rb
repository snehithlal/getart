class Minorcategory < ApplicationRecord
  belongs_to :subcategory, inverse_of: :minorcategories

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: [ :subcategory_id] }
end

class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :minorcategories

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :category_id }
  accepts_nested_attributes_for :minorcategories, reject_if: :all_blank, allow_destroy: true

  
end

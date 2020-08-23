class Category < ApplicationRecord
  has_many :subcategories
  has_many :minorcategories, through: :subcategories
  accepts_nested_attributes_for :subcategories
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
end

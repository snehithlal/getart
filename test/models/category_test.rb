require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "should not save category without name" do
    category = Category.new
    assert_not category.save, "saved without name"
  end

  test "should save category with name" do
    category = categories(:three)
    assert category.save, "not saved with name"
  end

  test "should save category without duplicate name" do
    category1 = categories(:one)
    category2 =categories(:one)
    assert_not category2.save, "saved duplicates"
  end

  test "should not save with case sensitive" do
    category1 = categories(:one)
    category1.save
    category2 = categories(:two)
    assert_not category2.save, "saved  duplicate with case"
  end
  
end

require 'test_helper'

class SubcategoryTest < ActiveSupport::TestCase

  test "should not save subcategory without category" do
    sub_category = Subcategory.new
    assert_not sub_category.save, "saved without name and category"
  end

  test "should not save subcategory without name" do
    sub_category = subcategories(:three)
    assert_not sub_category.save, "saved without name"
  end

  test "should save subcategory without duplicate name and same category" do
    sub_category1 = subcategories(:two)
    sub_category1.save
    sub_category2 = subcategories(:four)
    assert_not sub_category2.save, "saved duplicate"
  end

  test "should not save subcategory with name with case sensitive " do
    sub_category1 = subcategories(:four)
    sub_category1.save
    sub_category2 = subcategories(:five)
    assert_not sub_category2.save, "case sensitive saved"
  end

  test "should save sub category with same name and different category" do
    sub_category1 = subcategories(:six)
    sub_category1.save
    sub_category2 = subcategories(:seven)
    assert sub_category2.save, sub_category2.errors.full_messages
  end

end

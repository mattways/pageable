require 'test_helper'

class CollectionEmptyTest < ActiveSupport::TestCase

  setup :create_records

  test "should have 1 page" do
    assert_equal @collection.total_pages, 1
  end

  test "current page should be 1" do
    assert_equal @collection.current_page, 1
  end

  test "first page should be 1" do
    assert_equal @collection.first_page, 1
  end

  test "should have no previous page" do
    assert_nil @collection.previous_page
  end

  test "should have no next page" do
    assert_nil @collection.next_page
  end
  
  test "last page should be 1" do
    assert_equal @collection.last_page, 1
  end

  test "should not be out of bounds" do
    assert !@collection.out_of_bounds?
  end

  protected

  def create_records
    @collection = Model.page(1).per(2)
  end

end

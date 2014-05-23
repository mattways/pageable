require 'test_helper'

class RelationEmptyTest < ActiveSupport::TestCase
 
  test "should have 1 page" do
    assert_equal 1, relation.total_pages
  end

  test "current page should be 1" do
    assert_equal 1, relation.current_page
  end

  test "first page should be 1" do
    assert_equal 1, relation.first_page
  end

  test "should have no previous page" do
    assert_nil relation.previous_page
  end

  test "should have no next page" do
    assert_nil relation.next_page
  end
 
  test "last page should be 1" do
    assert_equal 1, relation.last_page
  end

  test "should not be out of bounds" do
    assert !relation.out_of_bounds?
  end

  protected

  def relation
    @relation ||= Model.page(1, length: 2)
  end

end

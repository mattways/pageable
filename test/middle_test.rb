require 'test_helper'

class RelationMiddleTest < ActiveSupport::TestCase

  setup do
    10.times.each { |index| Model.create name: index }
  end

  test "should have 5 pages" do
    assert_equal 5, relation.total_pages
  end

  test "current page should be 3" do
    assert_equal 3, relation.current_page
  end

  test "first page should be 1" do
    assert_equal 1, relation.first_page
  end

  test "should have previous page 2" do
    assert_equal 2, relation.previous_page
  end

  test "should have next page 4" do
    assert_equal 4, relation.next_page
  end
  
  test "last page shuold be 5" do
    assert_equal 5, relation.last_page
  end

  test "should not be out of bounds" do
    assert !relation.out_of_bounds?
  end

  protected

  def relation
    @relation ||= Model.page(3, length: 2)
  end

end

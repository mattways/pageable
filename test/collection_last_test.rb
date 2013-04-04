require 'test_helper'

class CollectionLastTest < ActiveSupport::TestCase

  setup :create_records

  test "should have 5 pages" do
    assert_equal @collection.total_pages, 5
  end

  test "current page should be 5" do
    assert_equal @collection.current_page, 5
  end

  test "first page should be 1" do
    assert_equal @collection.first_page, 1
  end

  test "should have previous page 4" do
    assert_equal @collection.previous_page, 4
  end

  test "should not have next page" do
    assert_nil @collection.next_page
  end
  
  test "last page shuold be 5" do
    assert_equal @collection.last_page, 5
  end

  test "should not be out of bounds" do
    assert !@collection.out_of_bounds?
  end

  protected

  def create_records
    10.times.each { |id| Model.create :title => "Record #{id}" }
    @collection = Model.page(5).per(2)
  end

end

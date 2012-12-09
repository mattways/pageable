require 'test_helper'

class ActionViewLastTest < ActionView::TestCase
  include RailsPagination::ActionView::BaseMethods

  setup :create_pager

  test "should have multiple pages" do
    assert @pager.has_multiple_pages?
  end
  
  test "should have first page" do
    assert @pager.has_first_page?
  end

  test "should have previous page" do
    assert @pager.has_previous_page?
  end

  test "should not have next page" do
    assert !@pager.has_next_page?
  end

  test "should not have last page" do
    assert !@pager.has_last_page?
  end

  test "should have less pages" do
    assert @pager.navigation.has_less_pages?
  end

  test "should start at 3 and end at 5" do
    assert_equal @pager.navigation.pages, 3..5
  end

  test "shuld not have more pages" do
    assert !@pager.navigation.has_more_pages?
  end

  protected

  def create_pager
    10.times.each { |id| Model.create :title => "Record #{id}" }
    @pager = paginate(Model.page(5).per(2), :navigation => 3, :parameter => :page)
  end

end

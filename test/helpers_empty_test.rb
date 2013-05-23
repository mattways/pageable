require 'test_helper'

class HelpersEmptyTest < ActionView::TestCase
  include RailsPagination::ActionView::Base
  
  setup do
    @pager = paginate(Model.page(1).per(2), navigation: 3, parameter: :page)
  end
 
  test "should not have multiple pages" do
    assert !@pager.has_multiple_pages?
  end
  
  test "should not have first page" do
    assert !@pager.has_first_page?
  end
  
  test "should not have previous page" do
    assert !@pager.has_previous_page?
  end

  test "should not have next page" do
    assert !@pager.has_next_page?
  end

  test "should not have last page" do
    assert !@pager.has_last_page?
  end

  test "should not have less pages" do
    assert !@pager.navigation.has_less_pages?
  end

  test "should start at 1 and end at 1" do
    assert_equal @pager.navigation.pages, 1..1
  end

  test "shuld not have more pages" do
    assert !@pager.navigation.has_more_pages?
  end

end

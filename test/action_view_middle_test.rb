require 'test_helper'

class ActionViewMiddleTest < ActionView::TestCase
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

  test "should have next page" do
    assert @pager.has_next_page?
  end

  test "should have last page" do
    assert @pager.has_last_page?
  end

  protected

  def create_pager
    10.times.each { |id| Model.create :title => "Record #{id}" }
    @pager = paginate(Model.page(3).per(2), :navigate => 3, :parameter => :page)
  end

end

require 'test_helper'

class FirstTest < ActiveSupport::TestCase

  setup do
    10.times.each { |index| Record.create }
  end

  test 'total pages' do
    assert_equal 5, relation.total_pages
  end

  test 'current page' do
    assert_equal 1, relation.current_page
  end

  test 'first page' do
    assert_equal 1, relation.first_page
  end

  test 'previous page' do
    assert_nil relation.previous_page
  end

  test 'next page' do
    assert_equal 2, relation.next_page
  end
  
  test 'last page' do
    assert_equal 5, relation.last_page
  end

  test 'out of bounds' do
    assert !relation.out_of_bounds?
  end

  protected

  def relation
    @relation ||= Record.page(1, length: 2)
  end

end

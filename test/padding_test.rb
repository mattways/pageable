require 'test_helper'

class PaddingTest < ActiveSupport::TestCase
 
  test 'padding not alter total pages' do
    19.times.each { |index| Record.create }

    relation = Record.page(1, length: 15, padding: 4)
    assert_equal 15, relation.size
    assert_equal 1, relation.total_pages
 
    relation = Record.page(2, length: 15, padding: 4)
    assert_equal 0, relation.size
    assert_equal 1, relation.total_pages

    relation = Record.page(3, length: 15, padding: 4)
    assert_equal 0, relation.size
    assert_equal 1, relation.total_pages
  end

end

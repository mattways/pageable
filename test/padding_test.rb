require 'test_helper'

class PaddingTest < ActiveSupport::TestCase
 
  test "negative padding should have 1 page" do
    15.times.each { |index| Model.create name: index }

    relation = Model.page(1, length: 15, padding: 4)
    assert_equal 11, relation.size
    assert_equal 1, relation.total_pages
 
    relation = Model.page(2, length: 15, padding: 4)
    assert_equal 0, relation.size
    assert_equal 1, relation.total_pages

    relation = Model.page(3, length: 15, padding: 4)
    assert_equal 0, relation.size
    assert_equal 1, relation.total_pages
  end

  test "negative padding should have 2 pages" do
    30.times.each { |index| Model.create name: index }
 
    relation = Model.page(1, length: 15, padding: 4)
    assert_equal 11, relation.size
    assert_equal 2, relation.total_pages

    relation = Model.page(2, length: 15, padding: 4)
    assert_equal 15, relation.size
    assert_equal 2, relation.total_pages
 
    relation = Model.page(3, length: 15, padding: 4)
    assert_equal 0, relation.size
    assert_equal 2, relation.total_pages
  end

  test "negative padding should have 3 pages" do
    45.times.each { |index| Model.create name: index }
 
    relation = Model.page(1, length: 15, padding: 4)
    assert_equal 11, relation.size
    assert_equal 3, relation.total_pages
 
    relation = Model.page(2, length: 15, padding: 4)
    assert_equal 15, relation.size
    assert_equal 3, relation.total_pages
 
    relation = Model.page(3, length: 15, padding: 4)
    assert_equal 15, relation.size
    assert_equal 3, relation.total_pages
  end

end

require 'test_helper'

class RelationTest < ActiveSupport::TestCase

  test 'empty' do
    products = Product.page(1, length: 2)

    assert_equal 1, products.total_pages
    assert_equal 1, products.current_page
    assert_equal 1, products.first_page
    assert_nil products.previous_page
    assert_nil products.next_page
    assert_equal 1, products.last_page
    assert_not products.out_of_bounds?
  end

  test 'first' do
    10.times { Product.create }
    products = Product.page(1, length: 2)

    assert_equal 5, products.total_pages
    assert_equal 1, products.current_page
    assert_equal 1, products.first_page
    assert_nil products.previous_page
    assert_equal 2, products.next_page
    assert_equal 5, products.last_page
    assert_not products.out_of_bounds?
  end

  test 'middle' do
    10.times { Product.create }
    products = Product.page(3, length: 2)

    assert_equal 5, products.total_pages
    assert_equal 3, products.current_page
    assert_equal 1, products.first_page
    assert_equal 2, products.previous_page
    assert_equal 4, products.next_page
    assert_equal 5, products.last_page
    assert_not products.out_of_bounds?
  end

  test 'last' do
    10.times { Product.create }
    products = Product.page(5, length: 2)

    assert_equal 5, products.total_pages
    assert_equal 5, products.current_page
    assert_equal 1, products.first_page
    assert_equal 4, products.previous_page
    assert_nil products.next_page
    assert_equal 5, products.last_page
    assert_not products.out_of_bounds?
  end

  test 'out' do
    10.times { Product.create }
    products = Product.page(6, length: 2)

    assert_equal 5, products.total_pages
    assert_equal 6, products.current_page
    assert_equal 1, products.first_page
    assert_equal 5, products.previous_page
    assert_nil products.next_page
    assert_equal 5, products.last_page
    assert products.out_of_bounds?
  end

  test 'padding' do
    19.times { Product.create }

    products = Product.page(1, length: 15, padding: 4)
    assert_equal 15, products.size
    assert_equal 1, products.total_pages

    products = Product.page(2, length: 15, padding: 4)
    assert_equal 0, products.size
    assert_equal 1, products.total_pages

    products = Product.page(3, length: 15, padding: 4)
    assert_equal 0, products.size
    assert_equal 1, products.total_pages
  end

end

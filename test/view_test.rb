require 'test_helper'

class ViewTest < ActionDispatch::IntegrationTest

  setup do
    10.times { Product.create }
  end

  test 'html' do
    get '/'
    assert_select 'li.first', false
    assert_select 'li.previous', false
    assert_select 'li.page.current a[href=?]', '/', text: /1/, count: 1
    assert_select 'li.page a[href=?]', '/?page=2', text: /2/, count: 1
    assert_select 'li.page a[href=?]', '/?page=3', text: /3/, count: 1
    assert_select 'li.page a[href=?]', '/?page=4', text: /4/, count: 1
    assert_select 'li.page a[href=?]', '/?page=5', text: /5/, count: 1
    assert_select 'li.next a[href=?]', '/?page=2', text: /Next/, count: 1
    assert_select 'li.last a[href=?]', '/?page=10', text: /Last/, count: 1
    assert_select 'li.ellipsis', text: /…/, count: 1

    get '/?page=5'
    assert_select 'li.first a[href=?]', '/', text: /First/, count: 1
    assert_select 'li.previous a[href=?]', '/?page=4', text: /Previous/, count: 1
    assert_select 'li.page a[href=?]', '/?page=3', text: /3/, count: 1
    assert_select 'li.page a[href=?]', '/?page=4', text: /4/, count: 1
    assert_select 'li.page.current a[href=?]', '/?page=5', text: /5/, count: 1
    assert_select 'li.page a[href=?]', '/?page=6', text: /6/, count: 1
    assert_select 'li.page a[href=?]', '/?page=7', text: /7/, count: 1
    assert_select 'li.next a[href=?]', '/?page=6', text: /Next/, count: 1
    assert_select 'li.last a[href=?]', '/?page=10', text: /Last/, count: 1
    assert_select 'li.ellipsis', text: /…/, count: 2

    get '/?page=10'
    assert_select 'li.first a[href=?]', '/', text: /First/, count: 1
    assert_select 'li.previous a[href=?]', '/?page=9', text: /Previous/, count: 1
    assert_select 'li.page a[href=?]', '/?page=6', text: /6/, count: 1
    assert_select 'li.page a[href=?]', '/?page=7', text: /7/, count: 1
    assert_select 'li.page a[href=?]', '/?page=8', text: /8/, count: 1
    assert_select 'li.page a[href=?]', '/?page=9', text: /9/, count: 1
    assert_select 'li.page.current a[href=?]', '/?page=10', text: /10/, count: 1
    assert_select 'li.next', false
    assert_select 'li.last', false
    assert_select 'li.ellipsis', text: /…/, count: 1
  end

end

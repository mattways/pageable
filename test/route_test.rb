require 'test_helper'

class RouteTest < ActionDispatch::IntegrationTest

  test 'query param' do
    Rails.application.routes.draw do
      get '/' => 'pages#index'
    end

    10.times.each { Record.create }
    get '/'
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/?page=1"]:contains(1)'
    else
      assert_select 'li.current a[href="/?page=1"]', '1'
    end
    get '/?page=2'
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/?page=2"]:contains(2)'
    else
      assert_select 'li.current a[href="/?page=2"]', '2'
    end
    get '/?dummy='
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/?dummy=&amp;page=1"]:contains(1)'
    else
      assert_select 'li.current a[href="/?dummy=&amp;page=1"]', '1'
    end
    get '/?dummy=&page=2'
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/?dummy=&amp;page=2"]:contains(2)'
    else
      assert_select 'li.current a[href="/?dummy=&amp;page=2"]', '2'
    end
  end

  test 'route param' do
    Rails.application.routes.draw do
      get '(:page)' => 'pages#index'
    end

    10.times.each { Record.create }
    get '/'
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/1"]:contains(1)'
    else
      assert_select 'li.current a[href="/1"]', '1'
    end
    get '/2'
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/2"]:contains(2)'
    else
      assert_select 'li.current a[href="/2"]', '2'
    end
    get '/?dummy='
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/1?dummy="]:contains(1)'
    else
      assert_select 'li.current a[href="/1?dummy="]', '1'
    end
    get '/2?dummy='
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
      assert_select 'li.current a[href="/2?dummy="]:contains(2)'
    else
      assert_select 'li.current a[href="/2?dummy="]', '2'
    end
  end

end

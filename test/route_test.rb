require 'test_helper'

class RouteTest < ActionDispatch::IntegrationTest

  test 'query page param' do
    Rails.application.routes.draw do
      get '/' => 'pages#index'
    end

    10.times.each { Record.create }
    get '/'
    assert_select 'li.current a[href=/?page=1]', '1'
    get '/?page=2'
    assert_select 'li.current a[href=/?page=2]', '2'
  end

  test 'route page param' do
    Rails.application.routes.draw do
      get '(:page)' => 'pages#index'
    end

    10.times.each { Record.create }
    get '/'
    assert_select 'li.current a[href=/1]', '1'
    get '/2'
    assert_select 'li.current a[href=/2]', '2'
  end

end

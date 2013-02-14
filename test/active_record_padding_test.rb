require 'test_helper'

class ActiveRecordPaddingTest < ActiveSupport::TestCase
  
  test "negative padding should have 1 page" do
    11.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(-4)
    assert_equal @collection.total_pages, 1
    
    @collection = Model.page(2).per(15).pad(-4)
    assert_equal @collection.total_pages, 1
    
    @collection = Model.page(3).per(15).pad(-4)
    assert_equal @collection.total_pages, 1
  end

  test "negative padding should have 2 pages" do
    12.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(-4)
    assert_equal @collection.total_pages, 2
    
    @collection = Model.page(2).per(15).pad(-4)
    assert_equal @collection.total_pages, 2
    
    @collection = Model.page(3).per(15).pad(-4)
    assert_equal @collection.total_pages, 2
  end
  
  test "negative padding should have 3 pages" do
    27.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(-4)
    assert_equal @collection.total_pages, 3
    
    @collection = Model.page(2).per(15).pad(-4)
    assert_equal @collection.total_pages, 3
    
    @collection = Model.page(3).per(15).pad(-4)
    assert_equal @collection.total_pages, 3
  end
  
  test "positive padding should have 1 page" do
    15.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(4)
    assert_equal @collection.total_pages, 1
    
    @collection = Model.page(2).per(15).pad(4)
    assert_equal @collection.total_pages, 1
    
    @collection = Model.page(3).per(15).pad(4)
    assert_equal @collection.total_pages, 1
  end

  test "positive padding should have 2 pages" do
    16.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(4)
    assert_equal @collection.total_pages, 2
    
    @collection = Model.page(2).per(15).pad(4)
    assert_equal @collection.total_pages, 2
    
    @collection = Model.page(3).per(15).pad(4)
    assert_equal @collection.total_pages, 2
  end
  
  test "positive padding should have 3 pages" do
    31.times.each { |id| Model.create :title => "Record #{id}" }
    
    @collection = Model.page(1).per(15).pad(4)
    assert_equal @collection.total_pages, 3
    
    @collection = Model.page(2).per(15).pad(4)
    assert_equal @collection.total_pages, 3
    
    @collection = Model.page(3).per(15).pad(4)
    assert_equal @collection.total_pages, 3
  end

end
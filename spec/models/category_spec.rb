
require 'spec_helper'

describe Category do
  
  describe 'self.list' do
    before :each do
      Category.all.each { |c| c.remove }
      @c1 = Category.create :title => 'top 1', :slug => 'top1'
      @c2 = Category.create :title => 'L 1',   :slug => 'top1-L1', :category_id => @c1.id
      @c3 = Category.create :title => 'top 2', :slug => 'top2'
    end
    
    it 'does' do
      expected = [['',nil]]
      expected.push [ 'top 1', @c1.id ]
      expected.push [ 'top 1 - L 1', @c2.id ]
      expected.push [ 'top 2', @c3.id ]

      result = Category.list
      result.should eql expected
    end
  end
  
end


require 'spec_helper'
require_relative '../../lib/categories_tasks'

describe CategoriesTasks do

  before :each do
    @task_runner = CategoriesTasks.new
    @parent_category = Category.create :title => 'Parent Category'
    @category = Category.create :title => 'Category Title'
    @category.category = @parent_category
    @category.save
  end
  
  it 'is sane' do
    CategoriesTasks.sanity.should eql true
  end
  
  it "#get_slug" do
    CategoriesTasks.publicize_methods do    
      result = @task_runner.get_slug( @category )
      result.should eql 'parent-category-category-title'
    end
  end

end


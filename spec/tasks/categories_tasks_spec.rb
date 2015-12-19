
require 'spec_helper'
require_relative '../../lib/categories_tasks'

describe 'categories tasks' do

  it 'sane' do
    CategoriesTasks.sanity.should eql true
  end
  
end

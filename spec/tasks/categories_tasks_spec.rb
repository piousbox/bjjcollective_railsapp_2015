
require 'spec_helper'
require_relative '../../lib/categories_tasks'

describe 'categories tasks' do

  it 'sane' do
    CategoriesTasks.sanity.should eql true
  end

=begin
  it  '#normalize_kind_and_path' do
    raise 'not implemented'
  end

  it '#init_technique' do
    raise 'not implemented'
  end

  it '#assign_kind' do
    raise 'not implemented'
  end
=end

end

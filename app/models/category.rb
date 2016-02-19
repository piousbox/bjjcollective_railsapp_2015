
class Symbol
  def camelize
    'Category'
  end
end

def puts! args, label=''
  puts "+++ +++ #{label}"
  puts args.inspect
end

class Category

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title,         :type => String
  index :title => 1

  field :slug,          :type => String, :default => ""
  validates_uniqueness_of :slug
  index :slug => 1
  
  field :short_slug,    :type => String, :default => ""
  index :short_slug => 1
  
  field :path,          :type => String, :default => ""
  validates_uniqueness_of :path
  index :path => 1
  
  field :kind,          :type => String, :default => 'full' # can be `simple` or `full` so far
  
  field :subhead,       :type => String
  field :descr,         :type => String

  field :is_simple,     :type => Boolean, :default => false
  
  field :order_value,   :type => String,  :default => 'jjj'
  index :order_value => 1
  
  has_many    :videos
  has_many    :categories
  belongs_to  :category
  embeds_one  :photo

  def self.list
    categories = [['',nil]]
    traverse_categories = lambda do |title, c|
      if '' == title
        this_title = c.title
      else
        this_title = "#{title} - #{c.title}"
      end
      categories.push [this_title, c.id]
      unless c.categories.empty?
        c.categories.each do |c2|
          traverse_categories.call this_title, c2
        end
      end
    end
    top_categories = Category.all.where( :category_id => nil )
    top_categories.each { |c| traverse_categories.call('', c) }
    return categories
  end


end


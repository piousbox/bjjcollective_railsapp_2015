
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
  
  KIND_SIMPLE = :category_kind_simple
  KIND_FULL = :category_kind_full
  field :kind, :type => Symbol, :default => KIND_FULL
  field :is_simple,     :type => Boolean, :default => false
  
  field :subhead,       :type => String
  field :descr,         :type => String
  
  field :order_value,   :type => String,  :default => 'jjj'
  index :order_value => 1
  
  has_many    :videos
  has_many    :categories
  belongs_to  :category
  embeds_one  :photo

  #
  # This is tested. _vp_ 20160522
  #
  def self.list
    Rails.cache.fetch( "Category.all.list", :expires_in => 12.hours ) do
      categories = [ [ '', nil ] ]
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
      categories
    end
  end

end


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

  # what is this? Is this legacy?
  field :slug,          :type => String, :default => ""
  validates_uniqueness_of :slug
  index :slug => 1

  field :short_slug,    :type => String, :default => ""
  index :short_slug => 1
  
  # should be canonical absolute, denormalized, slash-separated?
  field :path,          :type => String, :default => ""
  validates_uniqueness_of :path
  index :path => 1
  
  KIND_SIMPLE = :simple # the title, expanded with children that are lines.
  KIND_FULL = :full # 'technique', children are expanded?
  KIND_LINE = :line # the leaf categories on the branch
  KIND_THUMB = :thumb # the children expand inline (simple+line) without reroute
  KIND_THUMBS = :thumbs # 'guards', it is expanded: a title and thumbs for children
  KINDS = [ KIND_SIMPLE, KIND_FULL, KIND_LINE, KIND_THUMB, KIND_THUMBS ]
  field :kind, :type => Symbol, :default => KIND_FULL
  field :is_simple,     :type => Boolean, :default => false # wtf is this?
  
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
  # remove caching  _vp_ 20171002
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

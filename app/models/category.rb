
# class Symbol
#   def camelize
#     'Category'
#   end
# end


def puts! args, label=''
  puts "+++ +++ #{label}"
  puts args.inspect
end

class Category

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title,         :type => String

  field :slug,          :type => String, :default => ""
  validates_uniqueness_of :slug
  
  field :short_slug,    :type => String, :default => ""
  
  field :path,          :type => String, :default => ""
  validates_uniqueness_of :path

  field :kind,          :type => String, :default => '' # can be `simple` or `full` so far
  
  field :subhead,       :type => String
  field :descr,         :type => String

  field :is_simple,     :type => Boolean, :default => false
  # field :is_top,        :type => Boolean, :default => true # @deprecated
  field :order_value,   :type => String,  :default => 'jjj'
  
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
        puts! c.categories
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


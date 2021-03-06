
Mongo::Logger.logger = ::Logger.new('log/mongo.log')

class CategoriesTasks

  def self.sanity
    return true
  end

  def sanity
    puts! "I am sane."
  end
  
  def reindex
    @categories = {}
    categories = CategoryLegacy.all
    categories.each do |category|
      arr = category.name.split(' - ')
      arr.each_with_index do |item, idx|
        @categories[arr[0]] = {} unless @categories.has_key?( arr[0] )
        @categories[arr[0]][arr[1]] = {} unless @categories[arr[0]].has_key?( arr[1] )
        @categories[arr[0]][arr[1]][arr[2]] = {} unless @categories[arr[0]][arr[1]].has_key?( arr[2] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]] = {} unless @categories[arr[0]][arr[1]][arr[2]].has_key?( arr[3] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]] = {} unless @categories[arr[0]][arr[1]][arr[2]][arr[3]].has_key?( arr[4] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]][arr[5]] = { 'link' => category.url_name } unless @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]].has_key?( arr[5] )
      end
    end

    n_category_leafs = 0
    
    @categories.each do |k, v|
      puts! "Looking at category #{k}."
      c = Category.where( :title => k ).first
      unless c
        c = Category.new :title => k, :order_value => 'jjj', :is_simple => true
        c.save
        puts! "Saved category #{c.title}."
      end        
      
      v.each do |k1, v1|
        puts! "Looking at category #{k} - #{k1}."
        c1 = Category.where( :title => k1, :category_id => c.id ).first
        unless c1
          photo1 = Photo.new
          photo_path_m  = File.join( Rails.root, "app", "assets", "images", "category_images", k,  "m-#{k1}.jpg" )
          photo_path_fm = File.join( Rails.root, "app", "assets", "images", "category_images", k, "fm-#{k1}.jpg" )
          if File.exists? photo_path_m
            photo1.photo = File.open photo_path_m
          elsif File.exists? photo_path_fm
            photo1.photo = File.open photo_path_fm
          end
          c1 = Category.new :title => k1, :order_value => "jjj", :is_simple => false, :category_id => c.id, :photo => photo1
          c1.save
          puts! "Saved category #{c1.title}."
          photo1.category = c1
          flag = photo1.save
          if flag
            puts! "Saved photo."
          else
            puts! "Cannot save photo: #{photo1.errors}."
          end
        end

        v1.each do |k2, v2|
          puts! "Looking at category #{k} - #{k1} - #{k2}."
          c2 = Category.where( :title => k2, :category_id => c1.id ).first
          unless c2
            c2 = Category.new :title => k2, :order_value => "jjj", :is_simple => true, :category_id => c1.id
            c2.save
            puts! "Saved category #{c2.title}."
          end
          
          v2.each do |k3, v3|
            puts! "Looking at category #{k} - #{k1} - #{k2} - #{k3}."
            c3 = Category.where( :title => k3, :category_id => c2.id ).first
            unless c3
              photo3 = Photo.new
              unless "Uncategorised" == k
                photo_path_m  = File.join( Rails.root, "app", "assets", "images", "category_images", k, k1, k2,  "m-#{k3}.jpg" )
                photo_path_fm = File.join( Rails.root, "app", "assets", "images", "category_images", k, k1, k2, "fm-#{k3}.jpg" )
                if File.exists? photo_path_m
                  photo3.photo = File.open photo_path_m
                elsif File.exists? photo_path_fm
                  photo3.photo = File.open photo_path_fm
                end
              end
              c3 = Category.new :title => k3, :order_value => "jjj", :is_simple => false, :category_id => c2.id, :photo => photo3
              c3.save
              puts! "Saved category #{c3.title}."
              photo3.category = c3
              flag = photo3.save
              if flag
                puts! "Saved photo."
              else
                puts! "Cannot save photo: #{photo3.errors}."
              end
            end

            v3.each do |k4, v4|
              puts! "Looking at category #{k} - #{k1} - #{k2} - #{k3} - #{k4}."
              c4 = Category.where( :title => k4, :category_id => c3.id ).first
              unless c4
                c4 = Category.new :title => k4, :order_value => "jjj", :is_simple => true, :category_id => c3.id
                c4.save
                puts! "Saved category #{c4.title}."
              end
              v4.each do |k5, v5|
                puts! "Looking at category #{k} - #{k1} - #{k2} - #{k3} - #{k4} - #{k5}."
                c5 = Category.where( :title => k5, :category_id => c4.id ).first
                unless c5
                  c5 = Category.new :title => k5, :order_value => "jjj", :is_simple => true, :category_id => c4.id
                  c5.save
                  puts! "Saved category #{c5.title}."
                end
                n_category_leafs += 1
                if c5.slug.length < 3
                  c5.slug = v5['link']
                  c5.save
                  puts! "saved link."
                end
                leaf_category = c5
                category_legacy = CategoryLegacy.find_by_url_name(  leaf_category.slug )
                video_legacies = category_legacy.video_legacies
                video_legacies.each do |video_legacy|
                  if ![ '"', '?' ].include?( video_legacy.video_clip.clip[78] )
                    puts! "problem with video clip for video_legacy #{video_legacy.id}"
                    break
                  end
                  video_legacy_youtube_id = video_legacy.video_clip.clip[67..77]
                  this_modern_video = leaf_category.videos.where( :youtube_id => video_legacy_youtube_id ).first
                  unless this_modern_video
                    this_modern_video = Video.new :youtube_id => video_legacy_youtube_id,
                                                  :title => video_legacy.title,
                                                  :descr => video_legacy.description,
                                                  :order_value => "jjj",
                                                  :category_id => leaf_category.id
                    flag = this_modern_video.save
                    if flag
                      puts! "Saved video for #{this_modern_video.youtube_id}."
                    else
                      puts! "Cannot save video #{this_modern_video.errors}"
                    end
                  end
                end
              end
            end
          end
        end      
      end
    end
  end

  def clear_short_slugs
    Category.all.each do |c|
      c.short_slug = nil
      c.save :validate => false
    end
  end
  
  def regenerate_short_slugs
    categories = Category.where( :short_slug => nil )
    puts! categories.length, "n categories without short slug"
    categories.each do |c|
      c.title ||= "Uncategorized"
      c.short_slug = c.title.gsub(/ /, '-').gsub(/[^0-9a-z-]/i, '').downcase
      if c.save
      else
        puts! c.errors, "No luck. #{c.errors}"
      end
    end
  end
  
  def regenerate_slugs
    categories = Category.where( :category_id => nil )
    
    existing_slugs = []
    Category.all.each do |c|
      if c.slug.length > 1
        if existing_slugs.include? c.slug
          puts! c, "dublicate slug!"
        else
          existing_slugs.push c.slug
        end
      end
    end
    
    slugless_categories = Category.where( :slug => "" )
    puts! slugless_categories.length, "n slugless categories"
    slugless_categories.each do |c|
      c.slug = get_slug( c )
      flag = c.save
      if flag
      else
        puts! c.errors, "Problem! Cannot save #{c.slug}."
      end
    end
  end

  def assign_kind
    Category.each do |category|
      if category.kind.blank? && category.photo.blank? && !category.categories[0].photo.blank?
        category.kind = 'thumbs'
        category.save
        puts "Saved thumbs category: #{category.title}"
      elsif category.photo.blank?
        category.kind = 'simple'
        category.save
        puts "Saved simple category: #{category.title}"
      else
        category.kind = 'thumb'
        category.save
        puts "Saved thumb category: #{category.title}"
      end
    end
  end

  def normalize_kind_and_path
    Category.where( :category_id => nil ).each do |c| 
      # guards == c.title
      c.kind = 'thumbs'
      c.path = c.short_slug
      c.save || puts!( c.errors )
      c.categories.each do |c_1|
        # 'Turtle Guard' == c_1.title
        c_1.kind = 'full'
        c_1.path = "#{c.short_slug}/#{c_1.short_slug}"
        c_1.save || puts!( c_1.errors )
        c_1.categories.each do |c_2|
          # 'Side Turtle' == c_2.title
          c_2.kind = "thumbs"
          c_2.path = "#{c.short_slug}/#{c_1.short_slug}/#{c_2.short_slug}"
          c_2.save || puts!( c_2.errors )
          c_2.categories.each do |c_3|
            # 'Classic' == c_3.title
            c_3.kind = "thumb"
            c_3.path = "#{c.short_slug}/#{c_1.short_slug}/#{c_2.short_slug}/#{c_3.short_slug}"
            c_3.save || puts!( c_3.errors )
            c_3.categories.each do |c_4|
              c_4.kind = "simple"
              c_4.path = "#{c.short_slug}/#{c_1.short_slug}/#{c_2.short_slug}/#{c_3.short_slug}/#{c_4.short_slug}"
              c_4.save || puts!( c_4.errors )
              c_4.categories.each do |c_5|
                # 'offensive' == c_5.title
                c_5.kind = 'line'
                c_5.path = c_5.id
                c_5.save || puts!( c_5.errors )
              end
            end
          end
        end
      end
    end
  end

  private

  def puts! args, label=""
    puts "+++ +++ #{label}"
    puts args.inspect
  end

  def get_slug( category )
    category.title ||= "New Category Title"
    slug = "" == category.slug ? category.title.gsub(/ /, '-').gsub(/[^0-9a-z-]/i, '').downcase : category.slug
    if category.category
      slug = "#{get_slug( category.category )}-#{slug}"
    end
    slug
  end
  
end

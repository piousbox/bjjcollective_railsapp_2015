
class Manager::ManagerController < ApplicationController
  before_filter :authenticate
  layout 'manager_bootstrap'
  
  def home
  end

  #
  # private
  #
  private
  
  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "bjjc" && password == "technique-conquers-all"
      end
    end
  end

  def do_update_photos
    badge = @questset || @badge

    if params[:background_image]
      photo = Photo.create :photo => params[:background_image], :bg_badge => badge
      geometry = Paperclip::Geometry.from_file(params[:background_image])
      width, height = geometry.to_s.split 'x'
      badge.update_attributes :background_image => photo, :background_image_width => width, :background_image_height => height
    end

    if @item[:unavailable_photo]
      photo = Photo.new
      photo.photo = @item[:unavailable_photo]
      photo.unavailable_badge = badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
      @item.delete :unavailable_photo
    end

    if @item[:shaded_photo]
      photo = Photo.new
      photo.photo = @item[:shaded_photo]
      photo.shaded_badge = badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
      @item.delete :shaded_photo
    end

    if @item[:accomplished_photo]
      photo = Photo.new
      photo.photo = @item[:accomplished_photo]
      photo.accomplished_badge = badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
      @item.delete :accomplished_photo
    end

    if @item[:title_photo]
      photo = Photo.new
      photo.photo = @item[:title_photo]
      photo.title_badge = badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
      @item.delete :title_photo
    end
  end

  def set_lists
    @merit_badges_list = Badge.all.list
    @questsets_list    = Questset.all.list
    @categories_list   = Category.all.list
    @questpages_list   = Questpage.all.list
  end
  
end


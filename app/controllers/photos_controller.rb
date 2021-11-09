class PhotosController < ApplicationController

  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :desc })


    render({ :template => "photo_templates/index.html.erb"})
  end 

  def show
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id })
    @the_photo = matching_photos.at(0) #what does matching_photos look like? why do I need .at(0)?
    #Parameters: {"path_id"=>"777"}
    render({ :template => "photo_templates/show.html.erb"})
  end

  def baii
    #Parameters: {"toast_id"=>"765;"}
    the_id = params.fetch("toast_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.first
    the_photo.destroy 
    
    #render({ :template => "photo_templates/baii.html.erb"})
    redirect_to("/photos")
  end

  def create
    #  Parameters: {"query_image"=>"a", "query_caption"=>"b", "query_owner_id"=>"777"}
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save
    
    redirect_to("/photos/"+a_new_photo.id.to_s)
    #render({ :template => "photo_templates/create.html.erb"})
  end
end

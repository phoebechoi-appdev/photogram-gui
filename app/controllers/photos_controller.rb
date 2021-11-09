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
    
    next_url = "/photos/" + a_new_photo.id.to_s
    redirect_to(next_url)

    #render({ :template => "photo_templates/create.html.erb"})
  end

  def add_comment
  
    #  Parameters: {"input_photo_id"=>"777", "input_author_id"=>"777", "input_body"=>"ddgge"}
    input_photo_id = params.fetch("query_photo_id")
    input_author_id = params.fetch("query_author_id")
    input_body = params.fetch("query_body")
    #why is this being added to the first person?

    a_new_comment = Comment.new
    a_new_comment.photo_id = input_photo_id
    a_new_comment.author_id = input_author_id
    a_new_comment.body = input_body

    a_new_comment.save

    redirect_to("/photos/"+a_new_comment.photo_id.to_s)

    #render({ :template => "photo_templates/add_comment.html.erb"})

  end

  def update
    #Parameters: {"query_image"=>"https://www.chicagobooth.edu/-/media/project/chicago-booth/why-booth/chicago-booth-speaker.jpg?cx=0.5&cy=0.42&cw=375&ch=156&hash=14E2BB14D9C90E8C1CFDCF3746A0AA74", "query_caption"=>"All dwarfs are bastards in their father's eyes", "modify_id"=>"695"}
    the_id = params.fetch("modify_id")
    matching_photos = Photo.where({ :id => the_id })

    the_photo = matching_photos.at(0)
    
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")

    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save

    next_url = "/photos/" + the_photo.id.to_s
    redirect_to(next_url)

    #render({ :template => "photo_templates/update.html.erb"})
  end
end

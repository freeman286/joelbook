class ImagesController < ApplicationController
  def create
    @image = Image.new(params[:image])
    @image.original_image_url = params[:image_url]

    respond_to do |format|
      if @image.save
        format.js { render :js => "window.image_url = '#{@image.url}'" }
      else
        format.js { render :js => "alert('that image could not be uploaded')"}
      end
    end
  end
end

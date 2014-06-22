class ImagesController < ApplicationController
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.js { render :js => "window.image_url = '#{@image.image.url}'" }
      else
        format.js { render :js => "alert('that cimage could not be uploaded')"}
      end
    end
  end
end

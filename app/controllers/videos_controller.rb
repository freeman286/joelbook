class VideosController < ApplicationController
  def create
    @video = Video.new(:body => params[:youtube_url])
    

    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path(:campaign => "#{@video.campaign_id}"), notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
        format.js { render :js => "window.youtube_url = '#{@video.body_html.match(/https?:\/\/[\S]+/).to_s}'" }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
        format.js { render :js => "alert('that video could not be uploaded')" }
      end
    end
  end
end
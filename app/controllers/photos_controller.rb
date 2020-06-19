class PhotosController < ApplicationController

  def create
    @event = Event.find(params[:event_id])

    if params[:images]
      params[:images].each do |img|
        @event.photos.create(image: img)
      end

      @photos = @event.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @event = @photo.event

    @photo.destroy
    @photos = Photo.where(event_id: @event.id)

    respond_to :js
  end
end

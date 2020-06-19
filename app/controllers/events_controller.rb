class EventsController < ApplicationController
    before_action :set_event, except: [:index, :new, :create]
    before_action :authenticate_user!, except: [:show]
    before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
    
    def index
        @events = current_user.events
    end
    
    def new
        @event = current_user.events.build
    end
    
    def create
        @event = current_user.events.build(event_params)
        if @event.save
            redirect_to listing_event_path(@event), notice: "Saved..."
        else
            flash[:alert] = "Something went wrong..."
            render :new
        end
    end
    
    def show
        @photos = @event.photos
        @guest_reviews = @event.guest_reviews
    end
    
    def listing
    end
    
    def pricing
    end
    
    def description
    end
    
    def photo_upload
        @photos = @event.photos
    end
    
    def amenities
    end
    
    def location
    end
    
    def update
        
        new_params = event_params
        new_params = event_params.merge(active: true) if is_ready_event
        
        if @event.update(new_params)
            flash[:notice] = "Saved..."
        else
            flash[:alert] = "Something went wrong..."
        end
        redirect_back(fallback_location: request.referer)
    end
    
    # --- Reservations ---
    def preload
        today = Date.today
        reservations = @event.reservations.where("start_date >= ? OR end_date >= ?", today, today)
        
        render json: reservations
    end
    
    def preview
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        
        output = {
            conflict: is_conflict(start_date, end_date, @event)
        }
        
        render json: output
    end
    
    private
    
    def is_conflict(start_date, end_date, event)
        check = event.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
        check.size > 0 ? true : false
    end
    
    def set_event
        @event = Event.find(params[:id])
    end
    
    def is_authorised
        redirect_to root_path, alert: "You don't have permission" unless current_user.id == @event.user_id
    end
    
    def is_ready_event
        !@event.active && !@event.price.blank? && !@event.listing_name.blank? && !@event.photos.blank? && !@event.address.blank?
    end
    
    def event_params
        params.require(:event).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active)
    end
end

class ReservationsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        event = Event.find(params[:event_id])
        
        if current_user == event.user
            flash[:alert] = "You cannot book your own property!"
        else
            start_date = Date.parse(reservation_params[:start_date])
            end_date = Date.parse(reservation_params[:end_date])
            days = (end_date - start_date).to_i + 1
            
            @reservation = current_user.reservations.build(reservation_params)
            @reservation.event = event
            @reservation.price = event.price
            @reservation.total = event.price * days
            @reservation.save
            
            flash[:notice] = "Booked Successfully!"
        end
        redirect_to event
    end
    
    def your_trips
        @trips = current_user.reservations.order(start_date: :asc)
    end
    
    def your_reservations
        @events = current_user.events
    end
    
    private
    
    def reservation_params
        params.require(:reservation).permit(:start_date, :end_date)
    end
end

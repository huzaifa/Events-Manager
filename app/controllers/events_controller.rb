class EventsController < ApplicationController

	before_filter :authenticate, :only => [:create, :destroy, :show, :index]
	before_filter :correct_user_event, :only => [:destroy, :show]

	def create
		@search_events = nil
		@p_search_event = nil
		@event = current_user.events.build(params[:event])
		if @event.save
			flash[:success] = "Event created."
			redirect_to event_path(@event)
		else
			flash.now[:error] = "Could not create event."
			@title = "Events"
			render 'index'
		end
	end
	
	def new
		@event = Event.new
		@title = "Add event"
	end
	
	def destroy
		@event = Event.new
		Event.find(params[:id]).destroy
    flash.now[:success] = "Event deleted."
		@search_events = find_events(session[:srch])
		if @search_events
			@p_search_events = @search_events.paginate(:page => params[:page])
		end
    render 'index'
	end
	
	def show
		@event = Event.find(params[:id])
	end
	
	def index
		@event = Event.new
		@p_search_events = nil
		@search_events = find_events(params)
		if @search_events
			@p_search_events = @search_events.paginate(:page => params[:page])
			session[:srch] = params
		else
			session[:srch] = nil
		end
	end
	
	private
	
		def correct_user_event
			id = (Event.find(params[:id])).user_id
    	@user = User.find(id)
    	redirect_to(root_path) unless current_user?(@user)
  	end
  	
  	def find_events(params = {})
  		if params[:range] && params[:range][:"from(1i)"] && params[:range][:"to(1i)"]
  			@search_start = DateTime.civil(params[:range][:"from(1i)"].to_i, params[:range][:"from(2i)"].to_i, params[:range][:"from(3i)"].to_i, params[:range][:"from(4i)"].to_i, params[:range][:"from(5i)"].to_i)
				@search_end = DateTime.civil(params[:range][:"to(1i)"].to_i, params[:range][:"to(2i)"].to_i, params[:range][:"to(3i)"].to_i, params[:range][:"to(4i)"].to_i, params[:range][:"to(5i)"].to_i)
				return Event.where("user_id = :id AND start >= :st AND end <= :en", { :id => current_user.id, :st => @search_start, :en => @search_end })
			end
			return nil
  	end
  	
end

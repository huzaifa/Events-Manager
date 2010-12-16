class PagesController < ApplicationController
  def home
		@title = "Home"
  end

  def contact
		@title = "Contact"
  end

  def about
		@title = "About"
  end

  def signin
		@title = "Sign In"
  end

  def events
		@title = "Events"
  end

	def help
		@title = "Help"
	end
	
	def news
		@title = "News"
	end

end

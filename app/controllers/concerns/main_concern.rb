module MainConcern
	extend ActiveSupport::Concern

	included do
		helper_method :is_logged_in
	end


	def is_logged_in
		if !session[:user_id]
			redirect_to main_path, alert: "Please Login First"
		else 
			return true
		end
	end

	def is_right_user(user_id)
		if(session[:user_id] != user_id)
			redirect_to main_path, alert: "That's not your ID"
		else
			return true
		end
	end
end
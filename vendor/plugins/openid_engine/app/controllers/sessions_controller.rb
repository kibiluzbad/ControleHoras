class SessionsController < ApplicationController
  def create
    open_id_authentication(params[:openid_identifier])
  end

  def destroy
    reset_session
    flash[:notice] = "You have been signed out"
    redirect_to '/'
  end

protected
  def open_id_authentication(openid)
    authenticate_with_open_id(openid,:required => [ :nickname, :email ]) do |result, identity_url, registration|
			
	    if result.successful?
	      if @current_user = User.find_by_identity_url(identity_url) || 
User.new(:identity_url => identity_url) 
#assign_registration_attributes!(registration)

         if current_user.save
	        successful_login(!@current_user.valid?)
              else
                failed_login "Your OpenID profile registration failed: " +
                  @current_user.errors.full_messages.to_sentence
              end


        else
          failed_login "Could not log you in at this time."
	      end
	    else
	      failed_login result.message
	    end
    end
  end
    
private

 # registration is a hash containing the valid sreg keys given above
      # use this to map them to fields of your user model
      def assign_registration_attributes!(registration)
        model_to_registration_mapping.each do |model_attribute, registration_attribute|
          unless registration[registration_attribute].blank?
            @current_user.send("#{model_attribute}=", registration[registration_attribute])
          end
        end
      end

      def model_to_registration_mapping
        { :login => 'nickname', :email => 'email', :display_name => 'fullname' }
      end


  def successful_login(needs_info = false)
    session[:user_id] = @current_user.id
    if needs_info
      redirect_to edit_user_url(@current_user)
    else
      redirect_to(root_url)
    end
  end

  def failed_login(message)
    flash[:notice] = message
    redirect_to(new_session_url)
  end
end


class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    # Checks if pantry_id is present in the user params
    if params[:user][:pantry_id].present?
      # If both params are present, checks to see if the given pantry_id is valid
      pantry = Pantry.find_by(id: params[:user][:pantry_id])
      # If not found, returns an alert and refreshes the page
      if pantry.nil?
        flash[:alert] = "Invalid pantry ID. Please try again."
        redirect_to new_user_registration_path and return
      end
    end

    super do |user|
      # Checks if user was saved successfully before creating a pantry for them
      if user.persisted?
        pantry ||= Pantry.create
        unless pantry.persisted?
          flash[:alert] = "Pantry creation failed. Please try again."
          redirect_to new_user_registration_path and return
        end
        unless user.update(pantry: pantry)
          flash[:alert] = "Pantry assignment failed. Please try again."
          redirect_to new_user_registration_path and return
        end
      end
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :pantry_id, :password, :password_confirmation])
  end
end

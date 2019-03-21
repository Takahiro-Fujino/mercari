# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_captcha, only: %i[address new_user_session]
  prepend_before_action :customize_sign_up_params, only: [:address]
  protect_from_forgery except: :create
  def registration; end

  def address
    session[:nickname] = params[:session][:nickname]
    session[:email] = params[:session][:email]
    session[:password] = params[:session][:password]
    session[:password_confirmation] = params[:session][:password_confirmation]
    session[:last_name] = params[:session][:last_name]
    session[:first_name] = params[:session][:first_name]
    session[:last_name_kana] = params[:session][:last_name_kana]
    session[:first_name_kana] = params[:session][:first_name_kana]
    session[:date_of_birth] = params[:session][:date_of_birth]
  end

  def credit
    session[:zip_code] = params[:session][:zip_code]
    session[:prefecture] = params[:session][:prefecture]
    session[:city] = params[:session][:city]
    session[:address_line1] = params[:session][:address_line1]
    session[:address_line2] = params[:session][:address_line2]
    session[:phone_number] = params[:session][:phone_number]
  end

  def create
    token = params[:"payjp-token"]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      date_of_birth: session[:date_of_birth]
    )
    @user.address = @user.build_address(
      zip_code: session[:zip_code],
      prefecture: session[:prefecture],
      city: session[:city],
      address_line1: session[:address_line1],
      address_line2: session[:address_line2],
      phone_number: session[:phone_number]
    )
    @user.credit = @user.build_credit(
      token: token
    )

    @user.save
    @user.address.save
    @user.credit.save

    if session[:user_id] = @user.id
      sign_up(@user, current_user)
      redirect_to action: 'done'
    else
      redirect_to action: 'registration'
    end
  end

  def done; end

  private

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: %i[nickname email password password_confirmation last_name first_name last_name_kana first_name_kana date_of_birth]
  end

  def check_captcha
    unless verify_recaptcha(model: resource)
      self.resource = resource_class.new sign_up_params
      resource.validate
      respond_with_navigational(resource) { render :registration }
    end
  end
end

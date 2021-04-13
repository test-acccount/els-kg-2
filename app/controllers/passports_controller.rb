class PassportsController < ApplicationController
  skip_before_action :redirect_to_passport_setup?

  layout proc { ["new", "create"].include?(action_name) ? "devise" : "application" }

  def new
    if current_user.passport
      redirect_to root_url
    else
      @passport = current_user.build_passport
    end
  end

  def create
    @passport = current_user.build_passport(passport_params)
    if @passport.save
      redirect_to root_url, notice: t(".notice")
    else
      render :new
    end
  end

  private
    def passport_params
      params.require(:passport).permit(
        :first_name,
        :last_name,
        :phone,
        :address_line,
        :address_zipcode,
        :address_city,
        photos: []
      )
    end
end

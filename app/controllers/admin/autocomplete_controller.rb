module Admin
  class AutocompleteController < AdminController
    def find_user
      @user = User.find_by_id(params[:id])&.passport
      render json: @user
    end

    def suggestions
      if params[:first_name]
        @users = Passport.where("lower(first_name) LIKE ?", "#{params[:first_name].downcase}%")
                        .order(:first_name).distinct.pluck(:first_name)
        @guests = Guest.where("lower(first_name) LIKE ?", "#{params[:first_name].downcase}%")
                       .order(:first_name).distinct.pluck(:first_name)
        render json: @users | @guests
      elsif params[:last_name]
        @users = Passport.where("lower(last_name) LIKE ?", "#{params[:last_name].downcase}%")
                        .order(:last_name).distinct.pluck(:last_name)
        @guests = Guest.where("lower(last_name) LIKE ?", "#{params[:last_name].downcase}%")
                       .order(:last_name).distinct.pluck(:last_name)
        render json: @users | @guests
      end
    end
  end
end

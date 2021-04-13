module Admin
  class UsersController < AdminController
    include Pagy::Backend

    def index
      if params[:search] && !params[:search].blank?
        @pagy, @users = pagy(User.includes(:passport).search_by_name_and_email(params[:search]))
      else
        @pagy, @users = pagy(User.includes(:passport))
      end
    end
  end
end

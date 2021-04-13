module Admin
  class IncomingPackagesController < AdminController
    def index
      @incoming_packages = IncomingPackage.order(created_at: :desc)
    end

    def create
      @incoming_package = IncomingPackage.new(tracking: params[:tracking])
      if @incoming_package.save
        redirect_to admin_incoming_packages_path, notice: t(".notice")
      else
        @incoming_packages = IncomingPackage.where(tracking: params[:tracking])
        flash.now[:alert] = t(".alert")
        render :index
      end
    end

    def destroy
      @incoming_package = IncomingPackage.find(params[:id])
      @incoming_package.destroy
      redirect_to admin_incoming_packages_path, alert: t(".alert")
    end
  end
end

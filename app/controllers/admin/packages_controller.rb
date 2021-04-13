module Admin
  class PackagesController < AdminController
    include Pagy::Backend
    before_action -> { @package = Package.find(params[:id]) }, only: [:edit, :update, :destroy, :cn23]
    before_action -> { @qr = RQRCode::QRCode.new(request.original_url) }, only: [:edit, :update]

    has_scope :dhl, type: :boolean
    has_scope :fedex, type: :boolean
    has_scope :ups, type: :boolean
    has_scope :usps, type: :boolean
    has_scope :other, type: :boolean

    def index
      if params[:search]
        @pagy, @packages = pagy(
          apply_scopes(
            Package.includes(:guest, :user, :passport, :package_items).where("tracking LIKE ?", "%#{params[:search]}").order(updated_at: :desc)
          )
        )
      elsif params[:search_by_name] && !params[:search_by_name].blank?
        @pagy, @packages = pagy(
          apply_scopes(
            Package.includes(:guest, :user, :passport, :package_items).search_by_name(params[:search_by_name]).order(updated_at: :desc)
          )
        )
      else
        @pagy, @packages = pagy(
          apply_scopes(
            Package.includes(:guest, :user, :passport, :package_items).order(updated_at: :desc)
          )
        )
      end
    end

    def new_or_edit
      # Fedex SmartPost: Some users get tracking number with 9* prefix, some don't.
      # Search for both numbers with and without prefix when applicable
      fedex_smart_post_without_prefix = false

      t = TrackingNumber.new(params[:q])

      # Fedex GSN
      if t.courier_code == :fedex && t.decode[:gsn]
        tracking = t.serial_number[2..-1] + t.check_digit
      # Fedex Ground (96)
      elsif t.courier_code == :fedex && t.decode[:scnc]
        tracking = t.serial_number + t.check_digit
      # USPS 91
      elsif t.courier_code == :usps && t.decode[:scnc]
        # Fedex SmartPost delivered by USPS
        if t.decode[:scnc] == "61" && t.decode[:service_type] == "29"
          fedex_smart_post_without_prefix = true # Set to true, so we search substring track too
        end
        tracking = t.serial_number + t.check_digit
      else
        tracking = params[:q]
      end

      # Temporary search to avoid USPS 42019701 prefix, change to (tracking: tracking) after 10 days
      @package = Package.find_by("tracking LIKE ?", "%#{tracking}")
      if !@package && fedex_smart_post_without_prefix
        @package = Package.find_by(tracking: tracking[2..-1])
      end

      if @package
        redirect_to edit_admin_package_path(@package.id)
      else
        redirect_to new_admin_package_path(tracking: tracking)
      end
    end

    def new
      @package = Package.new(tracking: params[:tracking])
      @package.build_guest
      @package.package_items.build
    end

    def create
      @package = Package.new(package_params)
      if @package.save(context: :admin)
        redirect_to admin_packages_path, notice: t(".notice")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @package.update(package_params) && @package.valid?(:admin)
        redirect_to admin_packages_path, notice: t(".notice")
      else
        render :edit
      end
    end

    def destroy
      @package.destroy
      redirect_to admin_packages_path, alert: t(".alert")
    end

    def destroy_image
      @image = ActiveStorage::Attachment.find(params[:id])
      @image.purge

      respond_to do |format|
        format.html
        format.js
      end
    end

    def cn23
      render layout: "print"
    end

    private
      def package_params
        params.require(:package).permit(
          :tracking,
          :weight,
          photos: [],
          guest_attributes: [:first_name, :last_name],
          package_items_attributes: [:id, :_destroy, :description, :price, :qty]
        )
      end
  end
end

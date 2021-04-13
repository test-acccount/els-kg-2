module Admin
  class SitePricingsController < AdminController
    before_action -> { @site_pricing = SitePricing.first }

    def edit
    end

    def update
      if @site_pricing.update(site_pricing_params)
        redirect_to admin_root_path, notice: t(".notice")
      else
        render :edit
      end
    end

    private
      def site_pricing_params
        params.require(:site_pricing).permit(:shipping_local, :shipping_usd)
      end
  end
end

module Admin
  class ShipmentsController < AdminController
    require "ru_propisju"
    require "translit"

    before_action -> { @shipment = Shipment.find(params[:id]) }, only: [:set_as_in_transit, :set_as_arrived]

    def index
      @shipments = Shipment.order(created_at: :desc)
    end

    def create
      @shipment = Shipment.create
      if @shipment.save
        redirect_to admin_shipments_path, notice: t(".notice")
      else
        redirect_to admin_shipments_path, alert: t(".alert")
      end
    end

    def pending_invoice
      @packages = Package.pending
      filename = "Invoice #{Date.current}.xlsx"
      respond_to do |format|
        format.xlsx {
          response.headers["Content-Disposition"] = "attachment; filename=" + filename
        }
      end
    end

    def set_as_in_transit
      @shipment.status_in_transit!
      redirect_to admin_shipments_path, notice: t(".notice")
    end

    def set_as_arrived
      @shipment.status_arrived!
      redirect_to admin_shipments_path, notice: t(".notice")
    end

    def invoice
      @shipment = Shipment.find(params[:id])
      filename = "Invoice #{Date.current}.xlsx"
      respond_to do |format|
        format.xlsx {
          response.headers["Content-Disposition"] = "attachment; filename=" + filename
        }
      end
    end

    def list_cp71
      @shipment = Shipment.find(params[:id])
      render layout: "print"
    end

    def invoice_register
      @shipment = Shipment.find(params[:id])
      filename = "Invoice Register #{Date.current}.xlsx"
      respond_to do |format|
        format.xlsx {
          response.headers["Content-Disposition"] = "attachment; filename=" + filename
        }
      end
    end
  end
end

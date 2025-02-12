class StorefrontsController < ApplicationController
  before_action :set_storefront, only: %i[ show edit update destroy update_ordering destroy_reason]

  # GET /storefronts or /storefronts.json
  def index
    @storefronts = Storefront.all
  end

  # GET /storefronts/1 or /storefronts/1.json
  def show
  end

  # GET /storefronts/new
  def new
    @storefront = Storefront.new
  end

  # GET /storefronts/1/edit
  def edit
  end

  # POST /storefronts or /storefronts.json
  def create
    @storefront = Storefront.new(storefront_params)

    respond_to do |format|
      if @storefront.save
        format.html { redirect_to storefront_url(@storefront), notice: "Storefront was successfully created." }
        format.json { render :show, status: :created, location: @storefront }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @storefront.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storefronts/1 or /storefronts/1.json
  def update
    respond_to do |format|
      if @storefront.update(storefront_params)
        format.html { redirect_to [:edit, @storefront], notice: "Storefront was successfully updated." }
        format.json { render :edit, status: :ok, location: @storefront }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @storefront.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_ordering
    reason = @storefront.reasons.find(params[:reason_id])
    reason.insert_at(params[:ordering].to_i)

    render :edit, status: :ok, location: @storefront.reload
  end

  # DELETE /storefronts/1 or /storefronts/1.json
  def destroy
    @storefront.destroy!

    respond_to do |format|
      format.html { redirect_to storefronts_url, notice: "Storefront was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_reason
    reason = @storefront.reasons.find(params[:reason_id])
    reason.destroy!

    redirect_to edit_storefront_path(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storefront
      @storefront = Storefront.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def storefront_params
      params.fetch(:storefront, {}).permit(
      :name,
        {
          reasons_attributes: [
            :id,
            :code,
            :label,
            :ordering,
            :active,
            :_destroy,
            { restricted_resolution_types: [] }
          ]
        }
      )
    end
end

class LigneFacturesController < ApplicationController
  before_action :set_ligne_facture, only: [:index,:show, :edit, :update, :destroy]
  before_action :userValidation

  # GET /ligne_factures
  # GET /ligne_factures.json
  def index
    #@facture_id = @ligne_facture # id en param
    @ligne_factures = LigneFacture.all #where(:facture_id == @facture_id)
  end

  # GET /ligne_factures/1
  # GET /ligne_factures/1.json
  def show
  end

  # GET /ligne_factures/new
  def new
    @ligne_facture = LigneFacture.new
  end

  # GET /ligne_factures/1/edit
  def edit
  end>

  # POST /ligne_factures
  # POST /ligne_factures.json
    def create
      @ligne_facture = LigneFacture.new(ligne_facture_params)
      respond_to do |format|
        if @ligne_facture.save
          format.html { redirect_to @ligne_facture, notice: 'Ligne facture was successfully created.' }
          format.json { render :show, status: :created, location: @ligne_facture }
        else
          format.html { render :new }
          format.json { render json: @ligne_facture.errors, status: :unprocessable_entity }
        end
      end
    end

  # PATCH/PUT /ligne_factures/1
  # PATCH/PUT /ligne_factures/1.json
  def update
    respond_to do |format|
      if @ligne_facture.update(ligne_facture_params)
        format.html { redirect_to @ligne_facture, notice: 'Ligne facture was successfully updated.' }
        format.json { render :show, status: :ok, location: @ligne_facture }
      else
        format.html { render :edit }
        format.json { render json: @ligne_facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ligne_factures/1
  # DELETE /ligne_factures/1.json
  def destroy
    @ligne_facture.destroy
    respond_to do |format|
      format.html { redirect_to ligne_factures_url, notice: 'Ligne facture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_ligne_facture
    @ligne_facture = LigneFacture.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def ligne_facture_params
    params.require(:ligne_facture).permit(:produit_id, :facture_id, :quantite, :prixUnitaireHT)
  end
end

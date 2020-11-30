class FacturesController < ApplicationController
  before_action :set_facture, only: [:show, :edit, :update, :destroy]

  before_action :userValidation

  # GET /factures
  # GET /factures.json
  def index
    @estAdmin = admin?
    @factures = if @estAdmin
      Facture.all
    else
      Facture.where(user_id: session[:user]['id'])
    end
    #puts @factures.size()
  end

  # GET /factures/1
  # GET /factures/1.json
  def show
  end

  # GET /factures/new
  def new
    @facture = Facture.new
    @clients = Client.all
  end

  # GET /factures/1/edit
  def edit
  end

  # POST /factures
  # POST /factures.json


  def create
    @facture = Facture.new(facture_params)
    @facture.user_id = session[:user]['id']
    @facture.id = generateId

    @facture.montantTTC = @facture.montantTVA + @facture.montantHT
    # Verification sum(Facture) >  encours
    client_encours = Client.find(@facture.client_id).encours
    sum = Facture.where('client_id': @facture.client_id).where('estRegle': 0 ).sum('montantTTC')

    if client_encours < sum + @facture.montantTTC
      redirect_to new_facture_path, danger: "Vous ne pouvez pas créer cette facture ! La somme des factures non réglées est supérieur à l'envours de ce client"

    else
      respond_to do |format|
      if @facture.save
        format.html { redirect_to @facture, success: 'Votre facture a été créée avec succès !' }
        format.json { render :show, status: :created, location: @facture }
      else
        format.html { render :new }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
    end

  end

  # PATCH/PUT /factures/1
  # PATCH/PUT /factures/1.json
  def update
    respond_to do |format|
      if @facture.update(facture_params)
        format.html { redirect_to @facture, success: 'Votre facture a été mise à jour avec succès !' }
        format.json { render :show, status: :ok, location: @facture }
      else
        format.html { render :edit }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factures/1
  # DELETE /factures/1.json
  def destroy
    @facture.destroy
    respond_to do |format|
      format.html { redirect_to factures_url, success: 'Votre facture a été supprimé avec succès!' }
      format.json { head :no_content }
    end
  end

  # Valider
  def valider
    id = params[:id]
    facture = Facture.find(id)
    facture.estValide = 1

    puts "Lest's Try to valdiaate ========="
    puts facture.inspect
    if facture.save
      redirect_to factures_path, success: 'La facture #{id} a été validé avec succes'
    else
      redirect_to factures_path, danger: "Il y'a un probleme lors de la validation"
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facture
    @facture = Facture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def facture_params
    puts params.require(:facture).inspect
    params.require(:facture).permit(:date, :montantTTC, :montantHT, :montantTVA, :estValide, :estRegle, :modeReglement, :client_id)
  end

  def generateId
    lastId = Facture.last.id
    return lastId.next if lastId != nil
    return "FA%05d" % 1
  end
end

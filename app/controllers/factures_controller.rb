class FacturesController < ApplicationController
  before_action :userValidation
  before_action :set_facture, only: [:show, :edit, :update, :destroy]


  # GET /factures
  # GET /factures.json
  def index
    @estAdmin = admin?
    id = session[:user]['id']
    search = params[:search]&.downcase
    @factures = if @estAdmin && !search
                  Facture.includes('client').all
                elsif @estAdmin && search
                  Facture.includes('client').search(search).all
                elsif search
                  Facture.includes('client').where(user_id: id).search(search)
                else
                  Facture.includes('client').where(user_id: id)
                end

    @factures = @factures.page(params[:page]).per(7)
  end

  # GET /factures/1
  # GET /factures/1.json
  def show
    @estAdmin = admin?
  
    # Check si c'est sa facture
    if !@estAdmin && @facture.user_id != session[:user]['id']
      redirect_to factures_path, danger: "Ce n'est pas une de vos factures"
    end


    puts '--------------'
    puts @facture.id
    puts '--------------'
    
    if @facture.id
      @ligne_factures = LigneFacture.where(facture_id: @facture.id)
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Facture No. #{@facture.id}",
               page_size: 'A4',
               template: 'factures/pdf.html.erb',
               layout: 'pdf.html',
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end

  end

  # GET /factures/new
  def new
    @facture = Facture.new
    @clients = Client.all
  end

  # GET /factures/1/edit
  def edit; end

  # POST /factures
  # POST /factures.json


  def create
    @facture = Facture.new(facture_params)
    @facture.user_id = session[:user]['id']
    @facture.id = generate_id

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

    if facture.save

      FactureMailer.validation_complete(facture).deliver_later

      redirect_to factures_path, success: 'La facture ' + id + ' a été validé avec succes'
    else
      redirect_to factures_path, danger: "Il y'a un probleme lors de la validation"
    end
  end




  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facture
    begin
      @facture = Facture.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to factures_path, danger: "Numéro de facture invalide"
    end
  end

  # Only allow a list of trusted parameters through.
  def facture_params
    puts params.require(:facture).inspect
    params.require(:facture).permit(:date, :montantTTC, :montantHT, :montantTVA, :estValide, :estRegle, :modeReglement, :client_id)
  end

  def generate_id
    last_id = Facture.last&.id
    return last_id.next unless last_id.nil?

    'FA%05d' % 1
  end
end

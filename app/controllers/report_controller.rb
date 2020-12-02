class ReportController < ApplicationController

  before_action :adminValidation

  def index
    #Top 5
    @top5 = Facture.includes('client').group('clients.nom').sum('montantTTC')
    @top5 = @top5.sort_by { |_key, value| value }.reverse


    # Chiffre d'affaire par client chaque mois
    query = "SELECT clients.nom, factures.created_at,sum(montantTTC) as CA from factures,clients where factures.client_id == clients.id group by client_id,strftime('%Y-%m-01 00:00:00 UTC', factures.created_at)"
    res_query = ActiveRecord::Base.connection.execute(query)



    # Evolution du chiffre d'affaire total par mois

    @ca_by_month= Facture.group_by_month(:created_at).sum('montantTTC')
    puts "============="
    @evo_ca = {}
    cumul = 0
    @ca_by_month.each do |ca|
      puts ca.inspect
      puts @ca_by_month
      puts @evo_ca
      @evo_ca[ca[0]]= ca[1]+cumul
      cumul+=ca[1]
    end

    # Traitement des données de la T2
    @ca_every_month = {} # Client => [CAtotal  then  CA/month]
    res_query.each do |line|
      puts line.inspect
      # local variable
      client_nom = line['nom']
      month_ca = line['CA']

      if @ca_every_month[client_nom] == nil
        empty_array = [0]*13
        @ca_every_month[client_nom] = empty_array
      end
      month_index = Date.parse(line['created_at']).month
      @ca_every_month[client_nom][0] += month_ca
      @ca_every_month[client_nom][month_index] = month_ca
    end

  end


end

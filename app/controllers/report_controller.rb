class ReportController < ApplicationController

  before_action :adminValidation

  def index
    #Top 5
    @top5 = Facture.includes('client').group('clients.nom').sum('montantTTC')
    @top5 = @top5.sort_by { |_key, value| value }.reverse

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


  #   <% cumul = 0 %>
  #   <% @evo_ca.each do |ca| %>
  # <% ca[1] = ca[1] + cumul %>
  #   <% cumul = ca[1] %>
  #       <% end %>

  end


end

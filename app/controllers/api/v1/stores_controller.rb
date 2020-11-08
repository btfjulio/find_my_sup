require 'pry'

module Api::V1
  class StoresController < ApplicationController
    
    before_action :set_store, only: %i(show)

    def index 
    
      
      @stores = Store.joins(:ratings)
                    .select('stores.*, AVG(ratings.value) as a')
                    .within(params[:longitude].to_f, params[:latitude].to_f, 5000)
                    .group('stores.id')
                    .order('a DESC')
    end


    def show;end
    
    private

    def set_store
      @store = Store.find_by(google_place_id: params[:id])
    end
  end
end

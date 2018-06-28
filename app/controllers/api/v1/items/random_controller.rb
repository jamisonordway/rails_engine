class Api::V1::Items::RandomController < ApplicationController

    def show
        id = Item.all.sample.id
        render json: Item.find(id)
    end 

end 
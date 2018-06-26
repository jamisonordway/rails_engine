class Api::V1::Items::RandomController < ApplicationController

    def show
        id = rand(Item.first.id..Item.last.id)
        render json: Item.find(id)
    end 

end 
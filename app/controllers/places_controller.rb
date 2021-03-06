class PlacesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_place, only: [:show, :edit, :update, :destroy]
    
    def index
        @places = Place.order("name").paginate(:page => params[:page], :per_page => 5)
    end 
    
    def new
        @place = Place.new
    end
    
    def create
        @place = current_user.places.create(place_params)
        if @place.valid?
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def show
        @comment = Comment.new
        @photo = Photo.new
    end
    
    def edit
        if @place.user != current_user
            return render text: 'Not Allowed', status: :forbidden
        end    
    end 
    
    def update
        if current_user != @place.user
            return render text: 'You are not allowed', status: :forbidden
        end    
        @place.update_attributes(place_params)
        if @place.valid?
            redirect_to place_path(@place)
        else
            render :edit, status: :unprocessable_entity
        end
    end 
    
    def destroy
        if current_user != @place.user
            return render text: 'You are not allowed to perform this action', status: :forbidden
        end
        @place.destroy
        redirect_to root_path
    end    
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
       @place = Place.find(params[:id])
    end
    
    #pulls out data we need from places form
    def place_params
        params.require(:place).permit(:name, :description, :address)
    end 
    
end

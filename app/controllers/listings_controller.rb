class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]

    def index
        @listings = Listing.all
    end

    def show

    end

    def new
        set_breeds_and_sexes
        @listing = Listing.new
    end

    def create
        #finish logic for creating a record
        @listing = Listing.create(listing_params)
        if @listing.errors.any?
            set_breeds_and_sexes
            render "new"
        else 
            redirect_to listings_path
        end
    end

    def edit
        set_breeds_and_sexes
        @listing = Listing.new
    end

    def update
        # not sure about breed parameter, do we update Breed/Breed table at the same time?
        
        title = params["title"]
        description = params["description"]
        sex = params["sex"]
        price = params["price"]
        deposit = params["deposit"]
        date_of_birth = params["date_of_birth"]
        picture = params["picture"]

        # probably should be using Listing.update(params["id"], ...) method isntead
        updated_listing = Listing.find_by_title(title)
        updated_listing.description = description
        updated_listing.sex = sex
        updated_listing.price = price 
        updated_listing.deposit = deposit 
        updated_listing.date_of_birth = date_of_birth
        updated_listing.picture = picture
        updated_listing.save

        # double check this
        redirect_to edit_listing_path
    end

    def destroy
        
        #finish logic for deleting the record
    end

    private

    def set_listing
        @listing = Listing.find(params[:id])
    end

    def set_breeds_and_sexes
        @breeds = Breed.all
        @sexes = Listing.sexes.keys
    end

    def listing_params
        params.require(:listing).permit(:title, :description, :breed_id, :sex, :city, :state, :price, :deposit, :date_of_birth, :diet, :picture)
    end

end
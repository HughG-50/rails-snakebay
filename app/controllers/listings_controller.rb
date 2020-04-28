class ListingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_listing, only: [:edit, :update, :destroy]
    before_action :set_listing, only: [:show]

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
        # @listing = Listing.create(listing_params)

        # Listing now belongs to user, so we need to use current_user to retrieve the thing we want
        @listing = current_user.listings.create(listing_params)

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

    # This should be almost identical to the 'new'
    def update
        # instead of create we are updating
        @listing = Listing.update(params["id"], listing_params)
        if @listing.errors.any?
            set_breeds_and_sexes
            # if errors, we are re-rendering the edit view, instead of the new view
            render "edit"
        else 
            redirect_to listings_path
        end
    end

    def destroy
        Listing.find(params["id"]).destroy
        redirect_to listings_path
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
    
    # We want to be able to have a way to limit the scope of what users are authorised to do
    # What this does is attempts to retrive the listing from the logged in user, if we can't
    # find one then just redirect back to the listing page
    def set_user_listing
        id = params[:id]
        @listing = current_user.listings.find_by_id(id)

        if @listing == nil
            redirect_to listings_path
        end
    end
end
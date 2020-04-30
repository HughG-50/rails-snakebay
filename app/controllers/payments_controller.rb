class PaymentsController < ApplicationController
    # allowing post requests cross-site only from our webhook
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
    end

    def webhook 
        p params 
    end

end
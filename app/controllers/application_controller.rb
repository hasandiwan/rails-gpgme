require 'gpgme'
class ApplicationController < ActionController::API
  def index
    crypto = GPGME::Crypto.new
    $out = crypto.clearsign params[:text]
    render json: {:text => params[:text], :signed => $out.to_s}, status: :created
  end

  # TODO add verify, encryption, and descryption support here
end

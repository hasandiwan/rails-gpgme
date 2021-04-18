require 'gpgme'
class ApplicationController < ActionController::API
  def index
    crypto = GPGME::Crypto.new
    $out = crypto.clearsign params[:text]
    render json: {:text => params[:text], :signed => $out.to_s}, status: :created
  end

  def verify
    $text = params[:text]
    $key = params[:key]
    $valid = false
    $crypto = GPGME::Crypto.new
    $crypto.verify($crypto.sign $text)  do |signature|
      #render json: {:verified => signature.valid? }, status: 201
      $vald = signature.valid?
    end
    render json: {:verified => $vald }, status: 201
  end
  # TODO add encryption, and descryption support here
end

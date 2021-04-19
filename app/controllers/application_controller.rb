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
      $vald = signature.valid?
    end
    render json: {:verified => $vald }, status: 201
  end
  
  def encrypt
    $text = params[:text]
    $key = params[:key]

    GPGME::Key.import($key)
    $crypto = GPGME::Crypto.new :always_trust => true
    render json: {encrypted: => $crypto, plain: => $text}
  end

  # TODO add decryption
  
end

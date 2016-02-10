require 'eventmachine'
require "base64"


class Api::V1::TabletsController < ApplicationController

  include Api::V1::TabletsHelper

  protect_from_forgery with: :null_session

  before_filter :check_http_basic_auth

  def register

    @tablet = Tablet.where(token: tablet_params[:token]).first

    if @tablet.nil?
      @tablet = Tablet.new(tablet_params)

      respond_to do |format|
        if @tablet.save
          format.json { render :show, status: :created, location: @tablet }
        else
          format.json { render json: @tablet.errors, status: :unprocessable_entity }
        end
      end
    else

      if @tablet.update(tablet_params)
        format.json { render :show, status: :ok, location: @tablet }
      else
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end

  end

  def data_accepted

    tablet = Tablet.where(token: tablet_params[:token]).first
    credit_card = credit_card_params

    EM.run do
      client = Faye::Client.new("#{request.protocol}#{request.host}:#{request.port}/faye")

      client.publish("/tablet_#{tablet.id}", 'text' => "Data accepted. Card: #{credit_card[:number]} - #{credit_card[:expiration_date]} - #{credit_card[:cvc]}" )
    end

    render json: 'data_accepted'
  end

  def data_declined
    tablet = Tablet.where(token: tablet_params[:token]).first

    EM.run do
      client = Faye::Client.new("#{request.protocol}#{request.host}:#{request.port}/faye")

      client.publish("/tablet_#{tablet.id}", 'text' => 'Data declined')
    end

    render json: 'data_declined'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tablet_params
    params.require(:tablet).permit(:name, :token)
  end

  def credit_card_params
    params.require(:card).permit(:number, :expiration_date, :cvc)
  end
end

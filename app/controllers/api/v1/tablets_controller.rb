class Api::V1::TabletsController < ApplicationController

  include Api::V1::TabletsHelper

  protect_from_forgery with: :null_session

  before_filter :check_http_basic_auth

  def register
    @tablet = Tablet.new(tablet_params)

    respond_to do |format|
      if @tablet.save
        format.json { render :show, status: :created, location: @tablet }
      else
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  def data_accepted
    render json: 'data_accepted'
  end

  def data_declined
    render json: 'data_declined'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tablet_params
    params.require(:tablet).permit(:name, :token)
  end
end

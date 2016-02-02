require 'uuid_helper'

class TabletsController < ApplicationController
  include TabletsHelper

  before_action :authenticate_user!
  before_action :set_tablet, only: [:show, :edit, :update, :destroy]

  # GET /tablets
  # GET /tablets.json
  def index
    @tablets = Tablet.all
    @user = current_user
  end

  # GET /tablets/1
  # GET /tablets/1.json
  def show
  end

  # GET /tablets/new
  def new
    @tablet = Tablet.new
  end

  # GET /tablets/1/edit
  def edit
  end

  # POST /tablets
  # POST /tablets.json
  def create
    @tablet = Tablet.new(tablet_params)

    respond_to do |format|
      if @tablet.save
        format.html { redirect_to @tablet, notice: 'Tablet was successfully created.' }
        format.json { render :show, status: :created, location: @tablet }
      else
        format.html { render :new }
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tablets/1
  # PATCH/PUT /tablets/1.json
  def update
    respond_to do |format|
      if @tablet.update(tablet_params)
        format.html { redirect_to @tablet, notice: 'Tablet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tablet }
      else
        format.html { render :edit }
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tablets/1
  # DELETE /tablets/1.json
  def destroy
    @tablet.destroy
    respond_to do |format|
      format.html { redirect_to tablets_url, notice: 'Tablet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /tablets/1/send_notification
  def send_notification
    @tablet = Tablet.find(params[:tablet_id])

    # TODO: save message_uuid to db
    message_uuid = UUIDHelper.new_uuid_string
    first_name = params.require(:first_name)
    last_name = params.require(:last_name)
    address = params.require(:address)
    account_number = params.require(:account_number)

    payload = {
      first_name: first_name,
      last_name: last_name,
      address: address,
      account_number: account_number,
    }

    send_notification_to_tablet(@tablet, message_uuid, payload)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tablet
      @tablet = Tablet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tablet_params
      params.require(:tablet).permit(:name, :token)
    end
end

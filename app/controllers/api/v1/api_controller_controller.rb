class Api::V1::ApiControllerController < ApplicationController
  protect_from_forgery with: :null_session

  def do_it
    @msg = 'helo'
  end
end

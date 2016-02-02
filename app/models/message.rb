class Message < ActiveRecord::Base
  belongs_to :tablet

  ACCEPT_STATUS_SENT = 0
  ACCEPT_STATUS_ACCEPTED = 1
  ACCEPT_STATUS_DECLINED = 2
end

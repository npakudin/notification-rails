require 'rubygems'
require 'uuidtools'

module UUIDHelper
  def self.parse(uuidstring)
    return UUIDTools::UUID.parse(uuidstring)
  end
  def self.new_uuid_string
    #timestamp_create has a problem when virtualization hides MAC address from being accessed by UUIDTools
    #return UUIDTools::UUID.timestamp_create().to_s
    return UUIDTools::UUID.random_create().to_s
  end
end
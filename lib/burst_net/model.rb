module BurstNet
  class Model
    def self.burstnet
      @burstnet ||= BurstNet::API.new
    end
  end
end
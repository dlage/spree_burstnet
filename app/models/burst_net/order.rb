module BurstNet
  class Order < BurstNet::Model
    attr_accessor :id

    def initialize(params)
      self.id = params['id']
    end

    def self.all
      orders = self.burstnet.get_orders
      orders_objs = []
      orders['order'].each do |order|
        orders_objs << self.new(order)
      end
      orders_objs
    end

    # Find a particular product, based on its name
    def self.find(id)
      order = self.burstnet.get_order(id)
      self.new(order['order'])
    end
  end
end

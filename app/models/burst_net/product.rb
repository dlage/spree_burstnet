module BurstNet
  class Product < BurstNet::Model
    attr_accessor :id, :name, :description, :config

    def initialize(params)
      self.id = params['id']
      self.name = params['name']
      self.description = params['description']
      self.config = params['config'] unless params['config'].nil?
    end

    def self.all
      products = self.burstnet.get_products
      products_objs = []
      products['product'].each do |prod|
        products_objs << self.new(prod)
      end
      products_objs
    end

    # Find a particular product, based on its name
    def self.find(id)
      product = self.burstnet.get_product(id)
      self.new(product['product'])
    end
  end
end

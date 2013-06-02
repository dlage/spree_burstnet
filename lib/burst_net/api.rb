require 'rubygems'
require 'httparty'
require 'json'

=begin BurstNet API methods
  GET order
  GET order/:id
  GET order/active/
  GET order/cancelled/
  GET order/fraud/
  GET order/pending/
  GET product
  GET product/:id
  GET product/backup/
  GET product/backup/:id
  GET product/cp/
  GET product/cp/:id
  GET product/os/
  GET product/os/:id
  GET product/site/
  GET product/site/:id
  GET service
  GET service/:id
  GET service/active/
  GET service/cancelled/
  GET service/fraud/
  GET service/pending/
  GET service/suspended/
  GET service/terminated/
  POST order
  POST service/:id
  PUT service/:id
=end
module BurstNet
  class API
    include HTTParty
    base_uri 'https://rsapi.burst.net'
    format :json
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'

    def self.configuration
      @configuration ||=  {}
    end

    def self.configure
      yield(configuration) if block_given?
    end

    def initialize
      self.class.default_options.merge!(self.class.configuration)
    end

    def get(path, options = {})
      response = self.class.get(path, options)
      if response.success?
        response.parsed_response
      else
        raise response.response
      end
    end

    def post(path, options = {})
      response = self.class.post(path, options).parsed_response
      if response.success?
        response.parsed_response
      else
        raise response.response
      end
    end

    def put(path, options = {})
      response = self.class.put(path, options).parsed_response
      if response.success?
        response.parsed_response
      else
        raise response.response
      end
    end

    def delete(path, options = {})
      response = self.class.delete(path, options).parsed_response
      if response.success?
        response.parsed_response
      else
        raise response.response
      end
    end

    def get_products
      self.get('/product')
    end

    def get_product(id)
      self.get("/product/#{id}")
    end

    def get_product_backup(id)
      self.get("/product/backup/#{id}")
    end

    def get_product_cp(id)
      self.get("/product/cp/#{id}")
    end

    def get_product_os(id)
      self.get("/product/os/#{id}")
    end

    def get_product_site(id)
      self.get("/product/site/#{id}")
    end

    def get_services
      self.get('/service')
    end

    def get_service(id)
      self.get("/service/#{id}")
    end

    def terminate_service(id)
      self.delete("/service/#{id}")
    end

    def change_service(id, params)
      options = {:body => params}
      self.post(id, options)
    end

    def update_service(id, params)
      options = {:body => params}
      self.put(id, options)
    end

    def get_services_by_status(status)
      possible_status = %w(active cancelled fraud pending suspended terminated)
      raise('Unknown service status') unless possible_status.include?(status)
      self.get("/service/#{status}")
    end

    def get_orders
      self.get('/order')
    end

    def get_orders_by_status(status)
      possible_status = %w(active cancelled fraud pending)
      raise('Unknown order status') unless possible_status.include?(status)
      self.get("/order/#{status}")
    end

    def get_order(id)
      self.get("/order/#{id}")
    end

    def create_order(params)
      options = {:body => params}
      self.post(id, options)
    end

  end
end

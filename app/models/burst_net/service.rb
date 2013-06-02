module BurstNet
  class Service < BurstNet::Model
    attr_accessor :id, :name, :hostname, :order_id, :status, :product_id, :dedicatedip, :assignedips, :username, :password

    def initialize(params)
      self.id = params['id']
      self.name = params['name']
      self.hostname = params['hostname']
      self.order_id = params['order']
      self.status = params['status']
      self.product_id = params['pid '] # Not a typo - the field really comes like this
      self.dedicatedip = params['dedicatedip']
      self.assignedips = params['assignedips']
      self.username = params['username']
      self.password = params['password']
    end

    def self.all
      services = self.burstnet.get_services
      services_objs = []
      yield services_objs unless services.kind_of?(Array)
      services.each do |serv|
        services_objs << self.new(serv)
      end
      services_objs
    end

    # Find a particular service, based on its name
    def self.find(id)
      service = self.burstnet.get_service(id)
      self.new(service)
    end
  end
end

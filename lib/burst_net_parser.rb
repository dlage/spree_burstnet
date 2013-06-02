class BurstNetParser < Faraday::Response::Middleware
  def on_complete(env)
    json = MultiJson.load(env[:body], symbolize_keys: true)
    json.each do |k, v|
      if k == :product
        json = v[0]
        break
      end
    end
    puts json
    env[:body] = {
        data: json,
    }
  end
end
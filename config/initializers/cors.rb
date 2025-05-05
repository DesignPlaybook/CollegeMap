# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://college-map-ed0f662da28b.herokuapp.com'  # Your frontend's domain
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end

# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://www.collegemap.in'  # Your frontend's domain
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end

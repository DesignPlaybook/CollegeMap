Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://www.collegemap.in', 'https://collegemap.in'  # Allow only your frontend domain

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options],
      credentials: true  # Allow credentials to be included in the requests
  end
end

if ENV['RAZORPAY_KEY_ID'] && ENV['RAZORPAY_KEY_SECRET']
    require 'razorpay'
    Razorpay.setup(ENV['RAZORPAY_KEY_ID'], ENV['RAZORPAY_KEY_SECRET'])
end
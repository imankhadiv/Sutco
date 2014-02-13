# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Team10MiniProject::Application.config.secret_token = Rails.env.production? ? 'F_mm2qwsWR1kX9mYmUh?YDYo-w1nZvdC0zJijIo6dQcmcA3R0WYo65Ou-gQxw8WPwJKImfCe06lZdUSRv0OMNlUA?zB4LuabgYjBPjrYVJXkKSM8ICK5TtBraVaaCo' : (Rails.env.demo? ? 'R2jS42eTlt0HAYUvdPq6AzLSiG5NctNxvP?USQtzrsxX9WuPG9JtqcNkf-oC2sk?MKr?Qibiqr?im5tdYw1zp495BE-aBjNegqhwPxS6U4rrNGzIG3btoCqn9d5UPP3B' : '3f0lSQ-6oQUN_T9CiLelWk_f2sTGhXzPzUF6Aouuvt1evjcLhYzwR3l7I279BiAxFogEJEKh7KR6Se0Cb3l0cZPSP0Osg')
raise "\n*******\n* Please run ./install to set this up\n*******" if Team10MiniProject::Application.config.secret_token.nil?
Team10MiniProject::Application.config.secret_key_base = '6df7be8615bdff68c8b6d5f6a9fc7249c486f9ebe017966713083ecb2a9398c1320571ac542ee92206dd6ebba26ecaf097f6034f20000ef5fc6baa929c75e2cf'


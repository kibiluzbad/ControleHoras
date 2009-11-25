# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ControleHoras_session',
  :secret      => '6f0740fe142f965fd091cb6223659acc51fa9d63867acd494091c5157ba125821754f31aea50aa161f16dfc850ce541029f8a2e23661fe9836bba3e219488a76'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

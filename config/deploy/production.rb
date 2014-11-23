set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '178.62.28.141', user: 'deploy', roles: %w{web app db}

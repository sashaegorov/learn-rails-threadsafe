daemonize false
environment ENV['RACK_ENV'] || 'development'
workers 4
threads 1, 1
port 9090
bind 'tcp://0.0.0.0'

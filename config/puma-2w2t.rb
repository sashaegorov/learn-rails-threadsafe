daemonize false
environment ENV['RACK_ENV'] || 'development'
workers 2
threads 2, 2
port 9090
bind 'tcp://0.0.0.0'

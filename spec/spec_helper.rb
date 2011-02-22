current_path = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(current_path, '..', 'lib')

require 'rspec'
require 'remote'
require 'net/ssh'

@@config = { }

def config
  @@config
end

config[:ssh] = File.join(current_path, "/support/ssh.conf")

# remove the default file paths
3.times { Net::SSH::Config.default_files.shift }

Net::SSH::Config.default_files.unshift(config[:ssh])

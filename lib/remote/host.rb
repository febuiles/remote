module Remote
  class Host
    attr_accessor :hostname, :user, :port, :name
    def initialize(name, host, config_file=nil)
      user, hostname, port = Host.parse_host(host)

      @name = name
      @user = user
      @hostname = hostname
      @port = port
      @config_file = config_file || "~/.ssh/config"
    end

    def self.add(name, host, config_file=nil)
      user, hostname, port = Host.parse_host(host)
      name = name
      config_file = config_file

      raise Net::SSH::Exception if !Net::SSH::Config.for(name).empty?

      File.open(config_file, "a+") do |f|
        f.write "Host #{name}\n Hostname #{hostname}\n User #{user}\n"
      end
    end

    def port
      @port || 22
    end

    protected
    def Host.parse_host(host)
      user, other = host.split("@")
      hostname, port = other.split(":")
      [user, hostname, port]
    end
  end
end

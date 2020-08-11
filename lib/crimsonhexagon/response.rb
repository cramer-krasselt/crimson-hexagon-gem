module CrimsonHexagon
  module Response
    def self.create( response_hash )
      data = response_hash.dup rescue response_hash
      data.extend( self )
      data.instance_exec do
        %w{pagination status}.each do |k|
          response_hash.public_send(k).tap do |v|
            instance_variable_set("@#{k}", v) if v
          end
        end
      end
      data
    end

    attr_reader :pagination
    attr_reader :status
  end
end

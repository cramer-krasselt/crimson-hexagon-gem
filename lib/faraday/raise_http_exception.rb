require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise CrimsonHexagon::BadRequest, error_message_400(response)
        when 404
          raise CrimsonHexagon::NotFound, error_message_400(response)
        when 429
          raise CrimsonHexagon::TooManyRequests, error_message_400(response)
        when 500
          raise CrimsonHexagon::InternalServerError, error_message_500(response, "Something is technically wrong.")
        when 502
          raise CrimsonHexagon::BadGateway, error_message_500(response, "The server returned an invalid or incomplete response.")
        when 503
          raise CrimsonHexagon::ServiceUnavailable, error_message_500(response, "CrimsonHexagon is rate limiting your requests.")
        when 504
          raise CrimsonHexagon::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        body = ::JSON.parse(body)
      end

      if body.nil?
        nil
      elsif body['message'] and not body['message'].empty?
        ": #{body['message']}"
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end

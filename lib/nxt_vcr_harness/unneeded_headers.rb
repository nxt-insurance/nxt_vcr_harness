module NxtVcrHarness
  module UnneededHeaders
    REQUEST_HEADERS = %w[
      Accept-Encoding
      Expect
    ].freeze

    BROWSER_HEADERS = [
      /Access-Control-.+/i,
      'Alt-Svc',
      /(X-)?Content-Security-Policy.*/i,
      'Cache-Control',
      'Etag',
      'Expect-Ct',
      'NEL',
      'Referrer-Policy',
      'Report-To',
      'Reporting-Endpoints',
      'Set-Cookie',
      'Strict-Transport-Security',
      'Vary',
      /X-(Content-Type-Options|Download-Options|Frame-Options|Permitted-Cross-Domain-Policies|Webkit-Csp|Xss-Protection)/i,
    ].freeze

    SERVER_DETAILS = [
      'Date',
      'Server',
      'Server-Timing',
      /X-(Powered-By|Runtime|Served-By|Server-Elapsed)/i,
      /X-Envoy-(Decorator-Operation|Upstream-Service-Time)/i,
      'Via',
    ].freeze

    AMAZON_HEADERS = [
      /X-Amzn?-.+/i,
      'X-Cache',
    ].freeze

    CLOUDFLARE_HEADERS = [
      /Cf-.+/i,
    ].freeze

    RESPONSE_HEADERS = [
      *BROWSER_HEADERS,
      *SERVER_DETAILS,
      *AMAZON_HEADERS,
      *CLOUDFLARE_HEADERS,
    ].freeze

    def default_headers_to_strip
      {
        requests: UnneededHeaders::REQUEST_HEADERS.dup,
        responses: UnneededHeaders::RESPONSE_HEADERS.dup,
      }
    end

    def strip(headers_hash, headers_to_strip)
      headers_hash.delete_if do |k, v|
        headers_to_strip.any? do |header|
          case header
          when String
            k == header || k == header.downcase
          when Regexp
            k.match?(header)
          else
            raise ArgumentError, "Unexpected key type in headers_to_strip hash: #{header}"
          end
        end
      end
    end

    module_function :default_headers_to_strip, :strip
  end
end
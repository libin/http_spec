require "forwardable"

module HTTPSpec
  module DSL
    module Resource
      extend Forwardable

      def self.define_actions(*methods)
        methods.each do |method|
          define_method(method) do |route, body=nil, headers=nil|
            example.metadata[:method] = method
            example.metadata[:route] = route
            example.metadata[:request_headers] = headers
            example.metadata[:request_body] = body
            do_request
          end
        end
      end

      define_actions :get, :post, :put, :patch, :delete, :options, :head

      def_delegators :client, :status, :response_headers, :response_body

      alias response_status status

      def do_request
        metadata = example.metadata

        method = metadata[:method]
        route = metadata[:route]
        request_headers = metadata[:request_headers]
        request_body = metadata[:request_body]

        client.send(method, route, request_body, request_headers)

        metadata[:status] = status
        metadata[:response_headers] = response_headers
        metadata[:response_body] = response_body
      end
    end
  end
end

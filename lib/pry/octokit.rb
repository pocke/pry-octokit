require "pry/octokit/version"
require 'pry'
require 'octokit'
require 'yaml'

class Pry
  module Octokit
    class << self
      def client
        @client ||= (
          conf = YAML.load_file(File.expand_path("~/.config/hub"))
          token = conf['github.com'].first['oauth_token']
          ::Octokit::Client.new(access_token: token).tap do |client|
            if debug?
              client.middleware = Faraday::RackBuilder.new do |builder|
                builder.use ::Octokit::Middleware::FollowRedirects
                builder.use ::Octokit::Response::RaiseError
                builder.use ::Octokit::Response::FeedParser
                builder.response :logger
                builder.adapter Faraday.default_adapter
              end
            end
          end
        )
      end

      def debug?
        ENV['PRY_OCTOKIT_DEBUG']
      end

      def run(path, _pry_)
        path, options = path.split(' ', 2)
        path = eval %Q!"#{path}"!
        options = parse_options options
        method = options.delete :method
        c = client
        auto_paginate = options.delete :auto_paginate
        if auto_paginate
          puts "With auto_paginate" if debug?
          c = c.dup
          c.auto_paginate = true
        end
        resp =
          if auto_paginate
            c.__send__ :paginate, path, options
          else
            c.__send__ :request, method, path, options
          end
        _pry_.last_result = resp
        _pry_.show_result resp
      end

      def parse_options(options)
        eval("{#{options}}").tap do |opt|
          opt[:method] ||= :get
        end
      end
    end
  end
end

Pry.commands.block_command(%r!^gh/(.+)!) do |path|
  Pry::Octokit.run(path, _pry_)
end

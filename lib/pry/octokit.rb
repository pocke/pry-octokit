require "pry/octokit/version"
require 'pry'
require 'octokit'
require 'yaml'

class Pry
  module Octokit
    def self.client
      @client ||= (
        conf = YAML.load_file(File.expand_path("~/.config/hub"))
        token = conf['github.com'].first['oauth_token']
        ::Octokit::Client.new(access_token: token)
      )
    end
  end
end

Pry.commands.block_command(%r!^gh/(.+)!) do |path|
  path = eval %Q!"#{path}"!
  resp = Pry::Octokit.client.get path
  _pry_.last_result = resp
  _pry_.show_result resp
end

require 'rubygems'
require 'bundler/setup'
require_relative 'lib/hook_gitlab'

include GitLabTwitterHook

Bundler.require

configure do
  CONFIG = GitLabTwitterHook::Config.load
  ClientTwitter = GitLabTwitterHook::ClientTwitter.load
  ClientBitly = GitLabTwitterHook::ClientBitly.load
end

post '*' do
  access_token = params[:access_token]
  if access_token != CONFIG[:access_token]
    halt 403, "Please provide correct access_token."
  else
    messages = Parser.new(json: request.body.read, shortener: ClientBitly).messages
    messages.each do |tweet|
      ClientTwitter.update(tweet)
    end
    ""
  end
end

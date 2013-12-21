require 'cuba'
require 'garufa/cuba/authentication'
require 'garufa/message'
require 'garufa/subscriptions'

module Garufa
  Cuba.plugin Cuba::Authentication

  ApiServer = Cuba.new do

    on "apps/:app_id" do |app_id|

      authenticate

      # Events
      on post, "events" do
        message = Message.new(JSON.parse(req.body.read))
        options = { data: message.data, socket_id: message.socket_id }
        Subscriptions.notify message.channels, message.name, options
        res.write "{}"
      end

      # Channels
      on get, "channels" do
      end

      on get, "channels/:channel" do
      end

      # Users
      on get, "channels/:channel/users" do
      end
    end
  end
end

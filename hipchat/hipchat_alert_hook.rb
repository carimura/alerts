require 'hipchat'

payload = JSON.parse(@payload)

puts "payload --> #{payload}"

token = ''
client = HipChat::Client.new(token)

# Settings
room = "Test Room"
from = "IronMQ Alerts"
low = 10
middle = 50

# Construct the alert message
queue = payload["source_queue"]
messages = payload["queue_size"]

color = case messages.to_i
          when 0..low
            "green"
          when low..middle
            "yellow"
          else
            "red"
        end


alert_message = "Queue #{queue} now has #{messages} messages in it."

# Send the alert
client[room].send(from, alert_message, :color => color, :notify => true)


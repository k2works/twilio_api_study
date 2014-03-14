require 'rubygems'
require 'twilio-ruby'

# put your own credentials here - from twilio.com/user/account
account_sid = 'xxxxxxxxxxxx'
auth_token = 'xxxxxxxxxxxx'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@call = @client.account.calls.create(
  :from => '+8150xxxxxxxxxxxx', # From your Twilio number
  :to => '+81xxxxxxxxxxxx', # To any number
  # Fetch instructions from this URL when the call connects
  :url => 'http://xxxx.xxxx.xx.xx/twilioapistudy/20140314/kakigi/twilio.xml'
  )

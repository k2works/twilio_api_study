Twilioハンズオン
===================

# 目的 #
Twilioハンズオン広島

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| OS X           |10.8.5        |             |
| ruby           |ruby-2.0.0-p247    |        |
| rvm            |1.24.0        |             |
| heroku-toolbelt   |3.1.1      |             |

+ [Twilioにユーザー登録をしている]()

# 構成 #
+ [セットアップ](#chap1)
+ [ログイン](#chap2)
+ [アプリケーションのデプロイ](#chap3)

# 詳細 #

## <a name="1">セットアップ</a> ##

    $ rvm use ruby-2.0.0-p247
    $ rvm gemset create twilio_api_study
    $ rvm use ruby-2.0.0-p247@twilio_api_study
    $ gem install twilio-ruby

## <a name="2">着信(inbound)</a> ##

twilioに電話をかける時は頭の81を入れないで050から番号を入れる

>twilio.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <Response>
    <Say language="ja-JP">こんにちは</Say>Say>
    <Say language="fr-FR">Chapeau!</Say>Say>
    <Say language="ko-KR">반갑습니다.</Say>Say>
    </Response>

## <a name="3">発信(outbound) </a>##

account_sid,auth_tokenはダッシュボードのACCOUNT SID とAUTH TOKEN  
TwiML URLは電話番号のRequest URL  
:fromはtwilioの電話番号-TWILIO電話番号  
:toは検証済み電話番号-電話番号  

>outbound.rb

    require 'rubygems'
    require 'twilio-ruby'

    # put your own credentials here - from twilio.com/user/account
    account_sid = 'Twilio Account SID'
    auth_token = 'Twilio Auth Token'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    @call = @client.account.calls.create(
    :from => '+8150xxxxyyyy', # From your Twilio number
    :to => '+8180xxxxyyyy', # To any number
    # Fetch instructions from this URL when the call connects
    :url => 'TwiML URL'
    )

curl

    curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/your account sid/Calls.xml' \
    -d 'From=%2B8150xxxxxxxx' \
    -d 'To=%2B8180xxxxxxxx' \
    -d 'Url=http%3A%2F%2F[twiML URL]' \
    -u [Account SID]:[Auth Token]

## <a name="4">音声を録音し、再生（確認）</a> ##

    <?xml version="1.0" encoding="UTF-8"?>
    <Response>
    <Say language="ja-JP">録音を開始します。録音完了後、電話のボタンを押してください。</Say>
    <Record action="twiml-Record-Play.php" />
    </Response>

[サンプル：Say：音声合成](https://gist.github.com/hunnycode/5924457)

[サンプル：SMS：アメリカの電話番号が必要です。](https://gist.github.com/hunnycode/5907102)

[サンプル：curl：APIから電話をかけられます。](https://gist.github.com/hunnycode/5466238)

[サンプル：IVR：自動応答システムも簡単](https://gist.github.com/hunnycode/5848189)

[サンプル：Client：パソコンなどのデバイスを電話器に返信させましょう！](https://github.com/hunnycode/TC-browser-phone)

[サンプル：ClickToCall：ウェブから電話をかけてみましょう！](https://github.com/hunnycode/twilio_sample)

# <a name="5">参照</a> #

[Twilio Docs - クイックスタート](https://jp.twilio.com/docs/quickstart)

[Twilioのライブラリ](https://jp.twilio.com/docs/libraries)

[発表資料](http://www.slideshare.net/JoohounSong/twilio-apijaws-26194846)


require "rubygems"
require "bundler/setup"
require "discordrb"
Bundler.require
TOKEN = 'NzcyNzg3MDMxNjAzNjc1MTQ2.X5_wAg.Pl60E9sRQXv446T-vuoKK3jFdrQ'
CLIENT_ID = 772787031603675146

# 通知用のチャンネルID
inform_channel = 773449700443029564

# bot
bot = Discordrb::Commands::CommandBot.new token: TOKEN, client_id: CLIENT_ID, prefix:'/'

# 誰かがvoice channelに出入りしたら発火
bot.voice_state_update do |event|
    # 発火させたユーザー名を取得
    user = event.user.name

    # もしデータが空だと抜けていったチャンネルを取得
    if event.channel == nil then
        # チャンネル名を取得
        channel_name = event.old_channel.name

        # 退出したことをinform_channelに通知
        bot.send_message(inform_channel, "@everyone #{user} が #{channel_name}を退出しました。")
    else
        # チャンネル名を取得
        channel_name = event.channel.name

        # 入室したことをinform_channelに通知
        bot.send_message(inform_channel, "@everyone #{user} が #{channel_name}に入室しました。")
    end
end

# botを起動
bot.run

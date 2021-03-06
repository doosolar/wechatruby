# frozen_string_literal: true

# 素材管理
class Wechatruby::Client::Messages
  SEND_URL = 'https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=%{token}'
  TEMPLATE_URL = 'https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=%{token}'
  def initialize(token)
    @token = token
  end

  def send_text(user_id, text)
    url = format(SEND_URL, token: @token)
    pp url
    params = {
      touser: user_id,
      msgtype: 'text',
      text: {
        content: text
      }
    }.to_json
    resp = RestClient.post(url, params, content_type: :json, accept: :json)
    JSON.parse resp.body
  end

  # 发送图片给客户
  # {"errcode"=>0, "errmsg"=>"ok"}
  #
  def send_image(user_id, media_id)
    url = format(SEND_URL, token: @token)
    pp url
    params = {
      touser: user_id,
      msgtype: 'image',
      image: {
        media_id: media_id
      }
    }.to_json
    resp = RestClient.post(url, params, content_type: :json, accept: :json)
    JSON.parse resp.body
  end

  def send_template(params)
    url = format(TEMPLATE_URL, token: @token)
    pp params.to_json
    pp url
    resp = RestClient.post(url, params.to_json, content_type: :json, accept: :json)
    JSON.parse resp.body
  end
end

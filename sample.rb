require "json" # jsonモジュール追加
require "base64" # base64エンコードモジュール追加
require "digest/sha2"

# hash = {
# 	"configid" => 1234, #GMOの固定設定ID
# 	"transacrion" =>
# 	{
# 		"OrderID" => 60, # 変動 注文ID
# 		"Amount" => 3000　# 変動 利用金額
# 	}
# }
gmourl = "https://link.mul-pay.jp/v1/plus/shopid/checkout/"
# OrderID => @order.id, Amout => @order.amount
hash = { "configid" => "minton", "transacrion" => { "OrderID" => "60", "Amount" => 3000 } }
puts "#{hash}\n"

# 実行パラメータセット（json形式）生成
json_str = hash.to_json
puts "#{json_str}あ\n"

# 実行パラメータセットをbase64エンコード
encoded = Base64.urlsafe_encode64(json_str)
puts "#{encoded}い\n"

# エンコードされた値とショップパスワードを結合してSHA256ハッシュを算出
pass = "shoppass" # 実際はenvファイルとかに書いて環境変数使ったほうがいいかも
add = encoded + pass
sha256 = Digest::SHA256.hexdigest(add)
puts "#{sha256}\n"

#ハッシュ付き実行パラメータセット文字列
hash_str = encoded + "." + sha256
puts hash_str

#リンクタイプ決済URL作成
linktype_url = gmourl + hash_str
puts linktype_url

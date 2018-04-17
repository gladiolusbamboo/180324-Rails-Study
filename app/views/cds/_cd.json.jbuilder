# JSON形式で表示する場合の部分テンプレート
json.extract! cd, :id, :jan, :title, :price, :artists, :released, :is_major, :created_at, :updated_at
# extract!は
# json.jan cd.jan
# json.title cd.title
# ︙
# json.updated_at cd.updated_at
# を省略した形
# 更に省略して
# json.(book, :isbn, :title, …　:updated_at)
# みたいにも書ける

# cd_urlはビューヘルパー
json.url cd_url(cd, format: :json)

# 出力結果
# [{
#   "id":1,
#   "jan":"978-4-7741-8411-1",
#   "title":"充分未来",
#   "price":2980.0,
#   "artists":[
#     {
#       "id":1,
#       "listener_id":1,
#       "name":"KICK THE CAN CREW",
#       "birth":"1997-01-01",
#       "url":"kick_url",
#       "ctype":null,
#       "photo":null,
#       "created_at":"2018-04-17T04:23:27.902Z",
#       "updated_at":"2018-04-17T04:23:27.902Z"
#     }
#   ],
#   "released":"2016-09-30",
#   "is_major":false,
#   "created_at":"2018-04-17T04:23:27.928Z",
#   "updated_at":"2018-04-17T04:23:27.928Z",
#   "url":"http://localhost:3000/cds/1.json"
# },
# ︙
# ]

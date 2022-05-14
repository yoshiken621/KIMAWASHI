# データベースの情報をjson形式に変換する処理
json.array!(@events) do |event|
  json.id event.id
  json.start event.date
  json.image_url url_for event.image.variant(resize_to_fill: [50, 50])
  json.description '会った人: '+ event.met_person
end

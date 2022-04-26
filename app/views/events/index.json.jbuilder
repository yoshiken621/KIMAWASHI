json.array!(@events) do |event|
  json.id event.id
  json.start event.date
  json.image_url url_for event.image.variant(resize_to_fill: [50,50])
end
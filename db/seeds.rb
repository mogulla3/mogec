# Create users and stores
1.upto(100) do |n|
  user = User.create(name: "user#{n}")
  puts "created user: #{user.attributes}"

  store = Store.create(name: "store#{n}")
  puts "created store: #{store.attributes}"
end

# Create items
price_range = 100.step(30000, 100).to_a
Store.select(:id, :name).each do |store|
  Random.rand(1..20).times do |n|
    item = Item.create(name: "item#{n}-#{store.name}", price: price_range.sample, store_id: store.id)
    puts "created item of #{store.name}: #{item.attributes}"
  end
end

# Create orders
item_from = Item.first.id
item_to = Item.last.id
user_from = User.first.id
user_to = User.last.id
now = Time.now.to_i
max_offset = 86400 * 30 * 18 # 1年半前(sec)
2000.times do |n|
  item = Item.select(:id).where("id = ?", Random.rand(item_from..item_to)).first
  user = User.select(:id).where("id = ?", Random.rand(user_from..user_to)).first
  ordered_at = Time.at(now - Random.rand(0..max_offset))
  order = Order.create(item_id: item.id, user_id: user.id, ordered_at: ordered_at)
  puts "created order: #{order.attributes}"
end
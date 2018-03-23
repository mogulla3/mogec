# Create users and stores
1.upto(100) do |n|
  if user = User.create(name: "user#{n}")
    puts "created user: #{user.attributes}"
  end

  if store = Store.create(name: "store#{n}")
    puts "created store: #{store.attributes}"
  end
end

# Create items
price_range = 100.step(30000, 100).to_a
Store.all.each do |store|
  Random.rand(1..20).times do |n|
    if item = Item.create(name: "item#{n}-#{store.name}", price: price_range.sample, store_id: store.id)
      puts "created item of #{store.name}: #{item.attributes}"
    end
  end
end

# Create orders
item_from = Item.first.id
item_to = Item.last.id
user_from = User.first.id
user_to = User.last.id
1000.times do |n|
  item = Item.where("id = ?", Random.rand(item_from..item_to)).first
  user = User.where("id = ?", Random.rand(user_from..user_to)).first
  if order = Order.create(item_id: item.id, user_id: user.id, ordered_at: DateTime.now)
    puts "created order: #{order.attributes}"
  end
end
if Order.all.count == 0
  50.times do |i|
    Order.create(user_detail_id: UserDetail.pluck(:id).sample)
  end
end

if Product.all.count == 0
  25.times do |i|
    Product.create(name: "Product #{i + 1}", description: "Product #{i + 1}", user_id: User.where(is_seller: true).pluck(:id).sample)
  end
end

if OrderProduct.all.count == 0
  sellers = User.where(is_seller: true).collect(&:user_detail)
  buyers = UserDetail.all
  orders = Order.all
  products = Product.all
  50.times do |i|
    buyer = buyers.sample
    product = products.sample
    seller = product.user.user_detail
    OrderProduct.create(order_id: orders.pluck(:id).sample, product_id: product.id, buyer_id: buyer.id, seller_id: seller.id)
  end
end

if Address.all.count == 0
  users = UserDetail.pluck(:id)
  50.times do |i|
    address_hash = {pincode: (0...6).map { ('0'..'9').to_a[rand(26)] }.join, flat_no: (0...10).map { ('0'..'9').to_a[rand(26)] }.join, landmark: (0...15).map { ('a'..'z').to_a[rand(26)] }.join,
    localtiy: (0...15).map { ('a'..'z').to_a[rand(26)] }.join, area: (0...15).map { ('a'..'z').to_a[rand(26)] }.join, town: (0...15).map { ('a'..'z').to_a[rand(26)] }.join}
    Address.create(user_detail_id: users.sample, full_name: (0...15).map { ('a'..'z').to_a[rand(26)] }.join, mobile: (0...10).map { ('0'..'9').to_a[rand(26)] }.join, is_home_adress: [true, false].sample, address: address_hash)
  end
end
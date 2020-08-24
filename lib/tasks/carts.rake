namespace :carts do
  desc "Delete old carts"
  task deleteoldcarts: :environment do
    # puts 'delete_old_carts!'
    puts "count: #{Cart.delete_old_carts.count}"
    puts "time now: #{Time.zone.now}"
    Cart.delete_old_carts.find_each { |cart| cart.destroy } if Cart.delete_old_carts.count > 0
  end
end
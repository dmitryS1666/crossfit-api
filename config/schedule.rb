set :environment, :production
set :output, {:error => "log/cron.log", :standard => "log/cron.log"}


every 2.minute do
  rake 'carts:deleteoldcarts'
end

# every :sunday, at: '12pm' do
#   rake 'carts:deleteoldcarts'
# end
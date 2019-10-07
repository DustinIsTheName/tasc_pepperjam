task :send_csv => :environment do
  Order_CSV.send_csv
end

task :sync_data => :environment do
  SyncData.activate
end
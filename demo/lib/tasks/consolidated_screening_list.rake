namespace :consolidated_screening_list do
  desc "Test"
  task search: :environment do
    client = ConsolidatedScreeningList::Client.new api_key: ENV["TRADE_API_KEY"]
    puts "\n===== Searching for 'John Smith' ====="
    puts "Results found: #{client.search(name: "John Smith").present?}"
    puts "===== Searching for 'FooBar McGoo' ====="
    puts "Results found: #{client.search(name: "FooBar McGoo").present?}"
  end
end

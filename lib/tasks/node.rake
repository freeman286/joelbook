namespace :node do
  desc "TODO"
  task :start => :environment do
    exec "cd realtime; nohup node realtime-server.js > node.log 2>&1&"
    puts "started"
  end

  desc "TODO"
  task :stop => :environment do
    exec "kill -9 `pgrep node`;"
    puts "stopped"
  end

end

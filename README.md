##Deploy instructions

### For Digital Ocean

Forward port 80 to port 3000
```
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3000
```

Precompile assets
```
RAILS_ENV=production rake assets:precompile:primary
```

###Start server
```
thin start -d -e production
rake node:start
```

###Stop server
```
thin stop
rake node:stop
```

###Check logs
```
tail -f log/thin.log
```

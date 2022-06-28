filter and route logs with regexp
write log to mongo

```shell
LINE=$(cat syslog.pos)
tail -n +$LINE  -f /var/log/syslog | grep "2020"
```


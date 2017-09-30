
outConfFile=/etc/telegraf/telegraf.conf

echo '
[global_tags]

[agent]
  interval = "5s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "5s"
  flush_jitter = "0s"
  debug = false
  quiet = false
' > ${outConfFile}
echo 'hostname = "'`cat /data/config/name`'"' >> ${outConfFile}
echo 'omit_hostname = false'                  >> ${outConfFile}

echo '
[[outputs.influxdb]]
  urls = ["http://121.42.180.48:8086"] # required
  database = "proxy_pool_slave" # required
  precision = "s"
  retention_policy = "default"
  write_consistency = "any"
  timeout = "5s"
  username = "proxy_pool"
  password = "467njkyi8yi846kj78"
'>> ${outConfFile}

echo '
[[inputs.tail]]
  files = ["/var/log/squid/telegraf.log"]
  from_beginning = false
  data_format = "influx"
' >> ${outConfFile}

service telegraf restart

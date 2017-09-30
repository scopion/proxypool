import redis

print("hell world")
r = redis.Redis(host="127.0.0.1", port=6379,db=0, password="L96vSojiCi2GHeFr")
iplist= r.hkeys("ipCounts")
maclist = []


for i in iplist:
	ipkey = 'IP_' + i
	print ipkey
	ipmac = r.hget(ipkey,"mac")
	print ipmac
	if (ipmac == None):
		r.hdel("ipCounts",i)
		iplist.remove(i)

	else
	maclist.append(ipmac)
print len(iplist)
print maclist

maclist_check = set(maclist)

for item in maclist_check:
	num = maclist.count(item)
	print num
	if (num > 1):
		print "warning,mac>1"+item
		for deli in iplist:
			delipkey = 'IP_' + deli			
			if(item == r.hget(delipkey,"mac")):
				r.hdel("ipCounts",deli)						


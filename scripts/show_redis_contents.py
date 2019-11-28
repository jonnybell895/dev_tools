import redis

base_expiry_days = 90
r = redis.from_url('redis://localhost:6379', db=0)

min_expiry_seconds = base_expiry_days * 24 * 60 * 60
max_expiry_seconds = (base_expiry_days + 10) * 24 * 60 * 60

steps = 20
step_size = (max_expiry_seconds - min_expiry_seconds) / 20

dist = [0 for x in range(0, steps)]

for key in r.scan_iter():
    iter = 1
    expiry_seconds = min_expiry_seconds + (step_size * iter)
    while expiry_seconds <= max_expiry_seconds:
	expiry_seconds = min_expiry_seconds + (step_size * iter)
	if r.ttl(key) <= expiry_seconds:
            dist[iter-1] += 1
	    break
	iter += 1

iter = 1
for slice in dist:
    print "{} <={}".format(slice, min_expiry_seconds + (step_size * iter))
    iter += 1

print "Sum: {}".format(sum(dist))

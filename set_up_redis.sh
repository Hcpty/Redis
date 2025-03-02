set -eux

# Install Redis
pkg install databases/redis

# Configure Redis
sed -i -e 's/bind 127.0.0.1 -::1/# bind 127.0.0.1 -::1/' /usr/local/etc/redis.conf
sed -i -e 's/# aclfile \/etc\/redis\/users.acl/aclfile \/etc\/redis\/users.acl/' /usr/local/etc/redis.conf
mkdir /usr/local/etc/redis/
touch /usr/local/etc/redis/users.acl
echo 'user default on '$PASSWORD' ~* &* +@all' >> /usr/local/etc/redis/users.acl
echo 'user server on '$PASSWORD' ~* &* +@all' >> /usr/local/etc/redis/users.acl

# Enable auto start
sysrc redis_enable="YES"

# Start
service redis start

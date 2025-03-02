set -eux

echo 'Install Redis'
pkg install databases/redis

echo 'Configure Redis'
sed -i -e 's/bind 127.0.0.1 -::1/# bind 127.0.0.1 -::1/' /usr/local/etc/redis.conf
sed -i -e 's/# aclfile \/etc\/redis\/users.acl/aclfile \/etc\/redis\/users.acl/' /usr/local/etc/redis.conf
mkdir /usr/local/etc/redis/
touch /usr/local/etc/redis/users.acl

echo 'Configure the default user'
echo 'user default on '$PASSWORD' ~* &* +@all' >> /usr/local/etc/redis/users.acl

echo 'Add the server user'
echo 'user server on '$PASSWORD' ~* &* +@all' >> /usr/local/etc/redis/users.acl

echo 'Enable auto start'
sysrc redis_enable='YES'

echo 'Start Redis'
service redis start

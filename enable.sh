PUB=""
GWAY=""
NEWFACE=""
ip addr add $PUB dev $NEWFACE
ip link set dev $NEWFACE up
ip route add $GWAY dev $NEWFACE
ip route add default via $GWAY dev $NEWFACE
echo "nameserver 1.1.1.1" > /etc/resolv.conf

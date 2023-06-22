
#create network namespace
sudo ip netns add red
sudo ip netns add blue

#create virtual ethernat cable
sudo ip link add veth-red type veth peer name veth-blue

#connect each veth interface with the specific namespace
sudo ip link set veth-red netns red
sudo ip link set veth-blue netns blue

#set ip address for each interface
sudo ip -n red addr add 10.0.0.1/24 dev veth-red
sudo ip -n blue addr add 10.0.0.2/24 dev veth-blue

#start (up) the each interface for specific namespace
sudo ip -n red link set veth-red up
sudo ip -n blue link set veth-blue up

# set the default ip address
sudo ip netns exec red ip route add default via 10.0.0.1 dev veth-red
sudo ip netns exec blue ip route add default via 10.0.0.2 dev veth-blue

# ping for the specific ip address
sudo ip netns exec red ping 10.0.0.3

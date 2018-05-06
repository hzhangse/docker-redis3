sudo docker cp redisNode1:/usr/local/bin/redis-trib.rb ./redis-trib.rb
sudo chmod +x redis-trib.rb
redis-trib create --replicas 1 172.19.0.40:6379 172.19.0.41:6379 172.19.0.42:6379 172.19.0.43:6379 172.19.0.44:6379 172.19.0.45:6379

./redis-trib.rb add-node 172.19.0.26:6379 172.19.0.20:6379
./redis-trib.rb add-node slave 172.19.0.26:6379 172.19.0.20:6379
./redis-trib.rb add-node --slave --master-id d7c0c3a490df4a95548c9841c5fa817e3d1c9853 172.19.0.27:6379 172.19.0.20:6379

./redis-trib.rb del-node 172.19.0.20:6379 d7c0c3a490df4a95548c9841c5fa817e3d1c9853 

redis-cli -p 6379 cluster nodes|grep master
./redis-trib.rb check 172.19.0.26:6379 

Adding replica 172.19.0.23:6379 to 172.19.0.20:6379
Adding replica 172.19.0.24:6379 to 172.19.0.21:6379
Adding replica 172.19.0.25:6379 to 172.19.0.22:6379
M: a2b3f3eda93489b61db8a1061e0f095023f061f0 172.19.0.20:6379
   slots:0-5460 (5461 slots) master
M: d8673589bc55698a7c6f4276bd6662393e7ffca1 172.19.0.21:6379
   slots:5461-10922 (5462 slots) master
M: 2ec1dcd51242d08495b2a5ac23c1f3a4210d0fa3 172.19.0.22:6379
   slots:10923-16383 (5461 slots) master
S: 4c07ddc33776487d23d5c5f2b68c2030105d023b 172.19.0.23:6379
   replicates a2b3f3eda93489b61db8a1061e0f095023f061f0
S: 570c830cb067c7a366447b5185165b29b5430214 172.19.0.24:6379
   replicates d8673589bc55698a7c6f4276bd6662393e7ffca1
S: b2ce299f247037cbc3e22d7d5755cf987f8be713 172.19.0.25:6379
   replicates 2ec1dcd51242d08495b2a5ac23c1f3a4210d0fa3
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join...
>>> Performing Cluster Check (using node 172.19.0.20:6379)
M: a2b3f3eda93489b61db8a1061e0f095023f061f0 172.19.0.20:6379
   slots:0-5460 (5461 slots) master
   1 additional replica(s)
S: 4c07ddc33776487d23d5c5f2b68c2030105d023b 172.19.0.23:6379
   slots: (0 slots) slave
   replicates a2b3f3eda93489b61db8a1061e0f095023f061f0
M: 2ec1dcd51242d08495b2a5ac23c1f3a4210d0fa3 172.19.0.22:6379
   slots:10923-16383 (5461 slots) master
   1 additional replica(s)
S: b2ce299f247037cbc3e22d7d5755cf987f8be713 172.19.0.25:6379
   slots: (0 slots) slave
   replicates 2ec1dcd51242d08495b2a5ac23c1f3a4210d0fa3
M: d8673589bc55698a7c6f4276bd6662393e7ffca1 172.19.0.21:6379
   slots:5461-10922 (5462 slots) master
   1 additional replica(s)
S: 570c830cb067c7a366447b5185165b29b5430214 172.19.0.24:6379
   slots: (0 slots) slave
   replicates d8673589bc55698a7c6f4276bd6662393e7ffca1


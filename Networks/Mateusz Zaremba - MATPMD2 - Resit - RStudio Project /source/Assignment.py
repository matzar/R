import networkx as nx
import csv
import matplotlib.pyplot as plt
from operator import itemgetter
from matplotlib.pyplot import figure

BO_graph = nx.Graph()
with open('barack_obama.csv','r') as BO:
    columns = next(BO, None)# skip the header row
    BO_graph = nx.parse_edgelist(BO, delimiter=',', create_using=nx.Graph(),
        nodetype=str, data=(('type',str),('weight', float),('book',int)))

# 1. Network size metrics
# This will print the network's:
# - Number of edges
# - Number of nodes
# - Average degree
print(nx.info(BO_graph))

# 2. Network structure metrics
# degree('node id', node degree)
highest_degree = max(BO_graph.degree(), key=lambda x : x[1])
sorted_degree = sorted(BO_graph.degree(), key=lambda x : x[1], reverse=True)
print('Top 10 highest degrees:', sorted_degree[:10])
print('Highest degree:', highest_degree)

# 3. Network Density
density = nx.density(BO_graph)
print('Network density is:', density)

# 4. Shortest Path Between Two Nodes
# 4.1 Shortest Path Between Top Two Highest Degree Nodes
# Find ids of top 2 nodes with the highest degree
top_two_degree_path = nx.shortest_path(BO_graph, source=sorted_degree[0][0], target=sorted_degree[1][0])

print(f'Shortest path between node {sorted_degree[0][0]} and node {sorted_degree[1][0]}:', top_two_degree_path)
print('Length of this path:', len(top_two_degree_path)-1)

# 4.2 Shortest Path Between Nodes With The Highest and The Loewst Degree
highest_lowest_degree_path = nx.shortest_path(BO_graph, source=sorted_degree[0][0], target=sorted_degree[-1][0])

print(f'Shortest path between node with the highest degree of {sorted_degree[0][1]}\
    and the node with the lowest degree of {sorted_degree[-1][1]}:',
    highest_lowest_degree_path)
print('Length of this path:', len(highest_lowest_degree_path)-1)

# 5. Improving the network visualisation
import community

from collections import Counter

parts = community.best_partition(BO_graph)
values = [parts.get(node) for node in BO_graph.nodes()]

print(Counter(values)) # counts the frequency of community labels in list called 'values'
print(f"Sizes of the communities range from {min(Counter(values).items(), key=lambda i : i[1])}")
print(f"to {max(Counter(values).items(), key=lambda i : i[1])}")

# 6.	Network Structure Connectivity
if nx.is_connected(BO_graph):
    print("Barack Obama network is fully connected and has no sub-networks")
else:
    print("Barack Obama network is NOT fully connected")

# # 7. Network Hubs/Brokers
# 7.1 Node betweenness
betweenness_dict = nx.betweenness_centrality(BO_graph) # Run betweenness centrality

# Assign each to an attribute in your network
nx.set_node_attributes(BO_graph, betweenness_dict, 'betweenness')

sorted_betweenness = sorted(betweenness_dict.items(), key=itemgetter(1), reverse=True)

print("Top 20 nodes by betweenness centrality:")
for i in sorted_betweenness[:20]:
    print(i)
# ('2506', 0.9894963970281675)
# ('9302', 0.12282820504741454)
# ('4143', 0.03144816600031404)
# ('531', 0.014458790942881458)
# ('8314', 0.012228936015603632)
# ('5481', 0.012089805713811068)
# ('8514', 0.01143955576907501)
# ('8994', 0.01074238462967798)
# ('6132', 0.010564400310717656)
# ('6675', 0.010020075931062244)
# ('6764', 0.00992018852706437)
# ('6030', 0.009737847345230805)
# ('6950', 0.009462296727656857)
# ('1507', 0.008941272482221355)
# ('8744', 0.008733213582767565)
# ('8983', 0.00870091464615793)
# ('4785', 0.007255999233019585)
# ('3095', 0.006960902069389381)
# ('2121', 0.006417014842841436)
# ('6042', 0.006294194986287823)

# # 7.2 Node closeness
closeness_dict = nx.closeness_centrality(BO_graph) # Run betweenness centrality

# Assign each to an attribute in your network
nx.set_node_attributes(BO_graph, closeness_dict, 'closeness')

sorted_closeness = sorted(closeness_dict.items(), key=itemgetter(1), reverse=True)

print("Top 20 nodes by closeness centrality:")
for i in sorted_closeness[:20]:
    print(i)
# ('2506', 0.6994988014818043)
# ('6675', 0.4373297002724796)
# ('8744', 0.4362993838347227)
# ('6042', 0.4361413043478261)
# ('3095', 0.4359636017927475)
# ('2121', 0.43580576548852784)
# ('7336', 0.43576632426806644)
# ('360', 0.43572689018596444)
# ('7543', 0.43572689018596444)
# ('8474', 0.43572689018596444)
# ('3021', 0.43572689018596444)
# ('4801', 0.43572689018596444)
# ('1712', 0.43572689018596444)
# ('3015', 0.43572689018596444)
# ('9551', 0.43572689018596444)
# ('2479', 0.43572689018596444)
# ('2605', 0.43572689018596444)
# ('1362', 0.43572689018596444)
# ('2062', 0.43572689018596444)
# ('1282', 0.43572689018596444)

# # 7.3 Node eigenvector centrailty
# using: nx.eigenvector_centrality()
# error: PowerIterationFailedConvergence: (PowerIterationFailedConvergence(...), 'power iteration failed to converge within 100 iterations')
# use: nx.eigenvector_centrality_numpy()
eigenvector_dict = nx.eigenvector_centrality_numpy(BO_graph) # Run eigenvector centrality

nx.set_node_attributes(BO_graph, eigenvector_dict, 'eigenvector')

sorted_eigenvector = sorted(eigenvector_dict.items(), key=itemgetter(1), reverse=True)

print("Top 20 nodes by eigenvector centrality:")
for b in sorted_eigenvector[:20]:
    print(b)
# Top 20 nodes by eigenvector centrality:
# ('2506', 0.7070870193199195)
# ('8983', 0.00849854648835321)
# ('8744', 0.008303338474194982)
# ('2448', 0.008282421743093698)
# ('4143', 0.00828021476365458)
# ('9059', 0.008273793471604151)
# ('2774', 0.008199348551970947)
# ('6042', 0.008196572014760562)
# ('3984', 0.008194304473514229)
# ('2823', 0.008192920035432085)
# ('3616', 0.008186795640893304)
# ('6726', 0.008180060554781302)
# ('8088', 0.008180055356654904)
# ('7717', 0.00817923599483863)
# ('6373', 0.008179232137282876)
# ('5942', 0.008178413157339203)
# ('8904', 0.008178413157339201)
# ('1113', 0.008178413157339201)
# ('8122', 0.008178413157339201)
# ('7517', 0.008178203137675302)
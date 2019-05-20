from hw3 import *

if __name__=="__main__":
    num_v = 4
    num_e = 4
    
    adj_list = [ [] for _ in range(num_v) ]
    adj_mat = [ [ 0 for _ in range(num_v) ] for _ in range(num_v) ]
    
    in_a = [ 0, 1, 2, 0 ]
    in_b = [ 1, 2, 0, 3 ]

    for e in zip(in_a,in_b):
        x,y = e
        adj_list[x].append(y)
        adj_mat[x][y] = 1
    
    ans1 = [ 0 for _ in range(num_v) ]
    scc1 = find_scc_with_adj_list(adj_list,num_v,num_e,ans1)
    for scc_id in range(scc1):
        for node_id in range(num_v):
            if ans1[node_id] == scc_id:
                    print(node_id,end=" ")
        print("")
    #answer should be 
        #0 1 2
        #3
    
    ans2 = [ 0 for _ in range(num_v) ]
    scc2 = find_scc_with_adj_mat(adj_mat,num_v,num_e,ans2)
    for scc_id in range(scc2):
        for node_id in range(num_v):
            if ans2[node_id] == scc_id:
                print(node_id,end=" ")
        print("")
    #answer should be 
        #0 1 2
        #3

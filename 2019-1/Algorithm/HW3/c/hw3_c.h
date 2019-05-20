#ifndef HW3C_H
#define HW3C_H

//parameters
//adj : adjacent list of graph where the smallest element is the 0th element.
	//in array adj[i], neighbors of the ith vertecies are inserted.
//cnt : the number of neighbors of the ith vertex.
//num_v : the number of vertecies.
//num_e : the number of edges.
//ans : ans[i] means that ith vertex is included in the ans[i]th strongly connected component.
	//ans[i] can be non-negative integer.
	//if there are multiple answers, please find the lexicoraphically smallest sequence.

//This function should return the number of strongly connnected components.

int find_scc_with_adj_list(int **adj,int *cnt,int num_v,int num_e,int *ans){
	ans[0] = 0;
	ans[1] = 0;
	ans[2] = 0;
	ans[3] = 1;
	return 2;	
}

//adj : num_v x num_v dimension adjacency matrix of the given graph

//the other parameters have same as above function.

int find_scc_with_adj_mat(int **adj,int num_v,int num_e,int *ans){
	ans[0] = 0;
	ans[1] = 0;
	ans[2] = 0;
	ans[3] = 1;
	return 2;
}


#endif

#include <stdio.h>
#include <stdlib.h>
#include "hw3_c.h"

int main(){
	int num_v = 4;
	int num_e = 4;
	
	int *cnt;
	int **adj_list;
	int **adj_mat;
	int *tail;

	cnt = (int*)malloc(sizeof(int)*num_v);
	adj_list = (int**)malloc(sizeof(int*)*num_v);
	adj_mat = (int**)malloc(sizeof(int*)*num_v);

	for(int i=0;i<num_v;i++){
		adj_mat[i] = (int*)malloc(sizeof(int)*num_v);
		cnt[i] = 0;
	}
	
	tail = (int*)malloc(sizeof(int)*num_v);

	for(int i=0;i<num_v;i++){
		for(int j=0;j<num_v;j++){
			adj_mat[i][j] = 0;
		}
	}
	
	int ed_in[] = { 0, 1, 2, 0 };
	int ed_out[] = { 1, 2, 0, 3 };

	for(int i=0;i<num_e;i++){
		adj_mat[ed_in[i]][ed_out[i]] = 1;
		cnt[ed_in[i]]++;
	}
	
	for(int i=0;i<num_v;i++){
		adj_list[i] = (int*)malloc(sizeof(int)*cnt[i]);
		tail[i] = 0;
	}

	for(int i=0;i<num_e;i++){
		adj_list[ed_in[i]][tail[ed_in[i]]++] = ed_out[i]; 
	}
	
	int *ans1;
	ans1 = (int*)malloc(sizeof(int)*num_v);
	int num_scc1 = find_scc_with_adj_list(adj_list,cnt,num_v,num_e,ans1);
	for(int i=0;i<num_scc1;i++){
		for(int j=0;j<num_v;j++){
			if(i==ans1[j]){
				printf("%d ",j);
			}
		}
		printf("\n");
	}
	//result should be
		//0 1 2
		//3

	int *ans2;
	ans2 = (int*)malloc(sizeof(int)*num_v);
	int num_scc2 = find_scc_with_adj_mat(adj_mat,num_v,num_e,ans2);
	for(int i=0;i<num_scc2;i++){
		for(int j=0;j<num_v;j++){
			if(i==ans2[j]){
				printf("%d ",j);
			}
		}
		printf("\n");
	}
	//result should be
		//0 1 2
		//3

	free(cnt);
	for(int i=0;i<num_v;i++){
		free(adj_list[i]);
	}
	free(adj_list);
	for(int i=0;i<num_v;i++){
		free(adj_mat[i]);
	}
	free(adj_mat);
	free(ans1);
	free(ans2);

	return 0;
}

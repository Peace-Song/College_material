#ifndef HW2
#define HW2

#include <stdlib.h>

int cmp(const void *a, const void *b){
	int n1 = *(int*)a;
	int n2 = *(int*)b;
	if(n1 < n2){
		return -1;
	}
	else if(n1 > n2){
		return 1;
	}
	else{
		return 0;
	}
}

int v[10000];
int cnt;

void init(){
	cnt = 0;
}

int os_insert(int x){
    for(int i=0;i<cnt;i++){
		if(x==v[i]){
			return 0;
		}
	}
	v[cnt++] = x;
	return x;
}

int os_delete(int x){
    int k = 0;
	for(int i=0;i<cnt;i++){
		if(v[i]==x){
			k = 1;
		}
		else{
			v[i-k] = v[i];
		}
	}
	if(k==1){
		--cnt;
		return x;
	}
	else{
		return 0;
	}
}

int os_select(int i){
    if(i-1<cnt){
		qsort(v,cnt,sizeof(int),cmp);
        return v[i-1];
    }
    else{
        return 0;
    }   
}

int os_rank(int x){
	qsort(v,cnt,sizeof(int),cmp);
	for(int i=0;i<cnt;i++){
		if(v[i]==x){
			return i + 1;
		}
	}
	return 0;
}

int check(int opt_seq[], int in_seq[], int out_seq[], int n){
    init();
    for(int i=0;i<n;i++){
		if(opt_seq[i]==0){
            if(os_insert(in_seq[i])!=out_seq[i]){
                return 0;
            }
        }
        else if(opt_seq[i]==1){
            if(os_delete(in_seq[i])!=out_seq[i]){
                return 0;
            }
        }
        else if(opt_seq[i]==2){
            if(os_select(in_seq[i])!=out_seq[i]){
                return 0;
            }
        }
        else if(opt_seq[i]==3){
            if(os_rank(in_seq[i])!=out_seq[i]){
                return 0;
            }
        }
    }
    return 1;
}

#endif


#ifndef HW2
#define HW2

#include <vector>
#include <algorithm>

std::vector < int > v;

void init(){
    v.clear();
}

int os_insert(int x){
    for(auto e:v){
        if(x==e){
            return 0;
        }
    }
    v.emplace_back(x);
    return x;
}

int os_delete(int x){
    for(auto it=v.begin();it!=v.end();it++){
        if(*it==x){
            v.erase(it);
            return x;
        }
    }
    return 0;
}

int os_select(int i){
    if(i-1<v.size()){
        std::sort(v.begin(),v.end());
        return v[i-1];
    }
    else{
        return 0;
    }   
}

int os_rank(int x){
	std::sort(v.begin(),v.end());
    for(size_t i=0;i<v.size();i++){
        if(v[i]==x){
            return i + 1;
        }
    }
    return 0;
}

bool check(int opt_seq[], int in_seq[], int out_seq[], int n){
    init();
    for(int i=0;i<n;i++){
		if(opt_seq[i]==0){
            if(os_insert(in_seq[i])!=out_seq[i]){
                return false;
            }
        }
        else if(opt_seq[i]==1){
            if(os_delete(in_seq[i])!=out_seq[i]){
                return false;
            }
        }
        else if(opt_seq[i]==2){
            if(os_select(in_seq[i])!=out_seq[i]){
                return false;
            }
        }
        else if(opt_seq[i]==3){
            if(os_rank(in_seq[i])!=out_seq[i]){
                return false;
            }
        }
    }
    return true;
}

#endif





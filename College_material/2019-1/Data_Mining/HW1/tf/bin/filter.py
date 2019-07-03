#!/usr/bin/env python

"""
Filter top-50 follower countings
"""

import struct

from pydoop.mapreduce.pipes import run_task, Factory
from pydoop.mapreduce.api import Mapper, Reducer


class FilterMapper(Mapper):

    def map(self, context):
        person, follower = context.key, context.value
        follower = struct.unpack("i", follower)[0]
        fp_pair = (follower, str(person))
        context.emit(1, fp_pair)
         

class FilterReducer(Reducer):

    def reduce(self, context):
        fp_list = list(context.values)
        fp_list.sort(reverse=True)
        counter = 0
        
        for fp_pair in fp_list:
            counter += 1
            if counter > 50: break
            context.emit(fp_pair[1], fp_pair[0])
        

if __name__ == "__main__":
    factory = Factory(FilterMapper, FilterReducer)
    run_task(factory)

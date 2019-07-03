#!/usr/bin/env python

import struct

from pydoop.mapreduce.pipes import run_task, Factory
from pydoop.mapreduce.api import Mapper, Reducer

"""
Count followers of each node
Input : directed graph
    e.g.) "3   4" indicates that person 3 has 4 followers.
Output : (destination, follower count)
    e.g.) "4 2" node 4 has 2 followers.
"""


class DstCountMapper(Mapper):

    def map(self, context):
        # Implements your codes
        w = context.value.split()
        dst = w[1]

        context.emit(dst, 1)


class DstCountReducer(Reducer):

    def reduce(self, context):
        # Implements your codes
        s = sum(context.values)
        context.emit(context.key.encode(), struct.pack("i", s))
        

if __name__ == "__main__":
    factory = Factory(DstCountMapper, DstCountReducer)
    run_task(factory, auto_serialize=False)

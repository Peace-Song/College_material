#!/usr/bin/env python

"""
Impelements non-symmetric fellow-shop
Input : directed graph
    e.g.) "3   4" indicates that person 3 has 4 followers.
Output : (node, node)
    e.g.) "1 2" node 1 => node 2 is non-symmetric
"""
# DOCS_INCLUDE_START
import pydoop.mapreduce.api as api
import pydoop.mapreduce.pipes as pipes


class Mapper(api.Mapper):

    def map(self, context):
        # implements your code
        node1, node2 = context.value.split()[0], context.value.split()[1]
        if node1 > node2: context.emit(node2, node1)
        else: context.emit(node1, node2)

class Reducer(api.Reducer):

    def reduce(self, context):
        # implements your code
        singletons = set()
        seen = set()
        for dst in context.values:
            if dst not in seen:
                seen.add(dst)
                singletons.add(dst)
            elif dst in seen:
                singletons.remove(dst)

        for dst in singletons:
            context.emit(context.key, dst)



FACTORY = pipes.Factory(Mapper, reducer_class=Reducer)


def main():
    pipes.run_task(FACTORY)


if __name__ == "__main__":
    main()

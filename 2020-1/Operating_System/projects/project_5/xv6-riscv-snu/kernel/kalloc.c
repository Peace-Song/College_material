// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

#define REL_PA(pa)  ((uint64) pa - KERNBASE)
#define INDEX(rel_pa) ((uint64) rel_pa >> PGSHIFT)

#ifdef SNU
uint64 freemem = 0;
#endif

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
  uint16 refcnts[(PHYSTOP - KERNBASE) >> PGSHIFT];
} kmem;

void
kinit()
{
  initlock(&kmem.lock, "kmem");
  freerange(end, (void*)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  if(get_refcnt((void *) pa) > 1){
    decr_refcnt((void *) pa);
    return;
  }

  // decr_refcnt((void *) pa);

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
#ifdef SNU
  freemem++;
#endif
  release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
#ifdef SNU
  {
    kmem.freelist = r->next;
    freemem--;
    kmem.refcnts[INDEX(REL_PA(r))] = 1;
  }
#else
    kmem.freelist = r->next;
#endif
  release(&kmem.lock);

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}

// PA5
int
get_refcnt(void *pa){
  return kmem.refcnts[INDEX(REL_PA(pa))];
}

void
incr_refcnt(void *pa){
  acquire(&kmem.lock);
  kmem.refcnts[INDEX(REL_PA(pa))]++;
  release(&kmem.lock);

  return;
}

void
decr_refcnt(void *pa){
  acquire(&kmem.lock);
  kmem.refcnts[INDEX(REL_PA(pa))]--;
  release(&kmem.lock);

  return;
}
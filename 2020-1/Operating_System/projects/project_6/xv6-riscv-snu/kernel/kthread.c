//--------------------------------------------------------------------
//
//  4190.307: Operating Systems (Spring 2020)
//
//  PA#6: Kernel Threads
//
//  June 2, 2020
//
//  Jin-Soo Kim
//  Systems Software and Architecture Laboratory
//  Department of Computer Science and Engineering
//  Seoul National University
//
//--------------------------------------------------------------------

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "proc.h"
#include "defs.h"

#ifdef SNU
int 
kthread_create(const char *name, int prio, void (*fn)(void *), void *arg)
{  
  int i, tid;
  struct proc *nth;
  struct proc *th = myproc();
  
  if((nth = allocthread()) == 0){
    return -1;
  }

  tid = nth->tid;

  nth->sz = th->sz;

  nth->parent = th->parent;

  for(i = 0; i < NOFILE; i++){
    if(th->ofile[i])
      nth->ofile[i] = th->ofile[i];
  }

  nth->cwd = th->cwd;

  safestrcpy(nth->name, name, sizeof(name));

  nth->context.ra = (uint64) threadret;
  nth->context.s10 = (uint64) fn;
  nth->context.s11 = (uint64) arg;

  nth->prio = prio;
  nth->base_prio = prio;

  nth->state = RUNNABLE;

  if(holding(&nth->lock))
    release(&nth->lock);

  if(th->prio > nth->prio)
    kthread_yield();

  return tid;
}

void 
kthread_exit(void)
{
  struct proc *th = myproc();

  acquire(&th->lock);

  th->xstate = 0;
  th->state = UNUSED;
  
  sched();

  panic("unused exit");
  return;
}

void
kthread_yield(void)
{
  struct proc *th = myproc();

  acquire(&th->lock);
  th->state = RUNNABLE;
  sched();
  release(&th->lock);
  return;
}

void
kthread_set_prio(int newprio)
{
  struct proc *th = myproc();

  // This thread was donated with higher priority
  acquire(&th->lock);

  if(th->prio != th->base_prio){
    // If new priority value is less than the current effective priority value,
    // that is, new priority is higher than the current effective priority,
    if(th->prio >= newprio){
      prio_cancel1(th);

      th->base_prio = newprio;
      th->prio = newprio;
    }
    else{
      th->base_prio = newprio;
    }
  }
  else{
    th->base_prio = newprio;
    th->prio = newprio;
  }

  release(&th->lock);

  kthread_yield();

  return;
}

int
kthread_get_prio(void)
{
  struct proc *th = myproc();
  int prio;

  acquire(&th->lock);
  prio = th->prio;
  release(&th->lock);

  return prio;
}
#endif


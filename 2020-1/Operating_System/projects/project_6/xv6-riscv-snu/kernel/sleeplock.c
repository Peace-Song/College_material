// Sleeping locks

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sleeplock.h"

struct donation ledger[NDONATION];
struct spinlock ledgerlock;

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
}

void
acquiresleep(struct sleeplock *lk)
{
  struct proc *th;
  struct proc *tgt_th;

  acquire(&lk->lk);
  while (lk->locked) {
    th = myproc();
    if(lk->tid != th->tid){
      tgt_th = findthread(lk->tid);

      prio_donate(lk, th, tgt_th);
    }

    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  lk->tid = myproc()->tid;
  release(&lk->lk);
}

void
releasesleep(struct sleeplock *lk)
{
  struct proc *th;

  acquire(&lk->lk);
  
  th = myproc();
  acquire(&th->lock);

  if(th->prio != th->base_prio){
    prio_cancel(lk, th);
  }

  release(&th->lock);

  lk->locked = 0;
  lk->pid = 0;
  lk->tid = 0;
  wakeup(lk);
  release(&lk->lk);
  
  kthread_yield();
}

int
holdingsleep(struct sleeplock *lk)
{
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
  release(&lk->lk);
  return r;
}

void
init_ledger(void)
{
  int i;

  for(i = 0; i < NDONATION; i++){
    ledger[i].lk = 0;
    ledger[i].donor_tid = 0;
    ledger[i].donee_tid = 0;
    ledger[i].old_prio = 0;
    ledger[i].prio = 0;
  }

  initlock(&ledgerlock, "ledger lock");
}

static struct donation *
find_donation(struct sleeplock *lk, struct proc *donee_th)
{
  int i;

  for(i = 0; i < NDONATION; i++){
    if(ledger[i].lk == lk && ledger[i].donee_tid == donee_th->tid)
      return &ledger[i];
  }

  return 0;
}

// Call with both threads' lock held.
void
prio_donate(struct sleeplock *lk, struct proc *donor_th, struct proc *donee_th)
{
  int i, j;
  struct donation *entry;

  acquire(&ledgerlock);
  for(i = 0; i < NDONATION; i++){
    // find an empty entry
    if(ledger[i].lk == 0){

      if(donee_th->prio != donee_th->base_prio){
        if(donee_th->prio <= donor_th->prio){
          release(&ledgerlock);
          return;
        }
        else{
          entry = find_donation(lk, donee_th);

          if(entry != 0)
            prio_cancel(lk, donee_th);
        }
      }

      ledger[i].lk = lk;
      ledger[i].donor_tid = donor_th->tid;
      ledger[i].donee_tid = donee_th->tid;
      ledger[i].old_prio = donee_th->prio;
      ledger[i].prio = donor_th->prio;

      donee_th->prio = ledger[i].prio;

      release(&ledgerlock);

      if(donee_th->chan != 0){
        for(j = i; j >= 0; j--){
          if(ledger[j].donor_tid == donee_th->tid){
            prio_donate(ledger[j].lk, donee_th, findthread(ledger[j].donee_tid));
          }
        }
      }

      return;
    }
  }
  release(&ledgerlock);

  panic("ledger full");
}

// Call with both threads' lock held.
void
prio_cancel(struct sleeplock *lk, struct proc *donee_th)
{
  int i, j;

  for(i = NDONATION-1; i >= 0; i--){
    if (ledger[i].lk == lk && \
        ledger[i].donee_tid == donee_th->tid){
      
      if(donee_th->prio < ledger[i].prio){
        for(j = 0; j < NDONATION; j++){
          if(ledger[j].donee_tid == donee_th->tid && ledger[j].old_prio == ledger[i].prio){
            ledger[j].old_prio = ledger[i].old_prio;
          }
        }
      }
      else if(donee_th->prio == ledger[i].prio){
        donee_th->prio = ledger[i].old_prio;
      }

      ledger[i].lk = 0;

      return;
    }
  }

  return;
}

void
prio_cancel1(struct proc *donee_th)
{
  int i;
  struct sleeplock *lk;


  for(i = NDONATION-1; i >= 0; i--){
    //acquire(&ledgerlock);
    if(ledger[i].donee_tid == donee_th->tid){
      lk = ledger[i].lk;
      //release(&ledgerlock);

      prio_cancel(lk, donee_th);
    }
    //else
      //release(&ledgerlock);
  }

  return;
}
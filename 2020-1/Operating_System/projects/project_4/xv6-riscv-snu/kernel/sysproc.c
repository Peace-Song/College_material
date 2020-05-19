#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if(argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

#ifdef SNU
uint64
sys_nice(void)
{
  // PA4: Fill here!
  struct proc *curr_p = myproc();
  struct proc *p;

  int pid = curr_p->tf->a0;
  int inc = curr_p->tf->a1;

  //printf("[DEBUG] sys_nice() called.\n");
  //printf("[DEBUG] pid == %d, inc == %d\n", pid, inc);

  // pid < 0 not allowed.
  if(pid < 0){
    //printf("[DEBUG] pid < 0 not allowed.\n");
    return -1;
  }

  pid = pid == 0 ? curr_p->pid : pid;

  // Find proc with pid. Raise error if unable to.
  if((p = findproc(pid)) == 0){
    //printf("[DEBUG] findproc() failed with pid == %d.\n", pid);
    return -1;
  }

  if(pid != curr_p->pid)
    acquire(&p->lock);

  // Check the nice value range.
  if(p->nice + inc > 19 || p->nice + inc < -20){
    if(pid != curr_p->pid)
      release(&p->lock);
    //printf("[DEBUG] nice value exceeds the range.\n");
    return -1;
  }

  //printf("[DEBUG] nice value before nice(): %d\n", p->nice);
  p->nice += inc;
  //printf("[DEBUG] nice value after nice(): %d\n", p->nice);

  if(pid != curr_p->pid)
    release(&p->lock);

  //printf("[DEBUG] sys_nice() exited.\n");

  return 0;
}

uint64
sys_getticks(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return getticks(pid);
}
#endif

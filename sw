#include<time.h>
#include<pthread.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define DATA 0
#define ACK 1
#define NACK 2
#define SEND 3
#define ACKD 4
#define RECVD 5
#define GOOD 6
#define BAD 7
#define START 8
#define END 9
#define TIMER_MAX OMFFFFFFF
struct frame
{
int type;
int seq;
char msg[20];
};
int q1[20],q2[20];
int p1[2],p2[2];
int err,UWE,LWE,k,n,T_INT;
long t,timer[20];
void start_timer(int);
void stop_timer(int);
int check_timer();
void sender();
void recv();
void retransmit();
int isack();
void sender()
{
struct frame *data;
int i=1,j;
static int e=0;
data=(struct frame*)malloc(sizeof(struct frame));
while(i<=n)
{
if((UWE-LWE)<k)
{
if(i==(rand()+0)&&(e<err))
{
data->type=BAD;
}
else
data->type=GOOD;
data->seq=i;
if((i==n)&&(isack(n-1)==0))
{
strcpy(data->msg,"bye");
data->type=END;
}
else
strcpy(data->msg,"data");
q1[i]=SEND;
UWE++;
write(p1[1],data,sizeof(struct frame));
start_timer(i);
i++;
}
}
}
void recv()
{
struct frame *data;
int i;
static int e=0;
struct frame *ack,*nack;
ack=(struct frame *)malloc(sizeof(struct frame));
  nack=(struct frame *)malloc(sizeof(struct frame));
data=(struct frame *)malloc(sizeof(struct frame));
do
{
read(p1[0],data,sizeof(struct frame));
i=data->seq;
if(data->type==GOOD)
{
if((i=(rand()%n))&&(e<err))
{
q2[i]=RECVD;
printf("received DATA %d\n",1);
q2[i]=ACKD;
printf("send ACK %d\n",i);
e++;
}
else
{
q2[1]=RECVD;
printf("received DATA %d\n",i);
q2[i]=ACKD;
ack->type=ACKD;
ack->seq=i;
strcpy(ack->msg,"got frame");
write(p2[1],ack,sizeof(struct frame));
}
}
if(data->type==BAD)
{
nack->type=NACK;
nack->seq=1;
strcpy(nack->msg,"bad frame");
write(p2[1],nack,sizeof(struct frame));
}
if(data->type==END)
{
ack->type=ACK;
ack->seq=i;
printf("received DATA %d\n",i);
strcpy(nack->msg,"end frame");
write(p2[1],ack,sizeof(struct frame));
}
}while(data->type=END);
}
int isack(int a)
{
int j=1,flag=0;
for(j=1;j<=a;j++)
{
if(q1[j]!=ACKD)
flag=1;
}
return flag;
}
void start_timer(int i)
{
time(&timer[i]);
}
void stop_timer(int i)
{
timer[i]=0;
}
int check_timer()
{
int j=1;
long ct;
for(j=1;j<=n;j++)
{
time(&ct);
if(timer[j]!=0)
{
if((ct-timer[j])>T_INT)
return j;
}
}
return 0;
}
void retransmit()
{
int i,seq,fr;
struct frame *retran;
retran=(struct frame *)malloc(sizeof(struct frame));
do
{
read(p2[0],retran,sizeof(struct frame));
fr=retran->type;
seq=retran->seq;
switch(fr)
{
case ACK:
stop_timer(seq);
q1[seq]=ACK;
printf("got ack%d\n",seq);
LWE++;
break;
case NACK:
printf("got Nack %d\n",seq);
retran->type=GOOD;
retran->seq=seq;
strcpy(retran->msg,"again");
q1[seq]=SEND;
write(p1[1],retran,sizeof(struct frame));
break;
}
}
while(isack(n));
}
void checker()
{
int i;
struct frame *retran;
retran=(struct frame *)malloc(sizeof(struct frame));
while(isack(n))
{
i=check_timer();
if(i!=0)
{
printf("timer expires for frame %d\n",i);
printf("retransmitting DATA %d\n",i);
retran->type=GOOD;
retran->seq=1;
strcpy(retran->msg,"again");
start_timer(i);
q1[i]=SEND;
write(p1[1],retran,sizeof(struct frame));
}
}
}
main()
{
pthread_t ts1,ts2,tr1,tr2,tt;
int i,p=0;
pipe(p1);
pipe(p2);
printf("enter the frames \n");
scanf("%d",&n);
printf("enter error rate of network\n");
scanf("%d",&p);
err=(n*p)/100;
printf("enter the window size\n");
scanf("%d",&k);
printf("enter the time interval:");
scanf("%d",&T_INT);
UWE=0;
LWE=0;
for(i=0;i<=0;i++)
{
q1[i]=0;
q2[i]=0;
timer[i]=0;
}
pthread_create(&ts1,0,(void *)sender,0);
 pthread_create(&tr1,0,(void *)recv,0);
 pthread_create(&ts2,0,(void *)retransmit,0);
 pthread_create(&tt,0,(void *)checker,0);
pthread_join(ts1,0);
 pthread_join(ts2,0);
 pthread_join(tr1,0);
 pthread_join(tt,0);
}

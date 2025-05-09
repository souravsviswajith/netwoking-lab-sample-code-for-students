#include<stdio.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<fcntl.h>
void process_request(int);
main (int argc,char *arg[])
{
struct sockaddr_in ser,cli;
int sd,slen,nsd;
if((sd = socket(AF_INET,SOCK_STREAM,0))<0)
{
perror("socket creation");
exit(1);
}
bzero((char *)&ser,sizeof(ser));
ser.sin_family=AF_INET;
ser.sin_port=htons(7026);
ser.sin_addr.s_addr=inet_addr("127.0.0.1");
if(bind(sd, (struct sockaddr *)&ser,sizeof(ser)) <0)
{
perror("binding");
exit(1);
}
listen(sd,5);
for(; ;)
{
int clen=sizeof(cli);
nsd=accept(sd, (struct sockaddr *)&cli,&clen);
if(nsd<0)
perror("accept");
if(fork()==0)
{
close(sd);
process_request(nsd);
exit(0);
}
close(nsd);
}
}
void process_request(int sd)
{
char *buf1,*buf2,*buf3,*tmp,*user,*domain,*hostname;
char *data;
int n,flag=0,i=0;
buf2=(char *)malloc(1000);
buf3=(char *)malloc(1000);
printf("connection established........\nserver ready......");
printf("\nsend data");
for(; ;)
{
n=read(sd,buf2,1000);
buf2[n]='\0';
printf("\nmessage from client :%s\n",buf2);
printf("server reply");
scanf("%s",buf3);
write(sd,buf3,1000);
printf("\nmessage send to client:",buf3);
}
}

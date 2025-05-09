#include<stdio.h>
#include<sys/socket.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<fcntl.h>
#include<errno.h>
#define MAXLINE 1000
#define SERV_PORT 5090
#define SA struct sockaddr
int dg_cli(int sockfd,const SA *pservaddr,socklen_t servlen)
{
int n;
char sendline[MAXLINE],recvline[MAXLINE+1];
system("clear");
printf("\n.....client....");
printf("\n<client message to server>");
while(fgets(sendline,MAXLINE,stdin)!=NULL)
{
sendto(sockfd,sendline,strlen(sendline),0,pservaddr,servlen);
n=recvfrom(sockfd,recvline,MAXLINE,0,NULL,NULL);
printf("\n<reply from server>%s");
printf("\n<next message to server>:");
}
}
main(int argc,char **argv)
{
int sockfd;
struct sockaddr_in servaddr;
if(argc!=2)
perror("usage:updcli<ipaddress>");
bzero(&servaddr,sizeof(servaddr));
servaddr.sin_family=AF_INET;
servaddr.sin_port=htons(SERV_PORT);
inet_pton(AF_INET,argv[1],&servaddr.sin_addr);
sockfd=socket(AF_INET,SOCK_DGRAM,0);
dg_cli(sockfd,(SA *) &servaddr,sizeof(servaddr));
exit(0);
}

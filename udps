#include<stdio.h>
#include<sys/socket.h>
#include<stdlib.h>
#include<string.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<fcntl.h>
#define MAXLINE 1000
#define SERV_PORT 5090
#define SA struct sockaddr
int dg_echo(int sockfd,SA *pcliaddr,socklen_t clilen)
{
int n;
socklen_t len;
char mesg[MAXLINE],data[50];
for(; ;)
{
len=clilen;
n=recvfrom(sockfd,mesg,MAXLINE,0,pcliaddr,&len);
mesg[n]='\0';
system("clear");
printf("\n......server......");
printf("\n<message from client>:%s",mesg);
printf("\n<repiy to client>:");
gets(data);
sendto(sockfd,data,strlen(data),0,pcliaddr,len);
}
}
main(int argc,char **argv)
{
int sockfd;
struct sockaddr_in servaddr,cliaddr;
sockfd=socket(AF_INET,SOCK_DGRAM,0);
printf("\nsocket created");
bzero(&servaddr,sizeof(servaddr));
servaddr.sin_addr.s_addr=htonl(INADDR_ANY);
servaddr.sin_port=htons(SERV_PORT);
bind(sockfd, (SA*) &servaddr,sizeof(servaddr));
printf("\n binding successful....\n");
dg_echo(sockfd, (SA*) &cliaddr,sizeof(cliaddr));
}

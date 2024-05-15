#include<sys/socket.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<arpa/inet.h>
main (int argc,char *argv[])
{
struct sockaddr_in cli;
int sd,n,i=0;
char *buf1,*buf2;
buf1=(char *)malloc(1000);
buf2=(char *)malloc(1000);
if((sd=socket (AF_INET,SOCK_STREAM,0)) <0)
{
printf("cannot create socket\n");
exit(1);
}
bzero((char *)&cli,sizeof(cli));
cli.sin_family=AF_INET;
cli.sin_port=htons(7026);
cli.sin_addr.s_addr=inet_addr("127.0.0.1");
if(connect(sd, (struct sockaddr *) &cli,sizeof(cli)) <0)
{
printf("connection failed");
exit(1);
}
else
{
for( ; ;)
{
printf("\nenter the message for the server:");
scanf("%s",buf2);
write(sd,buf2,strlen(buf2));
printf("\nmessage send to server:%s\n",buf2);
n=read(sd,buf1,1000);
buf1[n]='\0';
printf("message from server:%s",buf1);
}
}
}

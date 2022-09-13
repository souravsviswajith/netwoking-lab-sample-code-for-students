#include<stdio.h>
int main()
{
int n,i,j,k,a[10][10],b[10][10];
printf("enter the no of nodes:");
scanf("%d",&n);
for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
    if(i!=j)
    {
    printf("enter the distance b/w the host %d %d:",i+1,j+1);
    scanf("%d",&a[i][j]);
    }
    else
        a[i][j]=0;
}
}
for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
printf("%d\t",a[i][j]);
}
printf("\n");
}
for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
b[i][j]=a[i][j];

}
}
for(k=0;k<n;k++)
{
for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
if(i!=j)
if(a[i][j]>a[i][k]+a[k][j])
b[i][j]=a[i][k]+a[k][j];
}
printf("the o/p matrix is :\n");
for(i=0;i<n;i++)
{
for(j=0;j<n;j++)
{
printf("%d\t",b[i][j]);
}
printf("\n");
}
}
}
}

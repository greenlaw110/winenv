#include <stdio.h>
#include <time.h>

int main ()
{
  time_t rawtime;
  struct tm * timeinfo;
  char buffer [10];

  time ( &rawtime );
  timeinfo = localtime ( &rawtime );
  timeinfo->tm_yday+=7;

  strftime (buffer,10,"%U",timeinfo);
  puts (buffer);
  
  return 0;
}


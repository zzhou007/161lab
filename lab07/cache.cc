#include <iostream> // std::cin
#include <stdio.h> // printf
#include <vector> // vector
#include <math.h> // log2
#include <algorithm> // std::find
#include <climits> // ULLONG_MAX

#define  BLOCK_SIZE     16

typedef struct {
  std::vector<unsigned long long> time;
  std::vector<unsigned long long> tag;
}set; // for direct mapping, set is of 1 block
unsigned long long offset_mask(int places) {
  // assumes places >= 1
  unsigned long long m = 1;
  for (int i = 1; i < places; ++i)
    m = (m << 1) + 1;
  return m;
}
int lru (std::vector<unsigned long long> time)
{
  unsigned long long min = ULLONG_MAX;
  int ret = -1;
  for (unsigned int i = 0; i < time.size(); ++i)
    if (min > time[i])
    {
      ret = i;
      min = time[i];
    }
  return ret;
}
unsigned long long rl[10000000];
unsigned long long INPUTS=0;
double miss_rate (int policy, int CACHE_SIZE, unsigned int ASSOC) {
    unsigned long long current_time = 1;
    int number_of_blocks = CACHE_SIZE / BLOCK_SIZE / ASSOC;
    int offset_sz = (int)log2(BLOCK_SIZE); // bits
    int index_sz = (int)log2(number_of_blocks);

    set cache[number_of_blocks];

    unsigned long long read_line;
    int total = 0, miss = 0;
    int rl_index = 0;
    while (rl_index <= INPUTS) {
      read_line = rl[rl_index++];
      ++total;
      unsigned long long tag   = read_line >> (index_sz + offset_sz);
      unsigned long long index = read_line >> offset_sz;
      index = index & offset_mask(index_sz);

      std::vector<unsigned long long>::const_iterator it;
      it = std::find(cache[index].tag.begin(), cache[index].tag.end(), tag);
      if (it == cache[index].tag.end())
      {
        ++miss;
        cache[index].tag.push_back(tag);
        cache[index].time.push_back(current_time++);

        if  (cache[index].tag.size() > ASSOC) {
          if (policy) { //FIFO
            cache[index].tag.erase(cache[index].tag.begin());
            cache[index].time.erase(cache[index].time.begin());
          }
          else { // LRU
            int overwrite = lru(cache[index].time);
            if (overwrite < 0)
              std::cout << "noooo";
            cache[index].tag.erase(cache[index].tag.begin() +overwrite);
            cache[index].time.erase(cache[index].time.begin() +overwrite);
          }
        }
      }
      else // write time on hit for LRU
      {
        int time_index = it - cache[index].tag.begin();
        cache[index].time[time_index] = current_time++;
      }
   }
   return (double)miss / (double)(total);
}

int main()
{
  while(std::cin >> std::hex >> rl[INPUTS++]);
   printf("    LRU Replacement Policy\n  ");
   for (int i = 1024; i <= 16384; i*=2)
      printf("%d  ",i);
   for (int i = 1; i <= 8; i*=2)
   {
     printf("\n%d ",i);
     for (int j = 1024; j <= 16384; j*=2)
     {
       printf("%0.2lf ", miss_rate(0,j,i) * 100.0);
     }
   }
   printf("\n\n");
   printf("    FIFO Replacement Policy\n  ");
   for (int i = 1024; i <= 16384; i*=2)
      printf("%d  ",i);
   for (int i = 1; i <= 8; i*=2)
   {
     printf("\n%d ",i);
     for (int j = 1024; j <= 16384; j*=2)
     {
       printf("%0.2lf ", miss_rate(1,j,i) * 100.0);
     }
   }
   printf("\n");
   return 0;
}

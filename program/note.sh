#======c++ debug lib======
cd ../tools
auto-extract dbg-macro-master.zip 
cd dbg-macro-master
sudo cp dbg.h /usr/include/dbg.h
#site:https://github.com/sharkdp/dbg-macro

#======hash function======
unsigned long hash(unsigned char *str) {
  unsigned long hash = 5381;
  int c;
  while (c = *str++)
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
  return hash;
}

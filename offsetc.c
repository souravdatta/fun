#include <stdio.h>
#include <stdlib.h>

#define OFFSET(type, member) \
    (unsigned long)&(((type *)0)->member)
    
#define CONTAINER_OF(ptr, type, member) \
    (type *)((char *)ptr - OFFSET(type, member))

struct list_head { int abc; };

struct foo_bar
{
    int a;
    int b;
    char *str;
    struct foo_bar *next;
    struct foo_bar *prev;
    struct list_head *list;
};

main()
{
    struct foo_bar *addr;
    struct foo_bar *foo = malloc(sizeof(struct foo_bar));
    foo->a = 101;
    foo->list = malloc(sizeof(struct list_head));
    
    addr = CONTAINER_OF(&(foo->list), struct foo_bar, list);
    printf("%p %d", addr, addr->a);
    
    return 0;    
}

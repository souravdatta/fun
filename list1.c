#include <stdio.h>
#include <stdlib.h>

#define ENTRY(ptr, type, member) \
    (type *)((char *)ptr - (unsigned long)&(((type *)0)->member))
    
struct list_node
{
    struct list_node *next;
    struct list_node *prev;
};

#define LIST_NODE_INIT(node) \
    node.next = NULL; \
    node.prev = NULL;
    
void list_node_add(struct list_node *start, struct list_node *what)
{
    struct list_node *it;
    
    if (start == NULL || what == NULL)
        return;
    
    for (it = start; it->next != NULL; it = it->next)
        ;
        
    it->next = what;
    what->prev = it;
}
    
/* user data */

struct todo
{
    int task_id;
    struct list_node node;
};

int main()
{
    struct todo t1, t2, t3;
    struct list_node *it;
    struct todo *entry;
    
    t1.task_id = 101;
    LIST_NODE_INIT(t1.node);
    
    t2.task_id = 102;
    LIST_NODE_INIT(t2.node);
    
    t3.task_id = 103;
    LIST_NODE_INIT(t3.node);
    
    list_node_add(&t1.node, &t2.node);
    list_node_add(&t1.node, &t3.node);
    
    for (it = &t1.node; it != NULL; it = it->next) {
        entry = ENTRY(it, struct todo, node);
        printf("%d\n", entry->task_id);
    }
    
    return 0;
}

#ifndef __LIST_NODE__
#define __LIST_NODE__

#include <stdlib.h>

struct list_node
{
    void *root; /* pointer to root which contains this node */
    struct list_node *next; /* pointer to the next node */
    struct list_node *prev; /* pointer to previous node */
};

struct list_node *ln_new_node(void *root_ptr)
{
    struct list_node *n = malloc(sizeof(struct list_node));
    if (n == NULL)
        return NULL;
    n->next = NULL;
    n->prev = NULL;
    n->root = root_ptr;
    return n;
}

void *ln_get_root(const struct list_node *n)
{
    return n->root;
}

/* Adds a new node at the end of the list */
struct list_node *ln_add_node(struct list_node **start, struct list_node *next)
{
    struct list_node *it;
    
    if (*start == NULL) {
        /* No node yet, next is our starting node */
        *start = next;
        return next;
    }

    it = *start;
    while (it->next != NULL)
        it = it->next;

    it->next = next;
    if (next != NULL)
        next->prev = it;
    next->next = NULL; /* Just in case... */
    return next;
}

/* Removes a node */
void ln_del_node(struct list_node **start, struct list_node *n)
{
    /* A start node? */
    if (*start == n) {
        *start = n->next;
        n->next = NULL;
        return;
    }

    /* A Null node? */
    if (n == NULL)
        return;

    n->prev->next = n->next;
    if (n->next != NULL) {
        n->next->prev = n->prev;
    }
}


#define for_each(start, ptr) for ((ptr) = (start); (ptr) != NULL; (ptr) = (ptr)->next)

#endif

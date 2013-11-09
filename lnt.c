#include <stdio.h>
#include <stdlib.h>
#include "list_node.h"

struct task
{
    int task_id;

    struct list_node *t_node;
    struct list_node *c_node;
};

static struct list_node *tasks = NULL;
static struct list_node *ctasks = NULL;

struct task *new_task(int id)
{
    struct task *t = malloc(sizeof(struct task));
    t->task_id = id;
    t->t_node = ln_new_node(t);
    t->c_node = ln_new_node(t);
    return t;
}

void add_task(struct task *t)
{
    ln_add_node(&tasks, t->t_node);
}

void add_completed(struct task *t)
{
    ln_add_node(&ctasks, t->c_node);
}

int main()
{
    struct task *t1, *t2, *t3, *t4, *t5;
    struct list_node *it;

    t1 = new_task(101);
    t2 = new_task(102);
    t3 = new_task(103);
    t4 = new_task(104);
    t5 = new_task(105);

    add_task(t1);
    add_task(t2);
    add_task(t3);
    add_task(t4);
    add_task(t5);

    add_completed(t3);
    add_completed(t1);
    add_completed(t5);


    ln_del_node(&tasks, t1->t_node);
    ln_del_node(&tasks, t3->t_node);
    ln_del_node(&ctasks, t5->c_node);
    
    for_each(tasks, it) {
        struct task *tsk = ln_get_root(it);
        printf("%d\n", tsk->task_id);
    }

    for_each(ctasks, it) {
        struct task *tsk = ln_get_root(it);
        printf("c%d\n", tsk->task_id);
    }

    return 0;
}



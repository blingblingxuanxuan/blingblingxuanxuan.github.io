#include <linux/init.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/uaccess.h>
#include <linux/slab.h>


static int proc_open (struct inode *proc_inode, struct file *proc_file)
{
    printk(":into open!\n");
    return 0;
}

static ssize_t proc_read (struct file *proc_file, char __user *proc_user, size_t n, loff_t *loff)
{
    printk(":into read");
    return 0;
}

static ssize_t proc_write (struct file *proc_file, const char __user *proc_user, size_t n, loff_t *loff)
{
    char *c = kmalloc(512, GFP_KERNEL);
    copy_from_user(c, proc_user, 4096);
    printk(":into write!\n");
    return 0;
}

static struct proc_ops test_op = {
    .proc_open = proc_open,
    .proc_read = proc_read,
    .proc_write = proc_write,
};

static int __init mod_init(void)
{
    proc_create("test1", S_IRUGO|S_IWUGO, NULL, &test_op);
    printk(":proc init over!\n");
    return 0;
}

module_init(mod_init);
//---------------------------------
//File Name    : helloworld.c
//Author       : aico
//Mail         : 2237616014@qq.com
//Github       : https://github.com/TBBtianbaoboy
//Site         : https://www.lengyangyu520.cn
//Create Time  : 2021-12-03 14:06:25
//Description  : 
//----------------------------------
#include <linux/module.h>
#include <linux/kernel.h>

static int __init lkp_init(void)
{
    printk("helloworld,i am in kernel\n");
    return 0;

}

static void __exit lkp_exit(void)
{
    printk("exit\n");
}

/* MODULE_AUTHOR("aico"); */
/* MODULE_DESCRIPTION("hello world"); */
MODULE_LICENSE("GPL");
module_init(lkp_init)
module_exit(lkp_exit)





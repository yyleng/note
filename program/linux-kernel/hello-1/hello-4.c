//---------------------------------
//File Name    : hello-4.c
//Author       : aico
//Mail         : 2237616014@qq.com
//Github       : https://github.com/TBBtianbaoboy
//Site         : https://www.lengyangyu520.cn
//Create Time  : 2021-12-03 18:06:23
//Description  : 
//----------------------------------
#include <linux/init.h> /* Needed for the macros */ 
#include <linux/kernel.h> /* Needed for pr_info() */ 
#include <linux/module.h> /* Needed by all modules */ 
 
MODULE_LICENSE("GPL"); 
MODULE_AUTHOR("LKMPG"); 
MODULE_DESCRIPTION("A sample driver"); 
 
static int __init init_hello_4(void) 
{ 
    pr_info("Hello, world 4\n"); 
    return 0; 
} 
 
static void __exit cleanup_hello_4(void) 
{ 
    pr_info("Goodbye, world 4\n"); 
} 
 
module_init(init_hello_4); 
module_exit(cleanup_hello_4);

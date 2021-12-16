//---------------------------------
//File Name    : hello-2.c
//Author       : aico
//Mail         : 2237616014@qq.com
//Github       : https://github.com/TBBtianbaoboy
//Site         : https://www.lengyangyu520.cn
//Create Time  : 2021-12-03 17:50:39
//Description  : 
//----------------------------------
#include <linux/init.h> /* Needed for the macros */ 
#include <linux/kernel.h> /* Needed for pr_info() */ 
#include <linux/module.h> /* Needed by all modules */ 
 
static int __init hello_2_init(void) 
{ 
    pr_info("Hello, world 2\n"); 
    return 0; 
} 
 
static void __exit hello_2_exit(void) 
{ 
    pr_info("Goodbye, world 2\n"); 
} 
 
module_init(hello_2_init); 
module_exit(hello_2_exit); 
 
MODULE_LICENSE("GPL");

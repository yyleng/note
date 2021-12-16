//---------------------------------
//File Name    : hello-1.c
//Author       : aico
//Mail         : 2237616014@qq.com
//Github       : https://github.com/TBBtianbaoboy
//Site         : https://www.lengyangyu520.cn
//Create Time  : 2021-12-03 17:26:57
//Description  : old version type with writing kernel module
//----------------------------------
#include <linux/kernel.h>
#include <linux/module.h>
 
int init_module(void) 
{ 
    pr_info("Hello world 1.\n"); 
 
    return 1; 
} 
 
void cleanup_module(void) 
{ 
    pr_info("Goodbye world 1.\n"); 
} 
 
MODULE_LICENSE("GPL");

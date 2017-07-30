//
//  ViewController.m
//  NSArray
//
//  Created by 李兴东 on 17/7/29.
//  Copyright © 2017年 xingshao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self arrayInitializeAndEnumerate];
    [self arrayCopy];
    [self arraySystemCopyAndMutableCopy];
}

- (void)arraySystemCopyAndMutableCopy{
    
//    [immutableObject copy] // 浅复制
//    [immutableObject mutableCopy] //单层深复制
//    [mutableObject copy] //单层深复制
//    [mutableObject mutableCopy] //单层深复制
    
    [self arraySystemCopy];
    [self arraySystemMutableCopy];
}

- (void)arraySystemMutableCopy{
    NSLog(@"arraySystemMutableCopy------");
    NSMutableArray *marray = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSLog(@"marray %p %p",marray,&marray);

    NSArray *copyArray = [marray copy];
    NSLog(@"copyArray %p %p",copyArray,&copyArray);

    NSMutableArray *mCopyArray = [marray mutableCopy];
    NSLog(@"mCopyArray %p %p",mCopyArray,&mCopyArray);

}

- (void)arraySystemCopy{
    NSLog(@"arraySystemCopy------");
    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSLog(@"array %p %p",array,&array);
    NSArray *copyArray = [array copy];
    NSLog(@"copyArray %p %p",copyArray,&copyArray);

    NSMutableArray *mCopyArray = [array mutableCopy];
    NSLog(@"mCopyArray %p %p",mCopyArray,&mCopyArray);

    
}

- (void)arrayCopy{
    //    集合的浅复制 (shallow copy) 在浅复制操作时，对于被复制对象的每一层都是指针复制。
    NSArray *someArray = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSLog(@"someArray %p %p",someArray,&someArray);
    
    NSArray *shallowCopyArray = [someArray copyWithZone:nil];
    NSLog(@"shallowCopyArray %p %p",shallowCopyArray,&shallowCopyArray);
    
    //   集合的完全复制(real-deep copy) 在完全复制操作时，对于被复制对象的每一层都是对象复制。
    //   集合的单层深复制 (one-level-deep copy) 在深复制操作时，对于被复制对象，至少有一层是深复制。
    
    NSArray *trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:someArray]];
    NSLog(@"trueDeepCopyArray %p %p",trueDeepCopyArray,&trueDeepCopyArray);
    //    如果你用这种方法深复制，集合里的每个对象都会收到 copyWithZone: 消息。如果集合里的对象遵循 NSCopying 协议，那么对象就会被深复制到新的集合。如果对象没有遵循 NSCopying 协议，而尝试用这种方法进行深复制，会在运行时出错。copyWithZone: 这种拷贝方式只能够提供一层内存拷贝(one-level-deep copy)，而非真正的深复制。
    NSArray *deepCopyArray  = [[NSArray alloc] initWithArray:someArray copyItems:YES];
    NSLog(@"deepCopyArray %p %p",deepCopyArray,&deepCopyArray);
    
}

- (void)arrayInitializeAndEnumerate{
    
    //    Literal，注意需要判空，不应出现nil。
    
    NSArray *array = @[@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace"];
    
    NSString *item = array[0];
    
    //    数量小
    NSLog(@"objectAtIndex: enumeration ---------------------------------");
    for (int i = 0; i < array.count; i++) {
        NSString *item = array[i];
        NSLog(@"index = %d ---- %@----%@",i ,[NSThread currentThread], item);
        
    }
    
    //    首选
    NSLog(@"NSFastEnumerator ---------------------------------");
    for (NSString *item in array) {
        NSLog(@"---- %@----%@",[NSThread currentThread], item);
        
    }
    //    数量大
    NSLog(@"Block enumeration ---------------------------------");
    [array enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index = %lu ---- %@----%@",(unsigned long)idx ,[NSThread currentThread], item);
        
    }];
    //    数量大 并发
    NSLog(@"enumerateObjectsWithOptions ---------------------------------");
    
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index = %lu ---- %@----%@",(unsigned long)idx , [NSThread currentThread], item);
        
    }];
    
    
    //获得全局并发队列
    
    NSLog(@"dispatch_apply ---------------------------------");
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_apply(array.count, queue, ^(size_t index) {
        NSString *item = array[index];
        NSLog(@"---- %@----%@",[NSThread currentThread], item);
    });
    
    //    对于不同的数据类型，遍历的语法相似
    NSLog(@"NSEnumerator ---------------------------------");
    NSEnumerator *enumerator = [array objectEnumerator];
    while(item = [enumerator nextObject]){
        NSLog(@"---- %@----%@",[NSThread currentThread], item);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

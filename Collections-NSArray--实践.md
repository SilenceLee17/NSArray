#NSArray

####tips：如有错误、遗漏，欢迎指摘！


##创建数组
推荐使用Literals方式

```
    //    Literal，注意需要判空，不应出现nil。
    
    NSArray *array = @[@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace"];
    
    NSString *item = array[0];
```

---

##遍历
列举了五种遍历方式

```

	 NSArray *array = @[@"Loe",@"Mach",@"Grace",@"Loe",@"Mach",@"Grace"];
        
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


```

```

2017-07-30 21:19:50.801 NSArray[59438:1885376] objectAtIndex: enumeration ---------------------------------
2017-07-30 21:19:50.801 NSArray[59438:1885376] index = 0 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.801 NSArray[59438:1885376] index = 1 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.801 NSArray[59438:1885376] index = 2 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.802 NSArray[59438:1885376] index = 3 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.802 NSArray[59438:1885376] index = 4 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.802 NSArray[59438:1885376] index = 5 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.802 NSArray[59438:1885376] NSFastEnumerator ---------------------------------
2017-07-30 21:19:50.802 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.802 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.802 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.803 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.803 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.803 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.803 NSArray[59438:1885376] Block enumeration ---------------------------------
2017-07-30 21:19:50.803 NSArray[59438:1885376] index = 0 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.803 NSArray[59438:1885376] index = 1 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.803 NSArray[59438:1885376] index = 2 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.804 NSArray[59438:1885376] index = 3 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.804 NSArray[59438:1885376] index = 4 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.804 NSArray[59438:1885376] index = 5 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.804 NSArray[59438:1885376] enumerateObjectsWithOptions ---------------------------------
2017-07-30 21:19:50.804 NSArray[59438:1885376] index = 1 ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.804 NSArray[59438:1885754] index = 0 ---- <NSThread: 0x608000272ac0>{number = 4, name = (null)}----Loe
2017-07-30 21:19:50.804 NSArray[59438:1885635] index = 2 ---- <NSThread: 0x618000261180>{number = 5, name = (null)}----Grace
2017-07-30 21:19:50.804 NSArray[59438:1885471] index = 3 ---- <NSThread: 0x608000272bc0>{number = 6, name = (null)}----Loe
2017-07-30 21:19:50.804 NSArray[59438:1885753] index = 4 ---- <NSThread: 0x608000272c00>{number = 7, name = (null)}----Mach
2017-07-30 21:19:50.804 NSArray[59438:1885769] index = 5 ---- <NSThread: 0x608000272a80>{number = 8, name = (null)}----Grace
2017-07-30 21:19:50.805 NSArray[59438:1885376] dispatch_apply ---------------------------------
2017-07-30 21:19:50.805 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.805 NSArray[59438:1885753] ---- <NSThread: 0x608000272c00>{number = 7, name = (null)}----Mach
2017-07-30 21:19:50.805 NSArray[59438:1885635] ---- <NSThread: 0x618000261180>{number = 5, name = (null)}----Grace
2017-07-30 21:19:50.805 NSArray[59438:1885471] ---- <NSThread: 0x608000272bc0>{number = 6, name = (null)}----Loe
2017-07-30 21:19:50.805 NSArray[59438:1885769] ---- <NSThread: 0x608000272a80>{number = 8, name = (null)}----Mach
2017-07-30 21:19:50.805 NSArray[59438:1885754] ---- <NSThread: 0x608000272ac0>{number = 4, name = (null)}----Grace
2017-07-30 21:19:50.806 NSArray[59438:1885376] NSEnumerator ---------------------------------
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Loe
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Mach
2017-07-30 21:19:50.806 NSArray[59438:1885376] ---- <NSThread: 0x60000007aa80>{number = 1, name = main}----Grace


```

---

##复制

###浅复制、深复制

```
    
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
    
```
结果

```   
2017-07-30 21:04:46.143 NSArray[57796:1859129] someArray 0x610000021380 0x7fff51d43a50
2017-07-30 21:04:46.143 NSArray[57796:1859129] shallowCopyArray 0x610000021380 0x7fff51d43a48
2017-07-30 21:04:46.144 NSArray[57796:1859129] trueDeepCopyArray 0x600000022500 0x7fff51d43a40
2017-07-30 21:04:46.144 NSArray[57796:1859129] deepCopyArray 0x600000022140 0x7fff51d43a38

```

###copy、mutableCopy

```

    NSLog(@"arraySystemCopy------");
    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSLog(@"array %p %p",array,&array);
    NSArray *copyArray = [array copy];
    NSLog(@"copyArray %p %p",copyArray,&copyArray);

    NSMutableArray *mCopyArray = [array mutableCopy];
    NSLog(@"mCopyArray %p %p",mCopyArray,&mCopyArray);

```

```

2017-07-30 21:11:08.355 NSArray[58475:1869319] arraySystemCopy------
2017-07-30 21:11:08.355 NSArray[58475:1869319] array 0x618000023860 0x7fff560eca20
2017-07-30 21:11:08.356 NSArray[58475:1869319] copyArray 0x618000023860 0x7fff560eca18
2017-07-30 21:11:08.356 NSArray[58475:1869319] mCopyArray 0x61800004a320 0x7fff560eca10

```
---

```

    NSLog(@"arraySystemMutableCopy------");
    NSMutableArray *marray = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSLog(@"marray %p %p",marray,&marray);

    NSArray *copyArray = [marray copy];
    NSLog(@"copyArray %p %p",copyArray,&copyArray);

    NSMutableArray *mCopyArray = [marray mutableCopy];
    NSLog(@"mCopyArray %p %p",mCopyArray,&mCopyArray);

```

```

2017-07-30 21:11:57.215 NSArray[58557:1870919] arraySystemMutableCopy------
2017-07-30 21:11:57.215 NSArray[58557:1870919] marray 0x618000054ac0 0x7fff52bdda50
2017-07-30 21:11:57.215 NSArray[58557:1870919] copyArray 0x600000050710 0x7fff52bdda48
2017-07-30 21:11:57.215 NSArray[58557:1870919] mCopyArray 0x60000004fe40 0x7fff52bdda40

```

可以看出

[immutableObject copy] // 浅复制

[immutableObject mutableCopy] //单层深复制

[mutableObject copy] //单层深复制

[mutableObject mutableCopy] //单层深复制

---

##附件：

[demo下载](https://github.com/SilenceLee17/NSArray)


---


##TODO
类簇、懒加载、kvo、kvc、线程安全

---

##摘要：
http://www.thinkandbuild.it/guided-tour-through-objective-c-literals/
http://www.cokco.cn/thread-34054-1-1.html
http://www.jianshu.com/p/38bfee55afd5
http://blog.csdn.net/cherry609195946/article/details/20047377
http://darkdust.net/writings/objective-c/nsarray-enumeration-performance
https://www.oschina.net/translate/nsarray-enumeration-performance
http://www.cnblogs.com/zhou--fei/p/6244171.html
http://www.cnblogs.com/wendingding/
https://www.zybuluo.com/MicroCai/note/50592





#NSArray

####tips：如有错误、遗漏，欢迎指摘！

An object representing a static ordered collection, for use instead of an 
Array constant in cases that require reference semantics.

NSArray是一个静态有序集合的对象，在需要引用语义的情况下替代数组常量来使用。

---

##Overview
概览

NSArray and its subclass NSMutableArray manage ordered collections of objects called arrays. NSArray creates static arrays, and NSMutableArray creates dynamic arrays. You can use arrays when you need an ordered collection of objects.

NSArray及其子类NSMutableArray管理有序集合的对象，统称为数组。 NSArray创建静态数组，NSMutableArray创建动态数组。 当您需要一个有序集合的对象时，您可以使用数组。

NSArray is “toll-free bridged” with its Core Foundation counterpart, CFArray. See Toll-Free Bridging for more information on toll-free bridging.

NSArray与其相应的Core Foundation类型CFArray进行“无缝桥接”。 有关无缝桥接的更多信息，请参阅无缝桥接。

译者注：NSArray在Foundation.framework中 ,  CFArray在CoreFoundation.framework中

##Creating NSArray Objects Using Array Literals

用数组字面量来创建NSArray对象

译者注：在计算机科学中，字面量（literal）是用于表达源代码中一个固定值的表示法（notation）。几乎所有计算机编程语言都具有对基本值的字面量表示，诸如：整数、浮点数以及字符串；而有很多也对布尔类型和字符类型的值也支持字面量表示；还有一些甚至对枚举类型的元素以及像数组、记录和对象等复合类型的值也支持字面量表示法。

In addition to the provided initializers, such as initWithObjects:, you can create an NSArray object using an array literal.

除了提供的初始化函数，如initWithObjects：你还可以使用数组字面量创建一个NSArray对象。

```
let array: NSArray = [someObject, "Hello, World!", 42]
```

In Objective-C, the compiler generates code that makes an underlying call to the init(objects:count:) method.

在Objective-C中，编译器会生成一些代码，这些代码会在底层调用init（objects：count :)函数。

```

id objects[] = { someObject, @"Hello, World!", @42 };
NSUInteger count = sizeof(objects) / sizeof(id);
NSArray *array = [NSArray arrayWithObjects:objects
                                     count:count];
                                     
```

You should not terminate the list of objects with nil when using this literal syntax, and in fact nil is an invalid value. For more information about object literals in Objective-C, see Working with Objects in Programming with Objective-C.

在使用字面量语法时，你不应以nil作为对象列表的结束标志，实际上nil是一个无效值。 有关Objective-C中对象字面量的更多信息，请参阅在Objective-C编程中使用对象。

In Swift, the NSArray class conforms to the ArrayLiteralConvertible protocol, which allows it to be initialized with array literals. For more information about object literals in Swift, see Literal Expression in The Swift Programming Language (Swift 4).

在Swift中，NSArray类符合ArrayLiteralConvertible协议，该协议允许使用数组字面量进行初始化。 有关Swift对象字面量的更多信息，请参阅Swift编程语言中的字面量表达式（Swift 4）。

##Accessing Values Using Subscripting

使用下标访问值

In addition to the provided instance methods, such as object(at:), you can access NSArray values by their indexes using subscripting.

除了提供的实例方法，如object（at :)，你还可以通过下标索引来访问NSArray的值。

```

let value = array[3]

```

##Subclassing Notes

子类的注意事项

There is typically little reason to subclass NSArray. The class does well what it is designed to do—maintain an ordered collection of objects. But there are situations where a custom NSArray object might come in handy. Here are a few possibilities:

通常很少需要使用NSArray的子类。 NSArray在维护一个有序的对象集合上已经做得很好。 但某些情况，自定义NSArray对象可能会派上用场。 列举了几种可能性：

*
Changing how NSArray stores the elements of its collection. You might do this for performance reasons or for better compatibility with legacy code.

你可能出于性能原因或更好兼容旧版代码，去更改NSArray存储其集合元素的方式。 

*
Acquiring more information about what is happening to the collection (for example, statistics gathering).

获取更多有关集合事件的信息（例如统计信息收集）

##Methods to Override

方法重写

Any subclass of NSArray  must override the primitive instance methods count and object(at:). These methods must operate on the backing store that you provide for the elements of the collection. For this backing store you can use a static array, a standard NSArray object, or some other data type or mechanism. You may also choose to override, partially or fully, any other NSArray method for which you want to provide an alternative implementation.

任何NSArray子类必须覆盖count和object(at:)这些原始的实例方法。 这些方法必须在备份存储上操作，备份存储是集合的元素提供的。 对于此备份存储，您可以使用静态数组，标准NSArray对象或其他数据类型或机制。 您还可以选择部分或完全覆盖任何其他NSArray方法，为其提供一个替代实现。

You might want to implement an initializer for your subclass that is suited to the backing store that the subclass is managing. If you do, your initializer must invoke one of the designated initializers of the NSArray class, either init() or init(objects:count:). The NSArray class adopts the NSCopying, NSMutableCopying, and NSCoding protocols; custom subclasses of NSArray should override the methods in these protocols as necessary.

您可能想为您的子类实现一个初始化方法，以适合子类正在管理的备份存储。如果是这样，您的初始化方法必须调用NSArray类任意一个特定的初始化方法，即init()或init(objects:count:)。NSArray类使用了NSCopying，NSMutableCopying和NSCoding协议; NSArray的自定义子类应根据需要重写这些协议中的方法。

Remember that NSArray is the public interface for a class cluster and what this entails for your subclass. You must provide the storage for your subclass and implement the primitive methods that directly act on that storage.

请记住，NSArray是一个类簇的公共接口，它为您的子类带来了什么。 您必须为子类提供存储，并实现直接对该存储进行操作的原始方法。

##Alternatives to Subclassing

子类化的替代方案

Before making a custom subclass of NSArray, investigate NSPointerArray and the corresponding Core Foundation type, CFArray. Because NSArray and CFArray are “toll-free bridged,” you can substitute a CFArray object for a NSArray object in your code (with appropriate casting). Although they are corresponding types, CFArray and NSArray do not have identical interfaces or implementations, and you can sometimes do things with CFArraythat you cannot easily do with NSArray. For example, CFArray provides a set of callbacks, some of which are for implementing custom retain-release behavior. If you specify NULL implementations for these callbacks, you can easily get a non-retaining array.

在编写NSArray的自定义子类之前，可以先学习NSPointerArray和相应的Core Foundation类型CFArray。因为NSArray和CFArray是“无缝桥接”，所以您可以在代码中使用CFArray对象替换NSArray对象（通过适当的转换）。虽然它们是相应的类型，但CFArray和NSArray没有相同的接口或实现，有时您可以使用CFArray来处理NSArray不容易实现的事情。例如，CFArray提供了一组回调，其中一些用于实现自定义retain-release行为。 如果您给这些回调指定无效的实现，则可以容易获取一个non-retaining数组。

If the behavior you want to add supplements that of the existing class, you could write a category on NSArray. Keep in mind, however, that this category will be in effect for all instances of NSArray that you use, and this might have unintended consequences. Alternatively, you could use composition to achieve the desired behavior.

如果您想补充现有类的行为，则可以给NSArray上添加一个category。 但是请记住，这个category将对您使用的所有NSArray实例生效，这可能会产生意料不到的后果。 或者，您可以使用组合来实现所需的行为。

----


#Topics

主题

----
###Creating an Array 

创建一个数组

```
+ array

```
Creates and returns an empty array.

创建并返回一个空数组。

```
+ arrayWithArray:

```
Creates and returns an array containing the objects in another given array.

创建并返回一个数组，该数组包含另一给定数组中的对象。

```
+ arrayWithContentsOfFile:

```
Creates and returns an array containing the contents of the file specified by a given path.

创建并返回一个数组，该数组包含由给定路径指定的文件的内容。




```
Deprecated

+ arrayWithContentsOfURL: 

```
Creates and returns an array containing the contents specified by a given URL.

译者注：Deprecated弃用

创建并返回一个数组，该数组包含给定URL指定的内容。

```
Deprecated
+ arrayWithObject:

```
Creates and returns an array containing a given object.

创建并返回一个数组，该数组包含一个给定的对象。

```
+ arrayWithObjects:

```
Creates and returns an array containing the objects in the argument list.

创建并返回一个数组，该数组包含参数列表中的对象。

```
+ arrayWithObjects:count:

```
Creates and returns an array that includes a given number of objects from a given C array.

创建并返回一个数组，该数数组包含给定C数组中给定数量的对象。

---

###Initializing an Array

初始化数组

```
- init

```
Initializes a newly allocated array.

初始化一个新分配的数组。

```
- initWithArray:

```

Initializes a newly allocated array by placing in it the objects contained in a given array.

通过提供数组给定数组中的对象的方式，初始化一个新分配的数组

```
- initWithArray:copyItems:

```

Initializes a newly allocated array using anArray as the source of data objects for the array. 

通过提供数组的数据对象的源的方式，初始化一个新分配的数组

```
- initWithContentsOfFile:

```

Initializes a newly allocated array with the contents of the file specified by a given path.

通过提供数组给定路径指定的文件内容的方式，初始化一个新分配的数组

```
Deprecated
- initWithContentsOfURL:

```

Initializes a newly allocated array with the contents of the location specified by a given URL.

通过提供数组给定URL指定的位置的内容的方式，初始化一个新分配的数组

Deprecated
- initWithObjects:
Initializes a newly allocated array by placing in it the objects in the argument list.

通过提供数组参数列表中的对象的方式，初始化一个新分配的数组

- initWithObjects:count:
Initializes a newly allocated array to include a given number of objects from a given C array.

通过提供数组给定C数组中给定数量的对象的方式，初始化一个新分配的数组

---

###Querying an Array

查询数组

```
- containsObject:

```

Returns a Boolean value that indicates whether a given object is present in the array.

返回一个布尔值，该值表示给定对象是否存在于数组中。

```
count

```

The number of objects in the array.

数组中的对象数。


```
- getObjects:

```

Copies all the objects contained in the array to aBuffer.

将数组中包含的所有对象复制到缓冲区。

```
Deprecated
- getObjects:range:

```

Copies the objects contained in the array that fall within the specified range to aBuffer.

将包含在指定范围内的数组中的对象复制到缓冲区。

```
firstObject

```
The first object in the array.

数组中的第一个对象。

```
lastObject

```
The last object in the array.

数组中的最后一个对象。

```
- objectAtIndex:

```

Returns the object located at the specified index.

返回指定索引处的对象。

```
- objectAtIndexedSubscript:

```

Returns the object at the specified index.

返回指定索引处的对象。

```
- objectsAtIndexes:

```

Returns an array containing the objects in the array at the indexes specified by a given index set.

返回一个数组，该数组包含通过给定的索引集在原数组中对应索引的对象。

```
- objectEnumerator

```

Returns an enumerator object that lets you access each object in the array.

返回一个枚举器对象，该对象允许您访问数组中的每个对象。

```
- reverseObjectEnumerator

```

Returns an enumerator object that lets you access each object in the array, in reverse order.

返回一个枚举器对象，该对象允许您以相反的顺序访问数组中的每个对象。

---

###Finding Objects in an Array

在数组中查找对象

```
- indexOfObject:

```

Returns the lowest index whose corresponding array value is equal to a given object.

返回最低索引，为其对应数组值等于给定对象的索引。

```
- indexOfObject:inRange:

```

Returns the lowest index within a specified range whose corresponding array value is equal to a given object .

返回最低索引，为其指定范围内对应数组值等于给定对象的索引。

```
- indexOfObjectIdenticalTo:

```

Returns the lowest index whose corresponding array value is identical to a given object.
返回最低索引，为其相应的数组值与给定对象相同的索引。

```
- indexOfObjectIdenticalTo:inRange:

```

Returns the lowest index within a specified range whose corresponding array value is equal to a given object .

返回最低索引，为其指定范围相应的数组值与给定对象相同的索引。

```
- indexOfObjectPassingTest:

```

Returns the index of the first object in the array that passes a test in a given block.


返回索引，为其数组中通过给定块中测试的第一个对象的索引

```
- indexOfObjectWithOptions:passingTest:

```

Returns the index of an object in the array that passes a test in a given block for a given set of enumeration options.

返回索引，为其给定的块对于一组给定的枚举选项通过测试数组中的对象的索引

```
- indexOfObjectAtIndexes:options:passingTest:

```

Returns the index, from a given set of indexes, of the first object in the array that passes a test in a given block for a given set of enumeration options.

返回索引，为其给定的一组索引中返回在给定块中通过给定块的枚举选项的数组中的第一个对象的索引。

```
- indexesOfObjectsPassingTest:

```

Returns the indexes of objects in the array that pass a test in a given block.

返回索引集合，为其给定块中通过测试的数组中的对象的索引集合。

```
- indexesOfObjectsWithOptions:passingTest:

```

Returns the indexes of objects in the array that pass a test in a given block for a given set of enumeration options.

返回索引集合，为其数组中对于给定的一组枚举选项在给定块中传递测试的对象的索引集合。

```
- indexesOfObjectsAtIndexes:options:passingTest:

```
Returns the indexes, from a given set of indexes, of objects in the array that pass a test in a given block for a given set of enumeration options.

返回索引集合，为其给定的一组索引中返回在给定块中为特定的枚举选项集传递测试的数组中的对象的索引集合。

```
- indexOfObject:inSortedRange:options:usingComparator:

```

Returns the index, within a specified range, of an object compared with elements in the array using a given NSComparator block.

返回索引,为其指定范围内使用给定的NSComparator块中与数组中的元素相比较的对象的的索引。

---

###Sending Messages to Elements

给元素发送消息

```
- makeObjectsPerformSelector:

```

Sends to each object in the array the message identified by a given selector, starting with the first object and continuing through the array to the last object.

由给定选择器向数组中的每个对象发送消息。从第一个对象开始，延续到最后一个对象。

```
- makeObjectsPerformSelector:withObject:

```

Sends the a Selector message to each object in the array, starting with the first object and continuing through the array to the last object.

向数组中的每个对象发送一个选择器消息，从第一个对象开始，延续到最后一个对象。

```
- enumerateObjectsUsingBlock:

```

Executes a given block using each object in the array, starting with the first object and continuing through the array to the last object.

对数组中每个对象执行给定的block，从第一个对象开始，延续到最后一个对象。

```
- enumerateObjectsWithOptions:usingBlock:

```

Executes a given block using each object in the array.

对数组中每个对象执行给定的block

```
- enumerateObjectsAtIndexes:options:usingBlock:

```

Executes a given block using the objects in the array at the specified indexes.

对指定索引的数组中对象执行给定的block

---

###Comparing Arrays

数组的比较

```
- firstObjectCommonWithArray:

```

Returns the first object contained in the receiving array that’s equal to an object in another given array.

返回接收数组中包含的第一个对象，该对象等于另一给定数组中的一个对象。

```
- isEqualToArray:

```


Compares the receiving array to another array.

将接收数组与另一个数组进行比较。

----

###Deriving New Arrays

派生新数组

```
- arrayByAddingObject:

```

Returns a new array that is a copy of the receiving array with a given object added to the end.

返回一个新数组，它是一个接收数组结尾添加给定对象的副本。

```
- arrayByAddingObjectsFromArray:

```

Returns a new array that is a copy of the receiving array with the objects contained in another array added to the end.

返回一个新数组，它是一个接收数组结尾添加另一个数组的副本。

```
- filteredArrayUsingPredicate:

```

Evaluates a given predicate against each object in the receiving array and returns a new array containing the objects for which the predicate returns true.

针对接收数组中的每个对象进行给定断言，并返回一个包含所有断言为true的对象的新数组。

```
- subarrayWithRange:

```
Returns a new array containing the receiving array’s elements that fall within the limits specified by a given range.

返回一个新数组，它包含接收数组给定范围内的指定元素。

---


###Sorting

排序

```
sortedArrayHint

```
Analyzes the array and returns a “hint” that speeds the sorting of the array when the hint is supplied to sortedArrayUsingFunction:context:hint:.

分析数组并返回一个“提示”，当提供提示时，可以加速数组的排序sortedArrayUsingFunction:context:hint:.

```
- sortedArrayUsingFunction:context:

```

Returns a new array that lists the receiving array’s elements in ascending order as defined by the comparison function comparator.

返回一个新数组，它由按照比较函数比较器定义的升序列出接收数组的元素组成。

```
- sortedArrayUsingFunction:context:hint:

```

Returns a new array that lists the receiving array’s elements in ascending order as defined by the comparison function comparator.

返回一个新数组，它由按照比较函数比较器定义的升序列出接收数组的元素组成。

```
- sortedArrayUsingDescriptors:

```

Returns a copy of the receiving array sorted as specified by a given array of sort descriptors.

返回接收数组的副本，它按照给定的排序描述符数组指定排序。

```
- sortedArrayUsingSelector:

```

Returns an array that lists the receiving array’s elements in ascending order, as determined by the comparison method specified by a given selector.

返回一个数组，它由按照由给定选择器指定的比较方法确定的升序列出接收数组的元素组成。

```
- sortedArrayUsingComparator:

```

Returns an array that lists the receiving array’s elements in ascending order, as determined by the comparison method specified by a given NSComparator block.

返回一个数组，它由按照给定的NSComparator块指定的比较方法确定的升序列出接收数组的元素组成。

```
- sortedArrayWithOptions:usingComparator:

```

Returns an array that lists the receiving array’s elements in ascending order, as determined by the comparison method specified by a given NSComparator block.

返回一个数组，它由按照由给定的NSComparator块指定的比较方法确定的升序列出接收数组的元素组成。

```
NSComparator

```
Defines the signature for a block object used for comparison operations.

定义用于比较操作的块对象的签名。

---

###Working with String Elements

使用字符串元素

```
- componentsJoinedByString:

```
Constructs and returns an NSString object that is the result of interposing a given separator between the elements of the array.

构造并返回一个NSString对象，该对象是在数组元素之间插入给定的分隔符组成的结果。

---

###Creating a Description

创建描述

```
description

```

A string that represents the contents of the array, formatted as a property list.

展示数组内容的字符串，格式为属性列表。

```
- descriptionWithLocale:

```

Returns a string that represents the contents of the array, formatted as a property list.

返回一个字符串，展示数组内容的字符串，格式为属性列表。

```
- descriptionWithLocale:indent:

```

Returns a string that represents the contents of the array, formatted as a property list.

返回一个字符串，展示数组内容的字符串，格式为属性列表。

---

###Storing Arrays

存储数组

```
Deprecated
- writeToFile:atomically:

```

Writes the contents of the array to a file at a given path.

将数组的内容写入给定路径的文件。

```
Deprecated
- writeToURL:atomically:

```

Writes the contents of the array to the location specified by a given URL.

将数组的内容写入给定URL指定的位置。

---

###Collecting Paths

收集路径

```
- pathsMatchingExtensions:

```

Returns an array containing all the pathname elements in the receiving array that have filename extensions from a given array.

返回一个数组，该数组包含接收数组中具有给定数组的文件扩展名的所有路径名元素。

---

###Key-Value Observing

键值监测

```
- addObserver:forKeyPath:options:context:

```

Raises an exception.

抛出异常。

```
- removeObserver:forKeyPath:

```

Raises an exception.

抛出异常。

```
- removeObserver:forKeyPath:context:

```

Raises an exception.

抛出异常。

```
- removeObserver:fromObjectsAtIndexes:forKeyPath:context:

```

Raises an exception.

抛出异常。

```
- addObserver:toObjectsAtIndexes:forKeyPath:options:context:

```

Registers an observer to receive key value observer notifications for the specified key-path relative to the objects at the indexes. 

注册观察者，用来接收关于索引的对象的指定键路径的键值观察器通知。

```
- removeObserver:fromObjectsAtIndexes:forKeyPath:

```
Removes an Observer from all key value observer notifications associated with the specified keyPath relative to the array’s objects at indexes.

移除与索引相对的数组对象相关联的所有关键值观察器通知中观察者。

---

###Key-Value Coding

键值编码

```
- setValue:forKey:

```

Invokes setValue:forKey: on each of the array's items using the specified valueand key.

调用setValue:forKey:函数，为每个数组的元素设置指定的值和键。

```
- valueForKey:

```

Returns an array containing the results of invoking valueForKey: using key on each of the array's objects.

返回一个数组，该数组包含调用valueForKey的结果：在每个数组的对象上使用键。

---

###Randomly Shuffling an Array

数组的随机乱序

```
- shuffledArray

```

Returns a new array that lists this array’s elements in a random order.

返回一个新的数组，该数组以一个随机的顺序列出原数组的元素。

```
- shuffledArrayWithRandomSource:

```

Returns a new array that lists this array’s elements in a random order, using the specified random source.

返回一个新的数组，该数组使用指定的随机源以随机顺序列出原数组的元素。



---
#摘要
https://developer.apple.com/documentation/swift/array
https://developer.apple.com/documentation/foundation/nsarray
https://developer.apple.com/documentation/foundation/nsmutablearray








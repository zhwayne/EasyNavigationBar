//
//  NSArray+EASBlock.h
//  EasyNavigationBar
//
//  Created by Wayne on 2018/6/20.
//  Copyright © 2018年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSArray<ObjectType> (EASBlock)

/**
 遍历数组

 @param body 遍历操作 block
 */
- (void)forEach:(void (^)(ObjectType obj))body;

/**
 根据筛选条件筛选数组元素。如：
 
 NSArray <NSNumber*>*nums  = @[@1, @2, @3, @4, @5];
 NSArray <NSNumber*>*evens = [nums select:^BOOL(NSNumber *obj){
    return [obj integerValue] % 2 == 0;
 }];    // evens is [2, 4]

 @param where 筛选条件
 @return 筛选后的新数组
 */
- (nullable NSArray <ObjectType>*)select:(BOOL (^)(ObjectType obj))where;

/**
 按照顺序遍历的方式，根据筛选条件筛选出第一个符合条件的数组元素。

 @param where 筛选条件
 @return 选择的元素
 */
- (nullable ObjectType)selectFirst:(BOOL (^)(ObjectType obj))where;

/**
 select 的相反操作，根据指定条件从数组中剔除元素。

 @param where 剔除条件
 @return 剔除指定的元素后的数组
 */
- (nullable NSArray <ObjectType>*)reject:(BOOL (^)(ObjectType obj))where;

/**
 重组元素

 @param initial 初始值
 @param body 重组 block
 @return 组合完成后的结果
 */
- (id)reduce:(id)initial body:(id (^)(id result, ObjectType obj))body;

/**
 将数组元素映射成另外一种类型的元素并包装成新数组。
 注意，如果返回 nil，则对应的元素会被忽略。

 @param body 映射逻辑 block
 @return 映射完成后的新数组
 */
- (NSArray *)map:(id _Nullable (^)(ObjectType obj))body;

/**
 数组中是否包含符合指定条件的元素

 @param where 指定条件
 @return 包含返回 YES, 否则返回 NO.
 */
- (BOOL)contain:(BOOL (^)(ObjectType obj))where;

@end


@interface NSArray<ObjectType> (Safe)

- (ObjectType)safe_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END







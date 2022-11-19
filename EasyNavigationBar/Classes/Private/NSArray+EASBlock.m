//
//  NSArray+EASBlock.m
//  EasyNavigationBar
//
//  Created by Wayne on 2018/6/20.
//  Copyright © 2018年 Wayne. All rights reserved.
//

#import "NSArray+EASBlock.h"

@implementation NSArray (EASBlock)

- (void)forEach:(void (^)(id))body
{
    for (id element in self) {
        body(element);
    }
}

- (NSArray <id>*)select:(BOOL (^)(id))where
{
    __block NSArray *array = @[];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            array = [array arrayByAddingObject:obj];
        }
    }];
    if (array.count == 0)
        return nil;
    return array;
}

- (nullable id)selectFirst:(BOOL (^)(id obj))where {
    __block id selectedObj = nil;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            selectedObj = obj;
            *stop = YES;
        }
    }];
    return selectedObj;
}

- (NSArray <id>*)reject:(BOOL (^)(id))where
{
    return [self select:^BOOL(id obj) {
        return !where(obj);
    }];
}

- (id)reduce:(id)initial body:(id (^)(id, id))body
{
    NSParameterAssert(body != nil);
    
    __block id result = initial;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = body(result, obj);
    }];
    
    return result;
}

- (NSArray *)map:(id _Nullable (^)(id _Nonnull))body
{
    NSParameterAssert(body != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = body(obj);
        if (value) [result addObject:value];
    }];
    
    return [result copy];
}

- (BOOL)contain:(BOOL (^)(id))where {
    
    __block BOOL res = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (where(obj)) {
            *stop = YES;
            res = YES;
        }
    }];
    
    return res;
}

@end


@implementation NSArray (Safe)

- (id)safe_objectAtIndex:(NSUInteger)index {
    index = MIN(index, self.count - 1);
    return [self objectAtIndex:index];
}

@end

//
//  NSObject+SFIMPropertyName.m
//
//  Created by huangzhifei on 2019/5/27.
//

#import "NSObject+SFIMPropertyName.h"
#import <objc/runtime.h>

@implementation NSObject (SFIMPropertyName)

- (NSDictionary<NSString *, NSArray<NSString *> *> *)sfim_propertyNameDict {
    unsigned int outCount;
    NSMutableArray *propertyNameArray = [NSMutableArray array];
    NSMutableArray *propertyClassNameArray = [NSMutableArray array];
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [propertyNameArray addObject:propertyName];
        //获取属性类型
        NSString *propertyType = [NSString stringWithFormat:@"%@", @(property_copyAttributeValue(property, "T"))];
        NSLog(@"%@", propertyType);
        [propertyClassNameArray addObject:propertyType];
    }
    //立即释放properties指向的内存
    free(properties);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:propertyNameArray forKey:@"name"];
    [dict setValue:propertyClassNameArray forKey:@"class"];
    return dict.copy;
}

- (NSArray<NSString *> *)sfim_propertyNameList {
    return [[self sfim_propertyNameDict] objectForKey:@"name"];
}

- (NSArray<NSString *> *)sfim_propertyNameListWithFilter:(Class)filterClass {
    NSDictionary *dict = [self sfim_propertyNameDict];
    NSMutableArray<NSString *> *propertyNameArray = dict[@"name"];
    NSMutableArray<NSString *> *propertyClassNameArray = dict[@"class"];
    NSMutableArray<NSString *> *result = [NSMutableArray array];
    [propertyClassNameArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasPrefix:@"@"]) {
            // 对象
            NSString *obj1 = [obj stringByReplacingOccurrencesOfString:@"@" withString:@""];
            NSString *obj2 = [obj1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            id o = [[NSClassFromString(obj2) alloc] init];
            if ([o isKindOfClass:filterClass]) {
                [result addObject:propertyNameArray[idx]];
            }
        }
    }];
    return result;
}

@end

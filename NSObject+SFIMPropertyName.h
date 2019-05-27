//
//  NSObject+SFIMPropertyName.h
//
//  Created by huangzhifei on 2019/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SFIMPropertyName)

/**
 获取类的所有属性

 @return 返回类属性列表
 */
- (NSArray <NSString *> *)sfim_propertyNameList;

/**
 获取类的所有属性，根据 filterClass 过滤结果，比如传入 UIView，则只会返回 isKindOfClass 属于 UIView 的结果

 @param filterClass 过滤条件
 @return 返回类属性列表
 */
- (NSArray <NSString *> *)sfim_propertyNameListWithFilter:(Class)filterClass;

@end

NS_ASSUME_NONNULL_END

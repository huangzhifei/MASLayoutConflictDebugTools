//
//  SFIMMASLayoutConflictDebugTools.h
//
//  Created by huangzhifei on 2019/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFIMMASLayoutConflictDebugTools : NSObject

/**
 自动以属性名设置 attachInstance 的 UIView 的属性为标识，这样在 Masonry 布局的时候，有约束冲突就会打印出哪个属性冲突了。
 */
+ (void)setupMASAttachKeysWithInstance:(id)attachInstance;

@end

NS_ASSUME_NONNULL_END

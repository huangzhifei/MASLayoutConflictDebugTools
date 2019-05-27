//
//  SFIMMASLayoutConflictDebugTools.m
//
//  Created by huangzhifei on 2019/5/27.
//

#import "SFIMMASLayoutConflictDebugTools.h"
#import "NSObject+SFIMPropertyName.h"
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@implementation SFIMMASLayoutConflictDebugTools

+ (void)setupMASAttachKeysWithInstance:(id)attachInstance {
#ifdef DEBUG
    NSArray<NSString *> *arr = [attachInstance sfim_propertyNameListWithFilter:[UIView class]];
    [arr enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        id subAttach = [attachInstance valueForKey:[NSString stringWithFormat:@"%@", obj]];
        NSLog(@"subAttach: %@", subAttach);
        if ([subAttach respondsToSelector:@selector(setMas_key:)]) {
            [subAttach setMas_key:obj];
        }
    }];
    // MASAttachKeys(<#...#>) //使用 Masonry 提供的这个宏也可以，不过要手动一个一个设置。
#endif
}

@end

//
//  ZKActionItem.h
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKActionItem : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) dispatch_block_t handler;

+ (instancetype)actionWithTitle:(NSString *)title
                           icon:(NSString *)icon
                        handler:(dispatch_block_t)handler;

@end

NS_ASSUME_NONNULL_END

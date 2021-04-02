//
//  ZKActionItem.m
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import "ZKActionItem.h"

@implementation ZKActionItem

+ (instancetype)actionWithTitle:(NSString *)title
                           icon:(NSString *)icon
                        handler:(dispatch_block_t)handler {
    ZKActionItem *item    = [[self alloc] init];
    item.title            = title;
    item.icon             = icon;
    item.handler = handler;

    return item;
}

@end

//
//  ZKActionItem.m
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import "ZKActionItem.h"

@implementation ZKActionItem

+ (instancetype)itemWithTitle:(NSString *)title
                         icon:(NSString *)icon
             didTappedHandler:(dispatch_block_t)didTappedHandler {
    ZKActionItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    item.didTappedHandler = didTappedHandler;
    
    return item;
}

@end

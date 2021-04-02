//
//  ZKActionSheetConfiguration.m
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import "ZKActionSheetConfiguration.h"

@implementation ZKActionSheetConfiguration

+ (id)sharedInstance {
    static dispatch_once_t onceQueue;
    static ZKActionSheetConfiguration *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit {
    self.cancelButtonHeight = 49.f;
    self.itemHeight = 123.f;
    self.itemWidth = 72.f;
    self.itemInterval = 14.f;
    self.animationDuration = 0.3;
    self.dimBackgroundAlpha = 0.3;
}

@end

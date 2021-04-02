//
//  ZKActionSheetConfiguration.h
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import <Foundation/Foundation.h>

@interface ZKActionSheetConfiguration : NSObject

@property (nonatomic, assign) CGFloat cancelButtonHeight;   // 取消按钮高度，默认 49.f
@property (nonatomic, assign) CGFloat itemHeight;           // item 高度，默认123.f
@property (nonatomic, assign) CGFloat itemWidth;            // item 宽度，默认72.f
@property (nonatomic, assign) CGFloat itemInterval;         // item 间隔，14.f

@property (nonatomic, assign) NSTimeInterval animationDuration; //动画时间，默认0.3s
@property (nonatomic, assign) CGFloat dimBackgroundAlpha;

+ (instancetype)sharedInstance;

@end

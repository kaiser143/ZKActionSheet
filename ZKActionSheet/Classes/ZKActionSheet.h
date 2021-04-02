//
//  ZKActionSheet.h
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import <UIKit/UIKit.h>
#import "ZKActionItem.h"

@interface ZKActionSheet : UIView

/** 顶部标题，默认内容为“分享” */
@property (nonatomic, strong, readwrite) NSString *title;

/** 底部取消按钮 */
@property (nonatomic, readonly) UIButton *cancelButton;

/**
 *	@brief	创建常规shareView
 *	@param 	shareArray 	上面一排分享项目
 *	@param 	functionArray 	下面一排分享项目
 */
+ (instancetype)shareViewWithShareItems:(NSArray<ZKActionItem *> *)shareArray
                          functionItems:(NSArray<ZKActionItem *> *)functionArray;
- (instancetype)initWithShareItems:(NSArray<ZKActionItem *> *)shareArray
                     functionItems:(NSArray<ZKActionItem *> *)functionArray;

/**
 *	@brief	自定义shareView
 */
- (instancetype)initWithItems:(NSArray<NSArray<ZKActionItem *> *> *)array;

// 显示、隐藏
- (void)show;
- (void)hide;

@end

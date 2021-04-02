//
//  ZKActionSheetView.h
//  Pods
//
//  Created by Kaiser on 2017/3/8.
//
//

#import <UIKit/UIKit.h>

@interface ZKActionSheetView : UIToolbar

/** 顶部标题Label, 默认内容为"分享" */
@property (nonatomic, strong) UILabel *titleLabel;

/** 底部取消Button, 默认标题为"取消" */
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

- (CGFloat)shareSheetHeight;
- (CGFloat)initialHeight;

@end

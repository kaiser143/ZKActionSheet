//
//  ZKActionSheetView.h
//  Pods
//
//  Created by Kaiser on 2017/3/8.
//
//

#import <UIKit/UIKit.h>

@interface ZKActionSheetView : UIToolbar

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) dispatch_block_t cancelBlock;

- (CGFloat)shareSheetHeight;
- (CGFloat)initialHeight;

@end

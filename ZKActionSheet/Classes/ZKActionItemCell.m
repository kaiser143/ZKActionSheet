//
//  ZKActionItemCell.m
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import "ZKActionItemCell.h"
#import "ZKActionItem.h"
#import "ZKActionSheetConfiguration.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

NSString *const ZKActionSheetWillHideNotification = @"KAI_ZKActionSheetWillHideNotification";

@interface ZKActionItemCell ()

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UITextView *titleView;
@property (nonatomic, assign) BOOL hasInstalledConstraints;

@end

@implementation ZKActionItemCell

#pragma mark - Initializer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    return self;
}

#pragma mark - events Handler

- (void)didTappedButton {
    if (self.item.didTappedHandler) {
        self.item.didTappedHandler();
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ZKActionSheetWillHideNotification object:nil];
}

#pragma mark - Private Methods

- (void)updateConstraints {
    if (!self.hasInstalledConstraints) {
        CGFloat titleInset = 4;
        
        [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat width = [ZKActionSheetConfiguration sharedInstance].itemWidth;
            make.width.and.height.mas_equalTo(width-[ZKActionSheetConfiguration sharedInstance].itemInterval);
            make.top.equalTo(self).with.offset(15.f);
            make.left.equalTo(self).with.offset([ZKActionSheetConfiguration sharedInstance].itemInterval/2.f);
        }];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(-titleInset);
            make.top.equalTo(self.iconButton.mas_bottom).with.offset(10);
            make.width.equalTo(self).with.offset(2*titleInset);
            make.height.mas_equalTo(30);
        }];
        
        self.hasInstalledConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - getters and setters

- (UIButton *)iconButton {
    if (!_iconButton) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton addTarget:self
                        action:@selector(didTappedButton)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_iconButton];
    }
    
    return _iconButton;
}

- (UITextView *)titleView {
    if (!_titleView) {
        _titleView = [[UITextView alloc] init];
        _titleView.textColor = [UIColor darkGrayColor];
        _titleView.font = [UIFont systemFontOfSize:11];
        _titleView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
        _titleView.backgroundColor = nil;
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.userInteractionEnabled = NO;
        
        [self addSubview:_titleView];
    }
    
    return _titleView;
}

- (void)setItem:(ZKActionItem *)item {
    _item = item;
    
    [self.iconButton setImage:[UIImage imageNamed:item.icon]
                     forState:UIControlStateNormal];
    self.titleView.text = item.title;
}

@end

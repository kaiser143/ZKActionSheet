//
//  ZKActionSheet.m
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import "ZKActionSheet.h"
#import "ZKActionSheetView.h"
#import "ZKActionSheetConfiguration.h"
#import "ZKActionItemCell.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

@interface ZKActionSheet ()

@property (nonatomic, strong) ZKActionSheetView *shareSheetView; /**< 分享面板 */
@property (nonatomic, strong) UIView *dimBackgroundView;        /**< 半透明黑色背景 */

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL hasInstalledConstraints;

@end

@implementation ZKActionSheet

#pragma mark - Initializer

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareViewWithShareItems:(NSArray *)shareArray
                          functionItems:(NSArray *)functionArray {
    ZKActionSheet *shareView = [[self alloc] initWithShareItems:shareArray functionItems:functionArray];
    
    return shareView;
}

- (instancetype)initWithShareItems:(NSArray *)shareArray
                     functionItems:(NSArray *)functionArray {
    NSMutableArray *itemsArrayM = [NSMutableArray array];
    
    if (shareArray.count) [itemsArrayM addObject:shareArray];
    if (functionArray.count) [itemsArrayM addObject:functionArray];
    
    return [self initWithItems:[itemsArrayM copy]];
}

- (instancetype)initWithItems:(NSArray<NSArray<ZKActionItem *> *> *)array {
    if (self = [self init]) {
        self.shareSheetView.dataSource = array;
        
        [self.shareSheetView layoutIfNeeded];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.frame = [UIScreen mainScreen].bounds;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:ZKActionSheetWillHideNotification object:nil];
    
    return self;
}

#pragma mark - Private Methods

- (void)show {
    [self addToKeyWindow];
    [self showAnimationWithCompletion:nil];
}

- (void)hide {
    [self hideAnimationWithCompletion:^(BOOL finished) {
        [self removeFromKeyWindow];
    }];
}

- (void)updateConstraints {
    if (!self.hasInstalledConstraints) {
        
        self.hasInstalledConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)addToKeyWindow {
    if (!self.superview) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keyWindow);
        }];
        
        [self addSubview:self.dimBackgroundView];
        [self addSubview:self.shareSheetView];
        [self.dimBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.shareSheetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.width.equalTo(self);
            make.top.equalTo(self.mas_bottom).priorityLow();
        }];
        
        [self layoutIfNeeded];
    }
}

- (void)removeFromKeyWindow {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)showAnimationWithCompletion:(void (^)(BOOL finished))completion {
    // 使用remake 解决iOS 10下的约束冲突问题
    [self.shareSheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [UIView animateWithDuration:[ZKActionSheetConfiguration sharedInstance].animationDuration animations:^{
        self.dimBackgroundView.alpha = [ZKActionSheetConfiguration sharedInstance].dimBackgroundAlpha;
        [self layoutIfNeeded];
    } completion:completion];
}

- (void)hideAnimationWithCompletion:(void (^)(BOOL finished))completion {
    [self.shareSheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.equalTo(self);
        make.top.equalTo(self.mas_bottom).priorityLow();
    }];
    
    [UIView animateWithDuration:[ZKActionSheetConfiguration sharedInstance].animationDuration animations:^{
        self.dimBackgroundView.alpha = 0;
        [self layoutIfNeeded];
    } completion:completion];
}

#pragma mark - getters and setters

- (ZKActionSheetView *)shareSheetView {
    if (!_shareSheetView) {
        _shareSheetView = [[ZKActionSheetView alloc] init];
        if (@available(iOS 13, *)) {
            _shareSheetView.backgroundColor = [UIColor secondarySystemBackgroundColor];
        } else {
            _shareSheetView.backgroundColor = [UIColor whiteColor];
        }
        
        if (@available(iOS 11, *)) {
            _shareSheetView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
            _shareSheetView.layer.cornerRadius = 10;
            _shareSheetView.layer.masksToBounds = YES;
        }
        
        __weak __typeof(self) weakSelf = self;
        _shareSheetView.cancelBlock = ^{
            [weakSelf hide];
        };
    }
    return _shareSheetView;
}

- (UIView *)dimBackgroundView {
    if (!_dimBackgroundView) {
        _dimBackgroundView = [[UIView alloc] init];
        _dimBackgroundView.backgroundColor = [UIColor blackColor];
        _dimBackgroundView.alpha = 0;
        
        // 添加手势监听
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_dimBackgroundView addGestureRecognizer:tap];
    }
    return _dimBackgroundView;
}

- (void)setTitle:(NSString *)title {
    self.shareSheetView.titleLabel.text = title;
    
    [self.shareSheetView setNeedsUpdateConstraints];
    [self.shareSheetView updateConstraintsIfNeeded];
}

- (NSString *)title {
    return self.shareSheetView.titleLabel.text;
}

- (UIButton *)cancelButton {
    return self.shareSheetView.cancelButton;
}


@end

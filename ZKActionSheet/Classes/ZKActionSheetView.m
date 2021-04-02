//
//  ZKActionSheetView.m
//  Pods
//
//  Created by Kaiser on 2017/3/8.
//
//

#import "ZKActionSheetView.h"
#import "ZKActionSheetCell.h"
#import "ZKActionSheetConfiguration.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import <ZKCategories/ZKCategories.h>

@interface ZKActionSheetView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MASConstraint *titleLabelHC0;
@property (nonatomic, strong) MASConstraint *titleLabelHC30;
@property (nonatomic, assign) BOOL hasInstalledConstraints;

@end

@implementation ZKActionSheetView

@synthesize dataSource = _dataSource;

#pragma mark - Initializer

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.translucent = YES;
    [self setBackgroundImage:UIImage.new forToolbarPosition:0 barMetrics:0];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self.tableView registerClass:[ZKActionSheetCell class] forCellReuseIdentifier:NSStringFromClass(ZKActionSheetCell.class)];
    
    return self;
}

#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.dataSource[indexPath.row];
    
    ZKActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZKActionSheetCell.class)
                                                             forIndexPath:indexPath];
    cell.dataSource = items;
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - events Handler

- (void)didTappedCancelButton {
    !self.cancelBlock ?: self.cancelBlock();
}

#pragma mark - Private Methods

- (CGFloat)shareSheetHeight {
    CGFloat itemHeight = [ZKActionSheetConfiguration sharedInstance].itemHeight;
    return self.initialHeight + self.dataSource.count * itemHeight - 1; // 这个-1用来让取消button挡住下面cell的seperator
}

- (CGFloat)initialHeight {
    return [ZKActionSheetConfiguration sharedInstance].cancelButtonHeight + self.titleHeight;
}

- (CGFloat)titleHeight {
    return self.titleLabel.text.length ? 30 : 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //适配iOS11中UIToolbar无法点击问题
    if (@available(iOS 11.0, *)) {
        NSArray *array = self.subviews;
        for (UIView *each in array) {
            if ([each isKindOfClass:NSClassFromString(@"_UIToolbarContentView")]) {
                each.userInteractionEnabled = NO;
                break;
            }
        }
    }
}

- (void)updateConstraints {
    if (!self.hasInstalledConstraints) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11, *)) {
                make.top.equalTo(self).offset(10);
            } else {
                make.top.equalTo(self);
            }
            make.centerX.equalTo(self);
            make.width.lessThanOrEqualTo(self).with.offset(-40).priorityHigh();
            self.titleLabelHC0 = make.height.mas_equalTo(0).priorityHigh();
            self.titleLabelHC30 = make.height.mas_equalTo(30);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.width.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom);
            make.left.and.width.equalTo(self);
//            make.height.mas_equalTo([ZKActionSheetConfiguration sharedInstance].cancelButtonHeight);
//            if (@available(iOS 11.0, *)) {
//                make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom).priorityHigh();
//            } else {
//                make.bottom.lessThanOrEqualTo(self).priorityHigh();
//            }

            CGFloat safeArea = [self safeAreaBottom];
            make.height.mas_equalTo([ZKActionSheetConfiguration sharedInstance].cancelButtonHeight + safeArea);
            make.bottom.equalTo(self).priorityHigh();
        }];

        self.hasInstalledConstraints = YES;
    }

    [self.titleLabelHC0 deactivate];
    [self.titleLabelHC30 deactivate];

    if (0 == self.titleLabel.text.length) {
        [self.titleLabelHC0 activate];
    } else {
        [self.titleLabelHC30 activate];
    }

    [super updateConstraints];
}

#pragma mark - getters and setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.text = @"分享";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];

        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = [ZKActionSheetConfiguration sharedInstance].itemHeight;
        _tableView.bounces = NO;
        _tableView.backgroundColor = nil;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.delaysContentTouches = NO;
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        CGFloat bottom = [self safeAreaBottom];
        UIColor *color = [UIColor colorWithHexString:@"#F8F8FF"];

        _cancelButton = [[UIButton alloc] init];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, bottom, 0);
        [_cancelButton setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self
                          action:@selector(didTappedCancelButton)
                forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.dataSource.count * [ZKActionSheetConfiguration sharedInstance].itemHeight);
    }];
}

- (CGFloat)safeAreaBottom {
    CGFloat safeArea = 0;
    if (@available(iOS 11.0, *)) safeArea = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    return safeArea;
}

@end

//
//  ZKActionSheetCell.m
//  Pods
//
//  Created by Kaiser on 2017/3/8.
//
//

#import "ZKActionSheetCell.h"
#import "ZKActionItemCell.h"
#import "ZKActionItem.h"
#import "ZKActionSheetConfiguration.h"

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

@interface ZKActionSheetCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) BOOL hasInstalledConstraints;

@end

@implementation ZKActionSheetCell

#pragma mark - Initializer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZKActionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZKActionItemCell class])
                                                                      forIndexPath:indexPath];
    
    ZKActionItem *item = self.items[indexPath.item];
    NSAssert([item isKindOfClass:[ZKActionItem class]], @"数组`shareArray`或者`functionArray`的元素必须为ZKActionItem对象");
    cell.item = item;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - Private Methods

- (void)updateConstraints {
    if (!self.hasInstalledConstraints) {
        self.backgroundColor = nil;
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.hasInstalledConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - getters and setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.alwaysBounceHorizontal = YES; // 小于等于一页时, 允许bounce
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.delaysContentTouches = NO;
        if (@available(iOS 13, *)) {
            _collectionView.backgroundColor = [UIColor secondarySystemBackgroundColor];
        } else {
            _collectionView.backgroundColor = [UIColor whiteColor];
        }
        
        [_collectionView registerClass:[ZKActionItemCell class]
            forCellWithReuseIdentifier:NSStringFromClass([ZKActionItemCell class])];
        
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake([ZKActionSheetConfiguration sharedInstance].itemWidth,
                                          [ZKActionSheetConfiguration sharedInstance].itemHeight);
    }
    return _flowLayout;
}

@end

//
//  ZKActionItemCell.h
//  Pods
//
//  Created by Kaiser on 2017/3/7.
//
//

#import <UIKit/UIKit.h>

@class ZKActionItem;

extern NSString *const ZKActionSheetWillHideNotification;

@interface ZKActionItemCell : UICollectionViewCell

@property (nonatomic, strong) ZKActionItem *item;

@end

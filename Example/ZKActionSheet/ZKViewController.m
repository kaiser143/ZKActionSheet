//
//  ZKViewController.m
//  ZKActionSheet
//
//  Created by deyang143@126.com on 04/02/2021.
//  Copyright (c) 2021 deyang143@126.com. All rights reserved.
//

#import "ZKViewController.h"
#import <ZKActionSheet/ZKActionSheet.h>

@interface ZKViewController ()

@end

@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTappedButton)];
}

- (void)didTappedButton {
    // 创建代表每个按钮的模型
    __weak __typeof(self) weakSelf = self;
    ZKActionItem *item0            = [ZKActionItem itemWithTitle:@"发送给朋友" icon:@"Action_Share" didTappedHandler:^{ [weakSelf itemAction:@"点击了发送给朋友"]; }];

    ZKActionItem *item1 = [ZKActionItem itemWithTitle:@"分享到朋友圈" icon:@"Action_Moments" didTappedHandler:^{ [weakSelf itemAction:@"点击了分享到朋友圈"]; }];

    ZKActionItem *item2 = [ZKActionItem itemWithTitle:@"收藏" icon:@"Action_MyFavAdd" didTappedHandler:^{ [weakSelf itemAction:@"点击了收藏"]; }];

    ZKActionItem *item3 = [ZKActionItem itemWithTitle:@"QQ空间" icon:@"Action_qzone" didTappedHandler:^{ [weakSelf itemAction:@"点击了QQ空间"]; }];

    ZKActionItem *item4 = [ZKActionItem itemWithTitle:@"QQ" icon:@"Action_QQ" didTappedHandler:^{ [weakSelf itemAction:@"点击了QQ"]; }];

    ZKActionItem *item5 = [ZKActionItem itemWithTitle:@"Facebook" icon:@"Action_facebook" didTappedHandler:^{ [weakSelf itemAction:@"点击了Facebook"]; }];

    ZKActionItem *item6 = [ZKActionItem itemWithTitle:@"查看公众号" icon:@"Action_Verified" didTappedHandler:^{ [weakSelf itemAction:@"点击了查看公众号"]; }];

    ZKActionItem *item7 = [ZKActionItem itemWithTitle:@"复制链接" icon:@"Action_Copy" didTappedHandler:^{ [weakSelf itemAction:@"点击了复制链接"]; }];

    ZKActionItem *item8 = [ZKActionItem itemWithTitle:@"调整字体" icon:@"Action_Font" didTappedHandler:^{ [weakSelf itemAction:@"点击了调整字体"]; }];

    ZKActionItem *item9 = [ZKActionItem itemWithTitle:@"刷新" icon:@"Action_Refresh" didTappedHandler:^{ [weakSelf itemAction:@"点击了刷新"]; }];

    NSArray *shareItemsArray    = @[item0, item1, item2, item3, item4, item5];
    NSArray *functionItemsArray = @[item6, item7, item8, item9];

    // 创建ZKActionSheet
    ZKActionSheet *actionSheet = [ZKActionSheet shareViewWithShareItems:shareItemsArray functionItems:functionItemsArray];
    actionSheet.title          = @"create by kaiser";
    // 弹出ZKActionSheet
    [actionSheet show];
}

- (void)itemAction:(NSString *)strings {
    NSLog(@"%@", strings);
}

@end

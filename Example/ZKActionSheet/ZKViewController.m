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
    ZKActionItem *item0            = [ZKActionItem actionWithTitle:@"发送给朋友" icon:@"Action_Share" handler:^{ [weakSelf itemAction:@"点击了发送给朋友"]; }];

    ZKActionItem *item1 = [ZKActionItem actionWithTitle:@"分享到朋友圈" icon:@"Action_Moments" handler:^{ [weakSelf itemAction:@"点击了分享到朋友圈"]; }];

    ZKActionItem *item2 = [ZKActionItem actionWithTitle:@"收藏" icon:@"Action_MyFavAdd" handler:^{ [weakSelf itemAction:@"点击了收藏"]; }];

    ZKActionItem *item3 = [ZKActionItem actionWithTitle:@"QQ空间" icon:@"Action_qzone" handler:^{ [weakSelf itemAction:@"点击了QQ空间"]; }];

    ZKActionItem *item4 = [ZKActionItem actionWithTitle:@"QQ" icon:@"Action_QQ" handler:^{ [weakSelf itemAction:@"点击了QQ"]; }];

    ZKActionItem *item5 = [ZKActionItem actionWithTitle:@"Facebook" icon:@"Action_facebook" handler:^{ [weakSelf itemAction:@"点击了Facebook"]; }];

    ZKActionItem *item6 = [ZKActionItem actionWithTitle:@"查看公众号" icon:@"Action_Verified" handler:^{ [weakSelf itemAction:@"点击了查看公众号"]; }];

    ZKActionItem *item7 = [ZKActionItem actionWithTitle:@"复制链接" icon:@"Action_Copy" handler:^{ [weakSelf itemAction:@"点击了复制链接"]; }];

    ZKActionItem *item8 = [ZKActionItem actionWithTitle:@"调整字体" icon:@"Action_Font" handler:^{ [weakSelf itemAction:@"点击了调整字体"]; }];

    ZKActionItem *item9 = [ZKActionItem actionWithTitle:@"刷新" icon:@"Action_Refresh" handler:^{ [weakSelf itemAction:@"点击了刷新"]; }];

    NSArray *shareItemsArray    = @[item0, item1, item2, item3, item4, item5];
    NSArray *functionItemsArray = @[item6, item7, item8, item9];

    // 创建ZKActionSheet
    ZKActionSheet *actionSheet = [ZKActionSheet actionSheetWithShareItems:shareItemsArray functionItems:functionItemsArray];
    actionSheet.title          = @"create by kaiser";
    // 弹出ZKActionSheet
    [actionSheet show];
}

- (void)itemAction:(NSString *)strings {
    NSLog(@"%@", strings);
}

@end

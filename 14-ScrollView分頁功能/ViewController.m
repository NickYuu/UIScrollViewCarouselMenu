//
//  ViewController.m
//  14-ScrollView分頁功能
//
//  Created by 游宗翰 on 2016/9/14.
//  Copyright © 2016年 han. All rights reserved.
//

#import "ViewController.h"
#import "YUPageView.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YUPageView *pageView = [YUPageView pageView];
    pageView.center = self.view.center;
    pageView.imageNames = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:pageView];
}

@end

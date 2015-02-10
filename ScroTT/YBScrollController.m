//
//  YBScrollController.m
//  ScroTT
//
//  Created by shejun.zhou on 15/2/9.
//  Copyright (c) 2015年 YiBan.iOS. All rights reserved.
//

#import "YBScrollController.h"
#import "YBScrollView.h"

/** @name 获取屏幕 宽度、高度 及 状态栏 高度 */
// @{
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// @}end of 获取屏幕 宽度、高度 及 状态栏 高度

@interface YBScrollController ()<YBScrollViewDelegate>

@end

@implementation YBScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    YBScrollView *scrollView = [[YBScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 144)];
/*  YBScrollView *scrollView = [[YBScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 100, SCREEN_WIDTH, 100);
 */
    scrollView.arrayContext = [NSMutableArray arrayWithObjects:@"one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one ", @"tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow ", @"three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three ", @"four four four four four four four four four four four four four four four four four four four four four four four four four four four ", nil];
    scrollView.delegate = self;
    scrollView.direction = directionUp;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - YBScrollViewDelegate

- (void)didSelectRowActionWithString:(NSString *)string {
    NSLog(@"%@", string);
}

@end

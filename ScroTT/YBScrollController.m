//
//  YBScrollController.m
//  ScroTT
//
//  Created by shejun.zhou on 15/2/9.
//  Copyright (c) 2015年 YiBan.iOS. All rights reserved.
//

#import "YBScrollController.h"

/** @name 获取屏幕 宽度、高度 及 状态栏 高度 */
// @{
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// @}end of 获取屏幕 宽度、高度 及 状态栏 高度

static float cellHeight = 60.0f;


@interface YBScrollController () <UITableViewDataSource, UITableViewDelegate> {
    NSInteger currentIndexPathRow;
}

@property (nonatomic, strong) UITableView *myTableView; ///< 显示滚动内容视图

@end

@implementation YBScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    if (!_arrayContext) {//test
        _arrayContext = [NSMutableArray arrayWithObjects:@"one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one one ", @"tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow tow ", @"three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three three ", @"four four four four four four four four four four four four four four four four four four four four four four four four four four four ", nil];
    }
    currentIndexPathRow = 1;
    if (!direction) {//default
        direction = directionDown;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, cellHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.pagingEnabled = YES;
    tableView.showsVerticalScrollIndicator = NO;
    self.myTableView = tableView;
    [self.view addSubview:self.myTableView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollToPreviousIndexPath) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayContext count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCellId = @"strCellId";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:strCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.arrayContext[indexPath.row]];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    NSLog(@"%ld", (long)indexPath.row);
    currentIndexPathRow = indexPath.row;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

#pragma mark - 
- (void)removeLastObjectToFirst {
    [self.arrayContext insertObject:[self.arrayContext lastObject] atIndex:0];
    [self.arrayContext removeLastObject];
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.myTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

- (void)removeFirstObjectToLast {
    [self.arrayContext addObject:self.arrayContext[0]];
    [self.arrayContext removeObjectAtIndex:0];
    NSIndexPath *path = [NSIndexPath indexPathForRow:(self.arrayContext.count-2) inSection:0];
    [self.myTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

#pragma mark -
/** 定时自动滚动 */
- (void)autoScrollToPreviousIndexPath {
    NSIndexPath *path = nil;
    switch (direction) {
        case directionDown:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == 0 ? 0 : (currentIndexPathRow-1)) inSection:0];
            if (currentIndexPathRow == 0) {
                [self removeLastObjectToFirst];
            }
        }
            break;
        case directionUp:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == (self.arrayContext.count-1) ? 0 : (currentIndexPathRow+1)) inSection:0];
            if (currentIndexPathRow == self.arrayContext.count - 1){
                [self removeFirstObjectToLast];
            }
        }
            break;
        default:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == 0 ? 0 : (currentIndexPathRow-1)) inSection:0];
        }
            break;
    }
    [self.myTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
    [self.myTableView reloadData];
}

@end

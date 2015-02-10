//
//  YBScrollView.m
//  ScroTT
//
//  Created by shejun.zhou on 15/2/10.
//  Copyright (c) 2015年 YiBan.iOS. All rights reserved.
//

#import "YBScrollView.h"

@interface YBScrollView ()<UITableViewDataSource, UITableViewDelegate> {
    NSInteger currentIndexPathRow;
}

@property (nonatomic, strong) UITableView *myTableView; ///< 显示滚动内容视图

@end

@implementation YBScrollView

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor whiteColor];
    currentIndexPathRow = 1;
    if (!_direction) {//default
        _direction = directionDown;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.pagingEnabled = YES;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView = tableView;
    [self addSubview:self.myTableView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollToPreviousIndexPath) userInfo:nil repeats:YES];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return self.frame.size.height > 0 ? self.frame.size.height : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectRowActionWithString:)]) {
        [self.delegate didSelectRowActionWithString:self.arrayContext[indexPath.row]];
    }
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
    switch (_direction) {
        case directionDown:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == 0 ? 0 : (currentIndexPathRow-1)) inSection:0];
        }
            break;
        case directionUp:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == (self.arrayContext.count-1) ? 0 : (currentIndexPathRow+1)) inSection:0];
        }
            break;
        default:{
            path = [NSIndexPath indexPathForRow:(currentIndexPathRow == 0 ? 0 : (currentIndexPathRow-1)) inSection:0];
        }
            break;
    }
    [self.myTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
    if (currentIndexPathRow == 0) {
        [self removeLastObjectToFirst];
    }
    if (currentIndexPathRow == self.arrayContext.count - 1){
        [self removeFirstObjectToLast];
    }
    [self.myTableView reloadData];
}

@end

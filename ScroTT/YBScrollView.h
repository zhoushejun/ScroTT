//
//  YBScrollView.h
//  ScroTT
//
//  Created by shejun.zhou on 15/2/10.
//  Copyright (c) 2015年 YiBan.iOS. All rights reserved.
//


/**
 @file          YBScrollView.h
 
 @author		shejun.zhou
 @version		1.0
 @date          2015-02-10
 @copyright     shejun.zhou
 
 @brief         滑动视图
 */

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    directionUp,    ///< 向上滑动
    directionDown,  ///< 向下滑动
} Direction;        ///< 滑动方向

/**
 *@delegate YBScrollViewDelegate
 */
@protocol YBScrollViewDelegate <NSObject>

- (void)didSelectRowActionWithString:(NSString *)string;

@end

/** 
 *@class YBScrollView
 */
@interface YBScrollView : UIView {
}

@property (nonatomic, strong) NSMutableArray *arrayContext;     ///< 需要显示的文字内容
@property (nonatomic) Direction direction;                      ///< 表格滑动方向
@property (nonatomic, assign) id<YBScrollViewDelegate> delegate;///< 委托

@end

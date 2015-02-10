//
//  YBScrollController.h
//  ScroTT
//
//  Created by shejun.zhou on 15/2/9.
//  Copyright (c) 2015年 YiBan.iOS. All rights reserved.
//


/**
 @file          YBScrollController.h
 
 @author		shejun.zhou
 @version		1.0
 @date          2015-02-09
 @copyright     shejun.zhou
 
 @brief         循环滚动
 */


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    directionUp,    ///< 向上滑动
    directionDown,  ///< 向下滑动
} Direction;        ///< 滑动方向

@interface YBScrollController : UIViewController {
    Direction direction;  ///<表格滑动方向
}

@property (nonatomic, strong) NSMutableArray *arrayContext; ///< 需要显示的文字内容

@end

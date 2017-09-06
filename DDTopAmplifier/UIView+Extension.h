//
//  UIView+Extension.h
//  SZShop
//
//  Created by szgw on 16/10/25.
//  Copyright © 2016年 SZGW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGSize dd_size;
@property (nonatomic, assign) CGFloat dd_width;
@property (nonatomic, assign) CGFloat dd_height;
@property (nonatomic, assign) CGFloat dd_x;
@property (nonatomic, assign) CGFloat dd_y;
@property (nonatomic, assign) CGFloat dd_centerX;
@property (nonatomic, assign) CGFloat dd_centerY;

@property (nonatomic,assign) CGFloat dd_top;
@property (nonatomic,assign) CGFloat dd_bottom;
@property (nonatomic,assign) CGFloat dd_right;
@property (nonatomic,assign) CGFloat dd_left;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;

- (void)removeAllSubviews;

- (UIViewController *)getCurrentVc;

CGFloat OnePixelToPoint(void);
@end

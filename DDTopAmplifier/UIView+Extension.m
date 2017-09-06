//
//  UIView+Extension.m
//  SZShop
//
//  Created by szgw on 16/10/25.
//  Copyright © 2016年 SZGW. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setDd_size:(CGSize)dd_size
{
    CGRect frame = self.frame;
    frame.size = dd_size;
    self.frame = frame;
}

- (CGSize)dd_size
{
    return self.frame.size;
}

- (void)setDd_width:(CGFloat)dd_width
{
    CGRect frame = self.frame;
    frame.size.width = dd_width;
    self.frame = frame;
}


- (void)setDd_height:(CGFloat)dd_height
{
    CGRect frame = self.frame;
    frame.size.height = dd_height;
    self.frame = frame;
}

- (void)setDd_x:(CGFloat)dd_x
{
    CGRect frame = self.frame;
    frame.origin.x = dd_x;
    self.frame = frame;
}

- (void)setDd_y:(CGFloat)dd_y
{
    CGRect frame = self.frame;
    frame.origin.y = dd_y;
    self.frame = frame;
}

- (void)setDd_centerX:(CGFloat)dd_centerX
{
    CGPoint center = self.center;
    center.x = dd_centerX;
    self.center = center;
}

- (void)setDd_centerY:(CGFloat)dd_centerY
{
    CGPoint center = self.center;
    center.y = dd_centerY;
    self.center = center;
}


- (CGFloat)dd_centerY
{
    return self.center.y;
}

- (CGFloat)dd_centerX
{
    return self.center.x;
}

- (CGFloat)dd_width
{
    return self.frame.size.width;
}

- (CGFloat)dd_height
{
    return self.frame.size.height;
}

- (CGFloat)dd_x
{
    return self.frame.origin.x;
}

- (CGFloat)dd_y
{
    return self.frame.origin.y;
}

- (CGFloat)dd_top
{
    return self.frame.origin.y;
}

- (void)setDd_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)dd_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDd_right:(CGFloat)dd_right
{
    CGRect frame = self.frame;
    frame.origin.x = dd_right - self.frame.size.width;
    self.frame = frame;
}


- (CGFloat)dd_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setDd_bottom:(CGFloat)dd_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = dd_bottom - self.frame.size.height;
    self.frame = frame;
}


- (CGFloat)dd_left
{
    return self.frame.origin.x;
}


- (void)setDd_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)getCurrentVc
{
    UIViewController *vc = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        vc = nextResponder;
    else
        vc = window.rootViewController;
    
    return vc;
}

CGFloat OnePixelToPoint(void)
{
    static CGFloat onePixelWidth = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onePixelWidth = 1.f / [UIScreen mainScreen].scale;
    });
    
    return onePixelWidth;
}

@end

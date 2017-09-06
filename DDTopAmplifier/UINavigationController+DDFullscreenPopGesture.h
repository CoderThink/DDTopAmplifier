//
//  UINavigationController+DDFullscreenPopGesture.h
//  DDTopAmplifier
//
//  Created by Think on 2017/9/5.
//  Copyright © 2017年 Think. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DDFullscreenPopGesture)

// 自定义全屏拖拽返回手势
@property (nonatomic,strong,readonly) UIPanGestureRecognizer *dd_popGestureRecognizer;
@end

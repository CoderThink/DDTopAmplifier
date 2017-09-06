//
//  UINavigationController+DDFullscreenPopGesture.m
//  DDTopAmplifier
//
//  Created by Think on 2017/9/5.
//  Copyright © 2017年 Think. All rights reserved.
//

#import "UINavigationController+DDFullscreenPopGesture.h"
#import <objc/runtime.h>

@interface DDFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic,weak) UINavigationController *navigationController;

@end

@implementation DDFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return YES;
}

@end

@implementation UINavigationController (DDFullscreenPopGesture)

+ (void)load{
    
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(dd_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)dd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.dd_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.dd_popGestureRecognizer];
        
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.dd_popGestureRecognizer.delegate = [self dd_fullScreenPopGestureRecognizerDelegate];
        [self.dd_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self dd_pushViewController:viewController animated:animated];
    }
}

- (DDFullScreenPopGestureRecognizerDelegate *)dd_fullScreenPopGestureRecognizerDelegate{
    DDFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[DDFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)dd_popGestureRecognizer{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}
@end

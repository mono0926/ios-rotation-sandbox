//
//  ObjcHelper.m
//  ios-rotation-sandbox
//
//  Created by mono on 4/29/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

#import "ObjcHelper.h"
@import UIKit;

@implementation ObjcHelper

+ (id<AspectToken>)aspect_viewControllerHookSelector:(SEL)selector
                                         withOptions:(AspectOptions)options
                                               error:(NSError **)error
                                          usingBlock:(AspectsHookActionBlock)block {
    
    return [UIViewController aspect_hookSelector:selector withOptions:options usingBlock:block error:error];
}
+ (id<AspectToken>)aspect_navigationControllerHookSelector:(SEL)selector
                                               withOptions:(AspectOptions)options
                                                     error:(NSError **)error
                                                usingBlock:(AspectsHookActionBlock)block {
    
    return [UINavigationController aspect_hookSelector:selector withOptions:options usingBlock:block error:error];
}
+(BOOL)isFullScreenAVPlayer:(UIViewController*)viewController
{
    return [viewController isKindOfClass:NSClassFromString(@"AVFullScreenViewController")];
}
@end

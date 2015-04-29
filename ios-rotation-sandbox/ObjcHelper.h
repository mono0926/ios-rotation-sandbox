//
//  ObjcHelper.h
//  ios-rotation-sandbox
//
//  Created by mono on 4/29/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"
@import UIKit;

typedef void (^AspectsHookActionBlock)(id<AspectInfo> aspectInfo);

@interface ObjcHelper : NSObject
+ (id<AspectToken>)aspect_viewControllerHookSelector:(SEL)selector
                                         withOptions:(AspectOptions)options
                                               error:(NSError **)error
                                          usingBlock:(AspectsHookActionBlock)block;
+ (id<AspectToken>)aspect_navigationControllerHookSelector:(SEL)selector
                                               withOptions:(AspectOptions)options
                                                     error:(NSError **)error
                                                usingBlock:(AspectsHookActionBlock)block;
+ (BOOL)isFullScreenAVPlayer:(UIViewController*)viewController;
@end

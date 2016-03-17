//
//  LYTouch.h
//  LYDemo
//
//  Created by liyang on 16/3/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^touchBlock)(BOOL success, NSString *failMessage);

@interface LYTouch : NSObject

+ (instancetype)sharedInstance;

- (void)isSupportTouch:(touchBlock)block;

@end

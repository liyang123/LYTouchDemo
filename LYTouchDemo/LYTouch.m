//
//  LYTouch.m
//  LYDemo
//
//  Created by liyang on 16/3/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "LYTouch.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation LYTouch
+ (instancetype)sharedInstance
{
    static LYTouch *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

- (void)isSupportTouch:(touchBlock)block
{
    //初始化上下文对象
    LAContext * context = [[LAContext alloc] init];
    //检查设备是否支持touch
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        //不支持touch,直接返回
        block(NO, @"设备不支持touch");
        return;
    }
    
    //指纹验证
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"touch" reply:^(BOOL success, NSError *error) {
        if (success) {
            //验证成功，主线程处理UI
            block(YES, @"验证成功");
        }else{
            switch (error.code) {
                case LAErrorSystemCancel:{
                    // 切换到其他APP，系统取消验证Touch ID
                    block(NO, @"系统取消验证Touch ID");
                    break;
                }
                case LAErrorUserCancel:{
                    //用户取消验证Touch ID
                    block(NO, @"用户取消验证Touch ID");
                    break;
                }
                case LAErrorUserFallback:{
                     //用户选择输入密码，切换主线程处理
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 主线程处理UI
                        block(NO, @"用户选择输入密码");
                    });
                    break;
                }
                default:{
                    block(NO, @"其他未知情况");
                }
                    break;
            }
        }
    }];
}
@end

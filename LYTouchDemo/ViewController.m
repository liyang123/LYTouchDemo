//
//  ViewController.m
//  LYTouchDemo
//
//  Created by liyang on 16/3/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "ViewController.h"
#import "LYTouch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)btn1 {
    [[LYTouch sharedInstance] isSupportTouch:^(BOOL success, NSString *failMessage) {
        if (success) {
            NSLog(@"成功");
        }else{
            NSLog(@"%@", failMessage);
        }
    }];
}

@end

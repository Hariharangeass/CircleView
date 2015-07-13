//
//  ViewController.m
//  Example
//
//  Created by Limingkai on 15/7/13.
//  Copyright (c) 2015年 SINOSOFT. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    circleView.center = self.view.center;
    [self.view addSubview:circleView];
    
    circleView.percent = 80;
    circleView.lineWidth = 15.0f;
    circleView.processStrokeColor = [UIColor redColor];
    circleView.trackStrokeColor = [UIColor yellowColor];
    circleView.fillColor = [UIColor greenColor];
    circleView.textColor = [UIColor grayColor];
    circleView.textFont = [UIFont systemFontOfSize:50 weight:12];
}

@end

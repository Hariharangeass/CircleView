//
//  CircleView.m
//  CirelceView
//
//  Created by Limingkai on 15/7/13.
//  Copyright (c) 2015年 SINOSOFT. All rights reserved.
//


#define LINEWIDTH 20

#import "CircleView.h"
#import <POP/POP.h>


@interface CircleView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;//轨迹层
@property (nonatomic, strong) CAShapeLayer *progressLayer;//进度层
@property (nonatomic, strong) UILabel      *percentLabel;//进度数字显示

@end

@implementation CircleView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

//圆形初始化
- (void)setUp{
   
    //创建一个轨迹层
    _trackLayer             = [CAShapeLayer layer];
    //设置大小
    _trackLayer.frame       = self.bounds;
    //设置填充颜色
    _trackLayer.fillColor   = [UIColor clearColor].CGColor;
    //设置画笔颜色
    _trackLayer.strokeColor = [[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1] CGColor];
    //设置透明度
    _trackLayer.opacity     = 1;
    //设置线的端为圆形
    _trackLayer.lineCap     = kCALineCapRound;
    //设置线的宽度
    _trackLayer.lineWidth   = LINEWIDTH;
    UIBezierPath *path      = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _trackLayer.path =[path CGPath];
    [self.layer addSublayer:_trackLayer];
    
    //绘制进度层
    _progressLayer             = [CAShapeLayer layer];
    _progressLayer.frame       = self.bounds;
    _progressLayer.fillColor   = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor = [[UIColor blueColor] CGColor];
    _progressLayer.lineCap     = kCALineCapRound;
    _progressLayer.lineWidth   = LINEWIDTH;
    _progressLayer.path        = [path CGPath];
    _progressLayer.strokeEnd   = 0;
    [self.layer addSublayer:_progressLayer];
    
    _percentLabel = [[UILabel alloc] init];
    _percentLabel.font = [UIFont systemFontOfSize:40];
    _percentLabel.text = @"0";
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    [_percentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    _percentLabel.numberOfLines = 0;
    [_percentLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_percentLabel];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_percentLabel
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.f],
                           
                           [NSLayoutConstraint constraintWithItem:_percentLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.f]
                           ]];
}

#pragma mark - SETTER

- (void)setTrackStrokeColor:(UIColor *)trackStrokeColor {
    _trackStrokeColor = trackStrokeColor;
    _trackLayer.strokeColor = trackStrokeColor.CGColor;
}

- (void)setProcessStrokeColor:(UIColor *)processStrokeColor {
    _processStrokeColor = processStrokeColor;
    _progressLayer.strokeColor = processStrokeColor.CGColor;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    _trackLayer.fillColor = fillColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _trackLayer.lineWidth = lineWidth;
    _progressLayer.lineWidth = lineWidth;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [_percentLabel setFont:textFont];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [_percentLabel setTextColor:textColor];
}

- (void)setPercent:(NSInteger)percent {
    
    POPBasicAnimation *animation   = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animation.toValue             = @(percent / 100.0f);
    animation.duration            = 1;
    animation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_progressLayer pop_addAnimation:animation forKey:@"process animation"];
    
    [self.percentLabel pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 1;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        };
        // write value
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setText:[NSString stringWithFormat:@"%.0f",values[0]]];
        };
        // dynamics threshold
        prop.threshold = 1;
    }];
    anim.property = prop;
    anim.fromValue = @(0.0);
    anim.toValue = @(percent);
    [self.percentLabel pop_addAnimation:anim forKey:@"counting"];
}

@end

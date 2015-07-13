//
//  CircleView.h
//  CirelceView
//
//  Created by Limingkai on 15/7/13.
//  Copyright (c) 2015年 SINOSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

/**
 *  轨迹画笔颜色
 */
@property (nonatomic, strong) UIColor *trackStrokeColor;

/**
 *  进度条画笔颜色
 */
@property (nonatomic, strong) UIColor *processStrokeColor;

/**
 *  填充颜色
 */
@property (nonatomic, strong) UIColor *fillColor;


/**
 *  线宽
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  进度条数值
 */
@property (nonatomic, assign) NSInteger percent;

/**
 *  字体大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

@end

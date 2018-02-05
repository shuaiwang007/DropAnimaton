//
//  MTAnimView.h
//  MTAnimView
//
//  Created by KimVii on 18/1/31.
//  Copyright © 2018年 KimVii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAnimView : UIView

/** X轴速度*/
@property (nonatomic, assign) CGFloat velX;
/** Y轴速度*/
@property (nonatomic, assign) CGFloat velY;
/** X轴坐标*/
@property (nonatomic, assign) CGFloat pointX;
/** Y轴坐标*/
@property (nonatomic, assign) CGFloat pointY;
/** 飞行方向 type = 0 左边开始 type = 1 右边开始*/
@property (nonatomic, assign) CGFloat type;
/** 旋转角度*/
@property (nonatomic, assign) CGFloat rotate;
/** 旋转阻力*/
@property (nonatomic, assign) CGFloat rotateResistance;
/** 旋转圆弧度*/
@property (nonatomic, assign) CGFloat rotateCircle;
/** 旋转最大值*/
@property (nonatomic, assign) CGFloat rotateMax;
/** 阻力*/
@property (nonatomic, assign) CGFloat resistance;
/** 重力*/
@property (nonatomic, assign) CGFloat gravity;
/** 图片*/
@property (nonatomic, strong) UIImage *img;
/** 宽*/
@property (nonatomic, assign) CGFloat width;
/** 高*/
@property (nonatomic, assign) CGFloat height;
/** 事件回调*/
@property (nonatomic, copy) void (^removeFormArr)(void);

- (void)remove;

- (instancetype)initWithAnimationImage:(UIImage *)img;

@end

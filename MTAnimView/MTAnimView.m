//
//  MTAnimView.m
//  MTAnimView
//
//  Created by KimVii on 18/1/31.
//  Copyright © 2018年 KimVii. All rights reserved.
//

#import "MTAnimView.h"

#define SCHeight ([UIScreen mainScreen].bounds.size.height)

#define SCWidth  ([UIScreen mainScreen].bounds.size.width)

#define LifeTime 300.0

@interface MTAnimView()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MTAnimView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithAnimationImage:(UIImage *)img {
    self = [super init];
    if (self) {
        [self setupUI];
        self.img = img;
    }
    return self;
}

- (void)setupUI {
    
    self.rotate = [self randomNumber] * M_PI;
    self.rotateResistance = ((arc4random_uniform(3) + 7) / 10.0);;
    self.rotateCircle = ((int)(arc4random_uniform(2) + 1));
    self.rotateMax = [self randomNumber] * M_PI / 4.0;
}

- (double)randomNumber {
    return ((arc4random_uniform(99) + 1) / 100.0);
}

- (void)remove {
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)updateWithRotate:(CGFloat)rotate {
    // 阻力
    self.velX *= self.resistance;
    self.velY *= self.resistance;
    // 重力
    self.velY += self.gravity;
    // 偏移量
    self.pointX += self.velX;
    self.pointY += self.velY;
    
    [UIView animateWithDuration:.025 animations:^{
        self.transform = CGAffineTransformMakeRotation(rotate);
        self.center = CGPointMake(self.pointX, self.pointY);
    }];
}

- (void)render {
    
    self.rotate += M_PI / 12.0 * self.rotateResistance * .5; // 每次生成随机角度
    
    self.rotateResistance -= 1 / LifeTime * .5;
    
    if (self.rotate > (2 * M_PI * self.rotateCircle)) { // 判断是否转了设定的圈数
        
        CGFloat rotateLR = (sin(self.rotate) * M_PI * .5 * self.rotateResistance) * .5; // 除数越大 幅度越小
        if (rotateLR > 0) {
            self.pointX += sin([self randomNumber] * M_PI * .5) * self.rotateResistance;
        } else {
            self.pointX -= sin([self randomNumber] * M_PI * .5) * self.rotateResistance;
        }
        
        [self updateWithRotate:rotateLR];
        
    } else {
        
        [self updateWithRotate:self.rotate];
    }
}
// 初始状态设置并发射
- (void)explode {
    
    CGFloat speed;
    // 根据左右不同判断不同
    if (self.type == 0) {
        self.pointX = 0;
        self.pointY = [self randomNumber] * SCHeight * .4 + SCHeight * .1;
        self.rotate = ([self randomNumber] * M_PI / 6.0 + M_PI / 6.0);
        speed = cos([self randomNumber] * M_PI / 2.0) * (10 * [self randomNumber] + 15);
    } else {
        self.pointX = SCWidth;
        self.pointY = [self randomNumber] * SCHeight * .4 + SCHeight * .1;
        self.rotate = ([self randomNumber] * M_PI / 2.0 + M_PI);
        speed = cos([self randomNumber] * M_PI / 2.0) * (10 * [self randomNumber] + 15);
    }
    // 设置此图形的大小
    self.frame = CGRectMake(self.pointX, self.pointY, self.width, self.height);
    self.velX = cos(self.rotate) * speed;
    self.velY = -fabs(sin(self.rotate) * speed);
    
    self.resistance = 0.93; // 阻力
    self.gravity = 0.08;    // 重力
    // 设置定时时间
    self.tag = LifeTime;

    self.timer = [NSTimer timerWithTimeInterval:.025 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self render];
        self.alpha = self.tag / LifeTime;
        if (!self.tag--) {
            [self.timer invalidate];
            self.timer = nil;
            [self.layer removeAllAnimations];
            [self removeFromSuperview];
        }
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setImg:(UIImage *)img {
    _img = img;
    
    self.width  = _img.size.width;
    self.height = _img.size.height;
    
    self.backgroundColor =  [UIColor colorWithPatternImage:_img];
    self.contentMode = UIViewContentModeScaleToFill;
    // 随机设置type
    self.type = arc4random_uniform(100) % 2;
    // 设置初始位置
    self.layer.anchorPoint = CGPointMake(0.5, 0);
    
    [self explode];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end

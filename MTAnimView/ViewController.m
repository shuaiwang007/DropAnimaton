//
//  ViewController.m
//  MTAnimView
//
//  Created by KimVii on 18/1/31.
//  Copyright © 2018年 KimVii. All rights reserved.
//

#import "ViewController.h"
#import "MTAnimView.h"
@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *giftArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.giftArr = [[NSMutableArray alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    MTAnimView *animView = [[MTAnimView alloc] initWithAnimationImage:[UIImage imageNamed:@"money"]];
    [self.view addSubview:animView];
    
    if (self.view.subviews.count > 40) {
        [self.view.subviews.firstObject.layer removeAllAnimations];
        [self.view.subviews.firstObject removeFromSuperview];
        NSLog(@"%zd", self.view.subviews.count);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

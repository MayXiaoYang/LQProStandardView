//
//  LQStandardCollectionReusableView.m
//  LQCustomClass
//
//  Created by liang lee on 2019/5/20.
//  Copyright © 2019 li xiao yang. All rights reserved.
//
/** 屏幕的宽高 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//适配屏幕宽高比
#define WidthRatio SCREEN_WIDTH/375.00
#import "LQStandardCollectionReusableView.h"

@implementation LQStandardCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}
-(void)configurationUI{
    
    UILabel *lab_standard = [[UILabel alloc]initWithFrame:CGRectMake(15*WidthRatio, 10*WidthRatio, SCREEN_WIDTH - 30*WidthRatio, 14*WidthRatio)];
    lab_standard.font = [UIFont systemFontOfSize:15.0f*WidthRatio];
    lab_standard.textAlignment = NSTextAlignmentLeft;
    lab_standard.backgroundColor = [UIColor whiteColor];
    lab_standard.textColor = [UIColor blackColor];
    [self addSubview:lab_standard];
    self.lab_standard = lab_standard;
}

@end

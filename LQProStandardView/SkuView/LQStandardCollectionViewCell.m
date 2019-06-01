//
//  LQStandardCollectionViewCell.m
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
#import "LQStandardCollectionViewCell.h"
@implementation LQStandardCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}

-(void)configurationUI{
    
    UILabel *lab_standard = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    lab_standard.text = @"规格";
    lab_standard.font = [UIFont systemFontOfSize:15.0f*WidthRatio];
    lab_standard.textAlignment = NSTextAlignmentCenter;
    lab_standard.layer.masksToBounds = YES;
    lab_standard.layer.cornerRadius = 3*WidthRatio;
    [self addSubview:lab_standard];
    self.lab_standard = lab_standard;
    
}

-(void)setModel:(LQStandardSonModel *)model{
    _model = model;
    self.lab_standard.frame = CGRectMake(0, 0, model.itemWidth, 30*WidthRatio);
}
@end

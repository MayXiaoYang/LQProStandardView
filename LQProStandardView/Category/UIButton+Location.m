//
//  UIButton+Location.m
//  LQCustomClass
//
//  Created by liang lee on 2019/3/28.
//  Copyright © 2019年 li xiao yang. All rights reserved.
//

#import "UIButton+Location.h"

@implementation UIButton (Location)

/** 左文右图 */
-(void)setBtnTextLeftAndImageRightWithSpace:(CGFloat)space{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.bounds.size.width - space, 0, self.imageView.bounds.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + space, 0, -self.titleLabel.bounds.size.width)];
}

/** 上图下文 */
-(void)setBtnImageTopAndTextBottomWithSpace:(CGFloat)space{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    // 测试的时候发现titleLabel的宽度不正确，这里进行判断处理
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
}


@end

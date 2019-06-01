//
//  UIButton+Location.h
//  LQCustomClass
//
//  Created by liang lee on 2019/3/28.
//  Copyright © 2019年 li xiao yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Location)

/** 设置button左文右图
 space 文字和图片之间的距离
 */
-(void)setBtnTextLeftAndImageRightWithSpace:(CGFloat)space;

/** 设置button上图下文 */
-(void)setBtnImageTopAndTextBottomWithSpace:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END

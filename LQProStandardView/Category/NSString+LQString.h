//
//  NSString+LQString.h
//  UIViewCategory
//
//  Created by LYKJ on 17/6/12.
//  Copyright © 2017年 LYKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (LQString)

////电话号码中间四位用****表示
+ (NSString *)replacePhoneNumWithStarWithPhoneNum:(NSString *)phoneNum;

////银行卡号中间八位用**** ****表示
+ (NSString *)replaceBlankCardNumWithStarWith:(NSString *)blankCardNum;

//转为电话格式
+ (NSString*) stringMobileFormat:(NSString*)mobile;

//数组中文格式（几万）可自行添加
+ (NSString*) stringChineseFormat:(double)value;

////计算文字高度
- (CGFloat)calControlheightWithFontSize:(NSFont *)font withControlWidth:(CGFloat)width;

////抹除运费小数末尾的0
- (NSString *)removeUnwantedZero;

////去掉字符串的前后空格
- (NSString *)fontOrBottomTrimmedString;

////判断是否是有效的电话号码
- (BOOL)isEffectivePhoneNumber;

////判断是否是有效的真实姓名
- (BOOL)isEffectiveRealName;

////判断字符串中是否只有中文
- (BOOL)stringIsOnlyChinese;

////判断银行卡号是否有效
- (BOOL)isEffectiveBlankCardNumber;

////判断是否是有效的邮箱
- (BOOL)isEffectiveEmailnumber;

////判断是否是有效的身份证号
//15位身份证号
- (BOOL)isEffectiveIndentifyNumberFifteen;
//18位身份证号
- (BOOL)isEffectiveIndentifyNumberEighteen;



@end

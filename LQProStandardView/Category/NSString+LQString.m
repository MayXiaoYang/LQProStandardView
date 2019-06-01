//
//  NSString+LQString.m
//  UIViewCategory
//
//  Created by LYKJ on 17/6/12.
//  Copyright © 2017年 LYKJ. All rights reserved.
//

#import "NSString+LQString.h"
@implementation NSString (LQString)
////电话号码中间四位*号表示
+(NSString *)replacePhoneNumWithStarWithPhoneNum:(NSString *)phoneNum{
    //转化成NSMutableString
    NSMutableString *newString = [NSMutableString stringWithString:phoneNum];
    //获得要替换成*号的字符串的range
    NSRange range = NSMakeRange(3, 4);
    //将要替换的字符串替换在指定的range处
    [newString replaceCharactersInRange:range withString:@"****"];
    return newString;
}
////银行卡中间8位用*号表示
+(NSString *)replaceBlankCardNumWithStarWith:(NSString *)blankCardNum{
    //转化成NSMutableString
    NSMutableString *newString = [NSMutableString stringWithString:blankCardNum];
    //获得要替换成*号的字符串的range
    NSRange range = NSMakeRange(4, 8);
    //将要替换的字符串替换在指定的range处
    [newString replaceCharactersInRange:range withString:@" **** **** "];
    return newString;
}
////将字符串转化为电话号码格式
+ (NSString *)stringMobileFormat:(NSString *)mobile{
    NSMutableString *phoneNum = [[NSMutableString alloc]initWithString:mobile];
    [phoneNum insertString:@" " atIndex:3];
    [phoneNum insertString:@" " atIndex:8];
    return phoneNum;
}
////中文格式（几万）可自行添加
+ (NSString *)stringChineseFormat:(double)value{
    if (value / 100000000 >= 1) {
        return [NSString stringWithFormat:@"%.0f",value/100000000];
    }else if (value / 10000 >= 1 && value / 100000000 < 1){
        return [NSString stringWithFormat:@"%.0f万",value / 10000];
    }else{
        return [NSString stringWithFormat:@"%.0f",value];
    }
}


////计算文字高度并取整
-(CGFloat)calControlheightWithFontSize:(NSFont *)font withControlWidth:(CGFloat)width{
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    height = ceil(height);
    return height;
}
////抹除运费小数末尾的0
-(NSString *)removeUnwantedZero{
    if ([[self substringWithRange:NSMakeRange(self.length - 3, 3)] isEqualToString:@"000"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-4)]; // 多一个小数点
    } else if ([[self substringWithRange:NSMakeRange(self.length- 2, 2)] isEqualToString:@"00"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-3)];
    } else if ([[self substringWithRange:NSMakeRange(self.length- 1, 1)] isEqualToString:@"0"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-2)];
    } else {
        
        return self;
    }
}
////去掉字符串的前后空格
-(NSString *)fontOrBottomTrimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

//判断手机号是否有效
- (BOOL)isEffectivePhoneNumber{
    //判断手机号是否有效的正则表达式
    NSString* const phoneNumber = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumber];
    return [predicate evaluateWithObject:self];
}
//判断姓名的真实性
- (BOOL)isEffectiveRealName{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [predicate evaluateWithObject:self];
}
//判断字符串中是否只有汉字
- (BOOL)stringIsOnlyChinese{
    NSString * chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}
//判断银行卡号的有效性
- (BOOL)isEffectiveBlankCardNumber{
    NSString* const BANKCARD = @"^(\\d{16}|\\d{19})$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}
//判断邮箱的有效性
- (BOOL)isEffectiveEmailnumber{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//判断是否是有效的身份证号
//15位
- (BOOL)isEffectiveIndentifyNumberFifteen{
    NSString * identifyTest=@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate*identifyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}
//18位
- (BOOL)isEffectiveIndentifyNumberEighteen{
    NSString * identifyTest=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate*identifyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",identifyTest];
    return [identifyPredicate evaluateWithObject:self];
}
@end

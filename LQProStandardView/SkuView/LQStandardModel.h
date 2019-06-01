//
//  LQStandardModel.h
//  LQCustomClass
//
//  Created by liang lee on 2019/5/20.
//  Copyright © 2019 li xiao yang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class LQStandardModel,LQStandardSonModel;
@interface LQStandardModel : NSObject

/** 商品父类标题 */
@property (nonatomic, copy)NSString *proStandardTitle;
/** 商品父类标题id */
@property (nonatomic, copy)NSString *proStandardTitleId;

@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic, assign)NSInteger proIdx;

@property (nonatomic, copy)NSArray <LQStandardSonModel *>*proArrs;

+(LQStandardModel *)modelWithDictionary:(NSDictionary *)dict;

@end

@interface LQStandardSonModel : NSObject

/** 商品字标题 */
@property (nonatomic, copy)NSString *proStandardName;
/** 商品子标题id */
@property (nonatomic, copy)NSString *proStandardNameId;

@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic, assign)NSInteger proIdx;

@property (nonatomic, assign)NSInteger itemWidth;

-(void)calItemWidth;

+(LQStandardSonModel *)modelWithDictionary:(NSDictionary *)dict;
@end


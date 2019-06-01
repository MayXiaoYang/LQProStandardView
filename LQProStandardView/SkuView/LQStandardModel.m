//
//  LQStandardModel.m
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
#import "LQStandardModel.h"
#import "MJExtension.h"

@implementation LQStandardModel
//+(NSDictionary *)mj_objectClassInArray{
//    return @{
//             @"proArrs":@"LQStandardSonModel"
//             };
//}
//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"proArrs":@"jsonArray",@"proStandardTitle":@"propesName",@"proStandardTitleId":@"propesId"};
//}


+(LQStandardModel *)modelWithDictionary:(NSDictionary *)dict{
    LQStandardModel *model = [[LQStandardModel alloc]init];
    model.proStandardTitle = [model objectOrNilForKey:@"propesName" fromDictionary:dict];
    model.proStandardTitleId = [model objectOrNilForKey:@"propesId" fromDictionary:dict];
    NSArray *arr_jsonArray = [model objectOrNilForKey:@"jsonArray" fromDictionary:dict];
    NSMutableArray *array_jsonArry = [[NSMutableArray alloc]initWithCapacity:0];
    [arr_jsonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LQStandardSonModel *model_son = [LQStandardSonModel modelWithDictionary:obj];
        if (idx == 0) {
            model_son.isSelected = YES;
        }
        [model_son calItemWidth];
        [array_jsonArry addObject:model_son];
    }];
    model.proArrs = array_jsonArry;
    return model;
}

-(id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? @"" : object;
}

@end
@implementation LQStandardSonModel

//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"proStandardName":@"provalue",@"proStandardNameId":@"provalueId"};
//}

+(LQStandardSonModel *)modelWithDictionary:(NSDictionary *)dict{
    LQStandardSonModel *model = [[LQStandardSonModel alloc]init];
    model.proStandardName = [model objectOrNilForKey:@"provalue" fromDictionary:dict];
    model.proStandardNameId = [model objectOrNilForKey:@"provalueId" fromDictionary:dict];
    return model;
}

-(id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? @"" : object;
}
-(void)calItemWidth{
    self.itemWidth = ceil((self.proStandardName.length + 2)*(15.0f*WidthRatio));
}

@end

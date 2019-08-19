//
//  LQSkuView.h
//  LQCustomClass
//
//  Created by liang lee on 2019/5/20.
//  Copyright © 2019 li xiao yang. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 关闭/购买按钮的的block回调 */
typedef void(^btnClickBlock)(void);
/** 规格信息block回调  proStandardStr 商品规格名称组合字符串 proStandardIdStr 商品规格名称组合id isReady 是否所有的规格都有选中状态*/
typedef void(^proStandardblock)(NSString *proStandardStr,NSString *proStandardIdStr,BOOL isReady);

@interface LQSkuView : UIView

@property (nonatomic, copy)btnClickBlock btnClick;
@property (nonatomic, copy)proStandardblock proStandard;

-(instancetype)initWithFrame:(CGRect)frame withDataSource:(NSMutableArray *)array_dataSource;
/** 用于首次创建规格view后自动调用规格信息block */
-(void)getProStndardMsg;

/** 商品图 */
@property (nonatomic, strong)UIImageView *proImg;
/** 商品库存 */
@property (nonatomic, strong)UILabel *lab_stock;
/** 商品规格 */
@property (nonatomic, strong)UILabel *lab_standard;
/** 商品价格 */
@property (nonatomic, strong)UILabel *lab_price;
/** 商品数量 */
@property (nonatomic, strong)UITextField *tf_proNum;
/** 商品规格选中的颜色 */
@property (nonatomic, strong)UIColor *skuSelectedColor;
/** 确定按钮的颜色 */
@property (nonatomic, strong)UIColor *sureBtnBackgroundColor;

@end


//
//  LQSkuView.m
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

/*设置字体的大小**/
#define FontThin(size) [UIFont systemFontOfSize:size]

/** tabbar底部安全区域高度 */
#define safeSeraH ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34.0f:0.0f)

/*设置RGB颜色**/
#define ColorWithRGB(Red,Green,Blue) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:1.0f]

#import "LQSkuView.h"
#import "LQStandardCollectionViewCell.h"
#import "LQStandardCollectionReusableView.h"
#import "UIButton+Location.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "LQStandardModel.h"
#import "UIView+LQFrame.h"
@interface LQSkuView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *array_dataSource;
@property (nonatomic, copy)NSArray *array_titles;
@property (nonatomic, strong)NSMutableArray <LQStandardSonModel *>*array_selectedModel;
@property (nonatomic, strong)UIView *proMsgView;
@property (nonatomic, strong)UIView *bottomView;

@end

@implementation LQSkuView


-(instancetype)initWithFrame:(CGRect)frame withDataSource:(NSMutableArray *)array_dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        _array_dataSource = array_dataSource;
        [self configurationUI];
    }
    return self;
}
-(NSMutableArray *)array_dataSource{
    if (!_array_dataSource) {
        _array_dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _array_dataSource;
}
-(NSMutableArray *)array_selectedModel{
    if (!_array_selectedModel) {
        _array_selectedModel = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _array_selectedModel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.minimumLineSpacing = 10*WidthRatio;
        layout.minimumInteritemSpacing = 10*WidthRatio;
        layout.sectionInset = UIEdgeInsetsMake(0, 15*WidthRatio, 10*WidthRatio, 15*WidthRatio);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.proMsgView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 200*WidthRatio) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LQStandardCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[LQStandardCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}
-(void)configurationUI{
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    
    UIView *proMsgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100*WidthRatio)];
    proMsgView.backgroundColor = [UIColor whiteColor];
    proMsgView.hidden = YES;
    [self addSubview:proMsgView];
    self.proMsgView = proMsgView;
    
    UIImageView *proImg = [[UIImageView alloc]initWithFrame:CGRectMake(15*WidthRatio, 15*WidthRatio, 75*WidthRatio, 75*WidthRatio)];
    proImg.image = [UIImage imageNamed:@"head.jpg"];
    proImg.backgroundColor = [UIColor redColor];
    [proMsgView addSubview:proImg];
    self.proMsgView = proMsgView;
    
    UILabel *lab_price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(proImg.frame)+10*WidthRatio, 15*WidthRatio, SCREEN_WIDTH - CGRectGetMaxX(proImg.frame) - 25*WidthRatio, 15*WidthRatio)];
    lab_price.font = FontThin(15.0f*WidthRatio);
    lab_price.text = @"价格：￥19999";
    [proMsgView addSubview:lab_price];
    self.lab_price = lab_price;
    
    UILabel *lab_stock = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(proImg.frame)+10*WidthRatio, CGRectGetMaxY(lab_price.frame)+10*WidthRatio, SCREEN_WIDTH - CGRectGetMaxX(proImg.frame) - 25*WidthRatio, 15*WidthRatio)];
    lab_stock.font = FontThin(12.0f*WidthRatio);
    lab_stock.text = @"库存：剩余99999件";
    [proMsgView addSubview:lab_stock];
    self.lab_stock = lab_stock;
    
    UILabel *lab_standard = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(proImg.frame)+10*WidthRatio, CGRectGetMaxY(lab_stock.frame)+10*WidthRatio, SCREEN_WIDTH - CGRectGetMaxX(proImg.frame) - 25*WidthRatio, 15*WidthRatio)];
    lab_standard.font = FontThin(12.0f*WidthRatio);
    [proMsgView addSubview:lab_standard];
    self.lab_standard = lab_standard;
    
    [self initData];

    [self addSubview:self.collectionView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 100*WidthRatio - safeSeraH, SCREEN_WIDTH, 100*WidthRatio + safeSeraH)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.hidden = YES;
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    
    UIView *proNumView = [[UIView alloc]initWithFrame:CGRectMake(15*WidthRatio, 10*WidthRatio, SCREEN_WIDTH - 30*WidthRatio, 40*WidthRatio)];
    proNumView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    proNumView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:proNumView];
    
    UILabel *lbl_numText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 69*WidthRatio, 40*WidthRatio)];
    lbl_numText.textColor = ColorWithRGB(16, 16, 16);
    lbl_numText.font = FontThin(13.0f*WidthRatio);
    lbl_numText.text = @"num";
    [proNumView addSubview:lbl_numText];
    
    UIButton *btn_reduce = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_reduce.frame = CGRectMake(proNumView.width - 99*WidthRatio, 5*WidthRatio, 30*WidthRatio, 30*WidthRatio);
    btn_reduce.layer.borderWidth = 1*WidthRatio;
    btn_reduce.layer.borderColor = ColorWithRGB(230, 230, 230).CGColor;
    [btn_reduce roundSide:LQSideLeft withRadius:3*WidthRatio];
    [btn_reduce setTitle:@"-" forState:UIControlStateNormal];
    btn_reduce.tag = 66;
    [btn_reduce addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_reduce setTitleColor:ColorWithRGB(230, 230, 230) forState:UIControlStateNormal];
    [proNumView addSubview:btn_reduce];
    
    UITextField *tf_num = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_reduce.frame), 5*WidthRatio, 40*WidthRatio, 30*WidthRatio)];
    tf_num.userInteractionEnabled = NO;
    tf_num.borderStyle = UITextBorderStyleNone;
    tf_num.text = @"1";
    [tf_num setViewBorderWithcolor:ColorWithRGB(230, 230, 230) border:1*WidthRatio type:UIViewBorderLineTypeTop];
    [tf_num setViewBorderWithcolor:ColorWithRGB(230, 230, 230) border:1*WidthRatio type:UIViewBorderLineTypeBottom];
    tf_num.textAlignment = NSTextAlignmentCenter;
    [proNumView addSubview:tf_num];
    self.tf_proNum = tf_num;
    
    
    UIButton *btn_add = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_add.frame = CGRectMake(CGRectGetMaxX(tf_num.frame), 5*WidthRatio, 30*WidthRatio, 30*WidthRatio);
    btn_add.layer.borderWidth = 1*WidthRatio;
    btn_add.layer.borderColor = ColorWithRGB(230, 230, 230).CGColor;
    [btn_add roundSide:LQBSideRight withRadius:3*WidthRatio];
    [btn_add setTitle:@"+" forState:UIControlStateNormal];
    btn_add.tag = 99;
    [btn_add addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_add setTitleColor:ColorWithRGB(230, 230, 230) forState:UIControlStateNormal];
    [proNumView addSubview:btn_add];

    
    UIButton *btn_sure = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sure.frame = CGRectMake(15*WidthRatio, CGRectGetMaxY(proNumView.frame)+5*WidthRatio, SCREEN_WIDTH-30*WidthRatio, 40*WidthRatio);
    btn_sure.layer.masksToBounds = YES;
    btn_sure.layer.cornerRadius = 5*WidthRatio;
    btn_sure.backgroundColor = [UIColor redColor];
    [btn_sure setTitle:@"确定" forState:UIControlStateNormal];
    [btn_sure addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn_sure];
    
    [self  performSelector:@selector(delayMethod) withObject:nil afterDelay:0.2f];
    self.collectionView.hidden = YES;
    
    
}
-(void)delayMethod{
    if (self.collectionView.contentSize.height > SCREEN_HEIGHT - 400*WidthRatio) {
        self.collectionView.y =  300*WidthRatio;
        self.collectionView.height = SCREEN_HEIGHT - 400*WidthRatio - safeSeraH;
        self.proMsgView.y = 200*WidthRatio;
        self.bottomView.y = CGRectGetMaxY(self.collectionView.frame);
    }else{
        self.collectionView.y = SCREEN_HEIGHT - self.collectionView.contentSize.height - 100*WidthRatio - safeSeraH;
        self.proMsgView.y = SCREEN_HEIGHT -  self.collectionView.contentSize.height - 200*WidthRatio - safeSeraH;
        self.collectionView.height = SCREEN_HEIGHT - self.collectionView.contentSize.height - safeSeraH - 100*WidthRatio;
        self.bottomView.y = CGRectGetMaxY(self.collectionView.frame);
    }
    
    self.collectionView.hidden = NO;
    self.proMsgView.hidden = NO;
    self.bottomView.hidden = NO;
}
-(void)btnClick:(UIButton *)sender{
    if (self.btnClick) {
        self.btnClick();
    }
}
-(void)initData{
//    for (int i = 0; i<2; i++) {
//        LQStandardModel *model_title = [[LQStandardModel alloc]init];
//        model_title.proStandardTitle = [NSString stringWithFormat:@"第%d个父级标题",i+1];
//        model_title.proStandardTitleId = [NSString stringWithFormat:@"%d",i+1];
//        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
//        for (int j = 0; j<5; j++) {
//            LQStandardSonModel *model_name = [[LQStandardSonModel alloc]init];
//            model_name.proStandardName = [NSString stringWithFormat:@"第%d个子级标题",j+1];
//            model_name.proStandardNameId = [NSString stringWithFormat:@"%d",j+1];
//            if (j==0) {
//                model_name.isSelected = YES;
//            }
//            if (model_name.isSelected) {
//                [self.array_selectedModel addObject:model_name];
//            }
//            model_name.proIdx = i;//model的下标
//            [array addObject:model_name];
//        }
//        model_title.proArrs = array;
//        [self.array_dataSource addObject:model_title];
//    }
    for (LQStandardModel *model in self.array_dataSource) {
        for (int i = 0; i<model.proArrs.count; i++) {
            LQStandardSonModel *model_son = model.proArrs[i];
            if (i == 0) {
                [self.array_selectedModel addObject:model_son];
            }
            model_son.proIdx = model.proIdx;
        }
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.array_dataSource.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    LQStandardModel*model = self.array_dataSource[section];
    return model.proArrs.count;
}
-(__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LQStandardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    LQStandardModel *model = self.array_dataSource[indexPath.section];
    LQStandardSonModel *model_son = model.proArrs[indexPath.item];
    cell.model = model_son;
    cell.lab_standard.text = model_son.proStandardName;
    cell.lab_standard.backgroundColor = model_son.isSelected ? [UIColor redColor] : [UIColor lightGrayColor];
    cell.lab_standard.textColor = model_son.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LQStandardModel *model = self.array_dataSource[indexPath.section];
    LQStandardSonModel *model_son = model.proArrs[indexPath.item];
    return CGSizeMake(model_son.itemWidth, 30*WidthRatio);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        LQStandardCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        LQStandardModel *model = self.array_dataSource[indexPath.section];
        headView.lab_standard.text = model.proStandardTitle;
        return headView;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i<self.array_dataSource.count; i++) {
        if (indexPath.section == i) {
            LQStandardModel *model = self.array_dataSource[i];
            [model.proArrs enumerateObjectsUsingBlock:^(LQStandardSonModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == indexPath.item) {
                    obj.isSelected = !obj.isSelected;
                    if (obj.isSelected) {
                        [self.array_selectedModel addObject:obj];
                    }else{
                        [self.array_selectedModel removeObject:obj];
                    }
                }else{
                    obj.isSelected = NO;
                    [self.array_selectedModel removeObject:obj];
                }
            }];
        }
    }
    
    [UIView performWithoutAnimation:^{
        //刷新界面
        [self.collectionView reloadData];
    }];
    
    //处理选中数组中的model数据
    [self getProStndardMsg];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 34*WidthRatio);
}

-(void)getProStndardMsg{
    if (self.array_selectedModel.count == self.array_dataSource.count) {
        NSUInteger count = self.array_selectedModel.count;
        for (int i=0; i<count-1; i++) {
            for (int j=0; j<count-1-i; j++) {
                if (self.array_selectedModel[j].proIdx > self.array_selectedModel[j+1].proIdx) {
                    [self.array_selectedModel exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
        NSArray *arr_proStandardName = [self.array_selectedModel valueForKeyPath:@"proStandardName"];
        NSArray *arr_proStandardTitleId = [self.array_dataSource valueForKeyPath:@"proStandardTitleId"];
        NSArray *arr_ids = [self.array_selectedModel valueForKeyPath:@"proStandardNameId"];
        NSMutableArray *array_ids = [[NSMutableArray alloc]initWithCapacity:0];
        for (int i = 0; i<arr_proStandardTitleId.count; i++) {
            NSString *modelId = arr_proStandardTitleId[i];
            NSString *modelSonId = arr_ids[i];
            NSString *ids = [NSString stringWithFormat:@"%@:%@",modelId,modelSonId];
            [array_ids addObject:ids];
        }
        if (self.proStandard) {
            self.proStandard([arr_proStandardName componentsJoinedByString:@":"], [array_ids componentsJoinedByString:@";"],YES);
        }
    }else{
        self.proStandard(@"", @"",NO);
    }
    
}

@end

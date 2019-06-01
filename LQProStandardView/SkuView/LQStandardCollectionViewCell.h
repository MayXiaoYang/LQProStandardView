//
//  LQStandardCollectionViewCell.h
//  LQCustomClass
//
//  Created by liang lee on 2019/5/20.
//  Copyright © 2019 li xiao yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQStandardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LQStandardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *lab_standard;

@property (nonatomic, strong)LQStandardSonModel *model;

@end

NS_ASSUME_NONNULL_END

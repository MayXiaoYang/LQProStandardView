# LQProStandardView
一个关于商品规格选择的View<br>
#### swift版本请点击这里[LQProStandardView-Swift版](https://github.com/MayXiaoYang/LQProStandardView-Swift.git)
用法很简单，只要让后台返回项目中给你的json格式或者自己修改成项目中的json格式，解析josn封装成数组直接传入初始化方法即可;<br>
demo效果图<br>
![demo效果图](https://upload-images.jianshu.io/upload_images/3320726-f33fdc6399fb0711.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/305/format/webp)<br>
使用示例<br>
```
-(LQSkuView *)skuView{
    if (!_skuView) {
        _skuView = [[LQSkuView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) withDataSource:self.array_dataSource];
        WeakSelf(self);
        _skuView.btnClick = ^{
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.skuView.y = SCREEN_HEIGHT;
            }];
        };
        _skuView.proStandard = ^(NSString *proStandardStr, NSString *proStandardIdStr,BOOL isReady) {
            if (isReady) {
                NSLog(@"proStandardStr------>>>%@ \n proStandardIdStr------->>>%@",proStandardStr,proStandardIdStr);
                weakSelf.skuView.lab_standard.text = proStandardStr;
                weakSelf.lab_standard.text = proStandardStr;
            }else{
                weakSelf.skuView.lab_standard.text = @"请选择规格";
            }
        };
        [_skuView getProStndardMsg];
        [_skuView addToWindow];
    }
    return _skuView;
}
```


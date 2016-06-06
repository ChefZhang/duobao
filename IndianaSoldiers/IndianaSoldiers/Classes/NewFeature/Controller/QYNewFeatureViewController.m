//
//  QYNewFeatureViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYNewFeatureViewController.h"
#import "QYCollectionViewCell.h"


@interface QYNewFeatureViewController ()

@end

@implementation QYNewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 修改item的大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 修改行间距
    flowLayout.minimumLineSpacing = 0;
    
    // 修改每一个item的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    // 修改滚动方向水平
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 修改每一组的边距
    //    flowLayout.sectionInset = UIEdgeInsetsMake(100, 20, 30, 40);
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.collectionView.backgroundColor = [UIColor redColor];
    
    // 注册cell
    [self.collectionView registerClass:[QYCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 设置分页
    self.collectionView.pagingEnabled = YES;
    // 禁止弹簧效果
    self.collectionView.bounces = NO;
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}


#pragma mark - collectionView 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#define QYPage 3

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return QYPage;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    QYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //引导界面屏幕适配
    UIImage *image;
        if (iphone6P) {

         image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页0%d-1080x1920",indexPath.item + 1]];
        }
        else if (iphone6) {
          image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页0%d-750x1334",indexPath.item + 1]];
        }
        else if (iphone5) {
           image =[UIImage imageNamed:[NSString stringWithFormat:@"引导页0%d-640x1136",indexPath.item + 1]];
        }
        else if (iphone4) {
            image =[UIImage imageNamed:[NSString stringWithFormat:@"引导页0%d-640x960",indexPath.item + 1]];
        }

    // 拼接图片名字

    cell.image = image;

    [cell setIndexPath:indexPath count:QYPage];
    
    return cell;
}



@end

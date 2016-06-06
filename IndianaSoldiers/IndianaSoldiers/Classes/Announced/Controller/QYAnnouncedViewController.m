//
//  QYAnnouncedViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYAnnouncedViewController.h"
#import "UIBarButtonItem+Item.h"
#import "QYLoginViewController.h"
#import "QYUserViewController.h"
#import <MJRefresh.h>
#import "QYAnnouncedCollectionViewCell.h"
#import "QYAnnouncedModel.h"
#import "ZBGoodsDetailController.h"
#import "QYTabBarController.h"
#import "QYNavigationController.h"

#define squareWH (QYScreenW - (cols - 1) * margin) / cols
static NSInteger const cols = 2;
static NSInteger const margin = 1;
static NSString *const ID = @"announcedCell";

@interface QYAnnouncedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;

//模型数组
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (assign, nonatomic) CGFloat lastOffsetY;




@end

@implementation QYAnnouncedViewController



- (NSMutableArray *)arrayM{
    if (_arrayM == nil) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupNavigationItem];

    [self setupRefresh];
    [self setFootView];
    
    _lastOffsetY = 0;

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setFootView{
    
    UICollectionViewFlowLayout *flowyer = [[UICollectionViewFlowLayout alloc]init];
    flowyer.minimumInteritemSpacing = 1;
    flowyer.minimumLineSpacing =1;
    //    flowyer.itemSize = CGSizeMake(squareWH, 100);
    
    
    //创建uicollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) collectionViewLayout:flowyer];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    self.collection = collectionView;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYAnnouncedCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
//    [self.tableView reloadData];
}


//下拉刷新
- (void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    /** 自动切换透明度 */
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData{
    
    [SVProgressHUD showWithStatus:@"请稍后"];
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"goodsProcessing/getGoodsProcessingMore.do?"];
     NSDictionary *paramDict = @{
                                 @"page" : @"1",
                                 @"rows" : @"10"
                                 };
    
    [manager GET:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *array = [dict[@"data"]objectForKey:@"info"];
        NSLog(@"%@",array);
        self.arrayM = [QYAnnouncedModel mj_objectArrayWithKeyValuesArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collection reloadData];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络有问题！"];
    }];
    
    // 结束刷新
    [self.tableView.mj_header endRefreshing];
    
}

- (void)loadMoreData{
    
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
}


- (void)setupNavigationItem{
    
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"info"] highImage:[UIImage imageNamed:@"info"] target:self action:@selector(leftClick)];
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"最新揭晓";
    
}

- (void)leftClick {
    //解档
    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    //    unarchiveObjectWithFile会调用initWithCoder
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!account.userName) {
        QYLoginViewController *loginVC = [[QYLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        
        QYUserViewController *userVC = [[QYUserViewController alloc]init];
        [self.navigationController pushViewController:userVC animated:YES];
    }
    
}



//尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
        
        return self.collection;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.arrayM.count * 110;
}

#pragma mark -UICollectionViewDataSource
//设置高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

        return CGSizeMake(squareWH, 280);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",self.arrayM.count);
    return self.arrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        QYAnnouncedCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.item = self.arrayM[indexPath.row];
        return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBGoodsDetailController *detailVC = [[ZBGoodsDetailController alloc]init];
    
    detailVC.model = self.arrayM[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end

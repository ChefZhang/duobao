//
//  QYPurchaseViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYPurchaseViewController.h"
#import "UIBarButtonItem+Item.h"
#import "QYLoginViewController.h"
#import "QYNavigationController.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "headView.h"
#import "QYPurchaseTopCellModel.h"
#import "QYTopCollectionViewCell.h"
#import "QYPurchserBottomCellModel.h"
#import "QYBottomCollectionViewCell.h"
#import "QYPurchaseTitieCell.h"
#import "QYUserViewController.h"
#import "ZBGoodsDetailController.h"

#define squareWH (QYScreenW - (cols - 1) * margin) / cols
static NSInteger const cols = 2;
static NSInteger const margin = 3;
static NSString *const ID = @"squareTopCell";
static NSString *const ID1 = @"squareBottomCell";
static NSString *const ID2 = @"titleCell";
static NSString *const cellId = @"cellId";


@interface QYPurchaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *showImage;


@property (nonatomic, strong) UICollectionView *collection;

//即将开奖模型数组
@property (nonatomic, strong) NSMutableArray *openModels;

//热门数据
@property (nonatomic, strong) NSMutableArray *hotModels;

@end

@implementation QYPurchaseViewController

- (NSMutableArray *)openModels{
    if (_openModels == nil) {
        _openModels = [NSMutableArray array];
    }
    return  _openModels;
}

- (NSMutableArray *)hotModels{
    if (_hotModels == nil) {
        _hotModels = [NSMutableArray array];
    }
    return _hotModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setFootView];

    [self setupRefresh];
    
    // 处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 40;
        self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-34, 0, 0, 0);
    
    
//    self.tabBarItem.badgeValue = @2;
//                [UIApplication sharedApplication].applicationIconBadgeNumber = @2;

//    //设置提醒图标
//    //1.获取UIApplication对象
//    UIApplication *app = [UIApplication sharedApplication];
//    //2.注册用户通知
//    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:
//                                          UIUserNotificationTypeBadge categories:nil];
//    [app registerUserNotificationSettings:notice];
//    //3.设置提醒值.
//    app.applicationIconBadgeNumber = 10;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];

    //设置提醒图标
    //1.获取UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
    //2.注册用户通知
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:
                                          UIUserNotificationTypeBadge |UIUserNotificationTypeSound|UIUserNotificationTypeAlert  categories:nil];
    [app registerUserNotificationSettings:notice];
    //3.设置提醒值.
    app.applicationIconBadgeNumber = 10;
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
  
 

    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupNavigationItem{
    
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"info"] highImage:[UIImage imageNamed:@"info"] target:self action:@selector(leftClick)];
    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"letter"] highImage:[UIImage imageNamed:@"letter"] target:self action:@selector(rightClick)];
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:25],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.title = @"夺宝兵团";
    
}

//collectionView设置底部视图
- (void)setFootView{
    
    UICollectionViewFlowLayout *flowyer = [[UICollectionViewFlowLayout alloc]init];
    flowyer.minimumInteritemSpacing = 1;
    flowyer.minimumLineSpacing =1;
  
    flowyer.itemSize = CGSizeMake(20 , 20);
    
    
    //创建uicollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 180, 180) collectionViewLayout:flowyer];
    
    
 
    
    collectionView.backgroundColor = self.tableView.backgroundColor;
//    self.tableView.tableFooterView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    self.collection = collectionView;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYTopCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYBottomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID1];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYPurchaseTitieCell class]) bundle:nil] forCellWithReuseIdentifier:ID2];
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
//    //获取轮播图
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://112.74.80.51/indiana/banner/getBannerList.do"];
        NSURLSession *session = [NSURLSession sharedSession];
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *array = dict[@"data"];
            NSString *path = [[[array objectForKey:@"info"] firstObject]objectForKey:@"logoPath"];
            NSString *pathUrl = [QYURLShort stringByAppendingString:path];
            [self.showImage sd_setImageWithURL:[NSURL URLWithString:pathUrl]];
 
        
            [SVProgressHUD dismiss];
        }];
        
        [dataTask resume];
        
        });
    

    
//        ///请求即将揭晓4条数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
            NSURL *url1 = [NSURL URLWithString:@"http://112.74.80.51/indiana/goodsProcessing/getGoodsProcessingList.do"];
            NSURLSession *session1 = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                //解析数据
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *array = [dict[@"data"] objectForKey:@"info"];

              self.openModels = [QYPurchaseTopCellModel mj_objectArrayWithKeyValuesArray:array];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{

                    //刷新表格
                    [self.collection reloadData];
                    
                    // 结束刷新
//                    [self.tableView.mj_header endRefreshing];
                });
                
            }];

            [dataTask1 resume];
    });
    
   
    
    //今日热门
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        NSURL *url2 = [NSURL URLWithString:@"http://112.74.80.51/indiana/goodsProcessing/getHotList.do?page=1&rows=18"];
        NSURLSession *session2 = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = [dict[@"data"]objectForKey:@"info"];
            
            self.hotModels = [QYPurchserBottomCellModel mj_objectArrayWithKeyValuesArray:array];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                //刷新表格
                [self.collection reloadData];
                [self.tableView reloadData];
                // 结束刷新
                [self.tableView.mj_header endRefreshing];
            });
            
        }];
        [dataTask2 resume];
    
    });

    
    
}



- (void)loadMoreData{
    
    
    
    //今日热门
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url2 = [NSURL URLWithString:@"http://112.74.80.51/indiana/goodsProcessing/getHotList.do?page=1&rows=40"];
        NSURLSession *session2 = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = [dict[@"data"]objectForKey:@"info"];
            
             NSArray *moreTopics = [QYPurchserBottomCellModel mj_objectArrayWithKeyValuesArray:array];
            
             [self.hotModels addObjectsFromArray:moreTopics];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //刷新表格
                [self.collection reloadData];
                [self.tableView reloadData];
                // 结束刷新
                [self.tableView.mj_header endRefreshing];
            });
            
        }];
        [dataTask2 resume];
        
    });

    
    
    // 刷新表格
    [self.collection reloadData];
    
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
    
}


- (void)leftClick {

        //解档
        NSString *tempPath =  NSTemporaryDirectory();
        NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
        //    unarchiveObjectWithFile会调用initWithCoder
        UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    
    if (!account.pwd) {
        QYLoginViewController *loginVC = [[QYLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        
        QYUserViewController *userVC = [[QYUserViewController alloc]init];
        [self.navigationController pushViewController:userVC animated:YES];
    }
    
}

- (void)rightClick {
    
}

//头部视图
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    headView *view = [[[NSBundle mainBundle]loadNibNamed:@"headView" owner:nil options:nil]lastObject];
    
    switch (section) {
        case 1:
            
            [view.leftBtn setTitle:@"近期开奖" forState:UIControlStateNormal];
            [view.leftBtn setImage:[UIImage imageOriginalWithName:@"sectionIcon01"] forState:UIControlStateNormal];
            [view.rightBtn setTitle:@"更多" forState:UIControlStateNormal];
            [view.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        case 2:
            [view.leftBtn setTitle:@"今日热门" forState:UIControlStateNormal];
            [view.leftBtn setImage:[UIImage imageOriginalWithName:@"sectionIcon02"] forState:UIControlStateNormal];
            [view.rightBtn setTitle:@"更多" forState:UIControlStateNormal];
            [view.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        default:
            break;
    }

    return view;
}

//尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 1) {
    
        return self.collection;
         return nil;
    }else{
        return nil;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return   80 * self.openModels.count/2  + 160 * self.hotModels.count/2   ;
    }
    else{
        return 0;
    }
}






#pragma mark -UICollectionViewDataSource
//设置高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return  CGSizeMake(squareWH, 80);
    }else if(indexPath.section == 1){
        return CGSizeMake(QYScreenW, 44);
    }else{
        return CGSizeMake(squareWH, 160);
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        return CGSizeMake(QYScreenW, 10);
    }else{
        return CGSizeMake(QYScreenW, 1);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        
        return self.openModels.count;
        
    }else if(section == 1){
        
        return 1;
        
    }else if(section == 2){
        
        return self.hotModels.count;
        
    }
    else{
        return 0;
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        QYTopCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.item = self.openModels[indexPath.row];
        return cell;

    }else if (indexPath.section == 1){
        
        QYPurchaseTitieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID2 forIndexPath:indexPath];
        return cell;
    }
    else {
//
        QYBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID1 forIndexPath:indexPath];
        cell.item = self.hotModels[indexPath.row];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        ZBGoodsDetailController *detailVC =  [[ZBGoodsDetailController alloc]init];
        
        detailVC.model = self.openModels[indexPath.row];
        
            [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        
        ZBGoodsDetailController *detailVC =  [[ZBGoodsDetailController alloc]init];
        
        detailVC.model = self.hotModels[indexPath.row];
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    

    
    

    
    
}

@end

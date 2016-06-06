//
//  QYShopingViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYShopingViewController.h"
#import "UIBarButtonItem+Item.h"
#import "QYLoginView.h"
#import "QYOtherLogin.h"
#import "QYUserViewController.h"
#import "QYLoginViewController.h"
#import "ShopCarCell.h"
#import <MJRefreshHeader.h>
#import "ZBShopCarGoods.h"
#import "QYProductViewController.h"
#import "ShopCarCell.h"
@interface QYShopingViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) AFHTTPSessionManager *manager;
//热门数据
@property (nonatomic, strong) NSMutableArray *hotModels;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *emptyView;

@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalValueL;



@end
 NSString * const ID = @"ShopCell";
@implementation QYShopingViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)hotModels{
    if (_hotModels == nil) {
        _hotModels = [NSMutableArray array];
    }
    return _hotModels;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
    
   
    [self setupNavigationItem];
 
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCarCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self setupRefresh];
     [self.tableView.mj_header beginRefreshing];
    
    self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableView.allowsSelection = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delete:) name:@"delete" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add:) name:@"add" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minus:) name:@"minus" object:nil];
    
    
}


- (void)add:(NSNotification *)note
{
    ShopCarCell *cell = note.object;
    int totalValue = self.totalValueL.text.intValue + cell.item.minTimes;
    self.totalValueL.text = [NSString stringWithFormat:@"%d",totalValue];
}

- (void)minus:(NSNotification *)note
{
    ShopCarCell *cell = note.object;
    int totalValue = self.totalValueL.text.intValue - cell.item.minTimes;
    self.totalValueL.text = [NSString stringWithFormat:@"%d",totalValue];
}

- (void)delete:(NSNotification *)note
{
    
    //第一步:创建控制器
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要删除嘛?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //第二步:创建按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        // 发布者
        ShopCarCell *cell = note.object;
        
        //1.创建会话管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *address = [QYURLLong stringByAppendingPathComponent:@"car/deleteCar.do"];
        
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        [paramDict setObject:[NSString stringWithFormat:@"%ld",cell.item.id] forKey:@"id"];
        
        
        
        
        [manager POST:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"请求成功--");
//            [[NSNotificationCenter defaultCenter ]postNotificationName:@"delete" object:self];
            
            [self.tableView reloadData];
            [self.tableView.mj_header beginRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showWithStatus:@"网络貌似不稳定哟~"];
        }];
    }];
    
    //第三步:添加按钮
    [alertVC addAction:action];
    [alertVC addAction:action1];
    
    //第四步:显示弹框.(相当于show操作)'
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
    

   
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






- (void)payNow
{
    
}


-(void)setupRefresh
{
    // header
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadInfo)];
    
    // 自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

-(void)loadInfo
{
    
    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    //    unarchiveObjectWithFile会调用initWithCoder
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    ///请求即将揭晓4条数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *str = [NSString stringWithFormat:@"http://112.74.80.51/indiana/car/getCarList.do?userId=%@&page=1&rows=20",account.id];
        
        
        NSURL *url1 = [NSURL URLWithString:str];
        NSURLSession *session1 = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           
          
            
            NSArray *subArray = [dict[@"data"] objectForKey:@"info"];
//            NSLog(@"%@",subArray);
            
            
            
           
            self.hotModels = [ZBShopCarGoods mj_objectArrayWithKeyValuesArray:subArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                //刷新表格
       
                [self.tableView reloadData];
                // 结束刷新
                [self.tableView.mj_header endRefreshing];
                
                self.totalValueL.text = [NSString stringWithFormat:@"%d",self.hotModels.count];
            });
            
        }];
        [dataTask1 resume];
        
    });
    
}

- (void)setupNavigationItem{
    
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"info"] highImage:[UIImage imageNamed:@"info"] target:self action:@selector(leftClick)];
    
    //右边的按钮
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@""] highImage:[UIImage imageNamed:@""] target:self action:@selector(rightClick)];
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"购物车";
    
}

- (void)leftClick {
    //解档
  
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"user.data"];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.hotModels.count > 0) {
        self.emptyView.hidden = true;
    }else{
        self.emptyView.hidden = false;
    }
    
    
    self.totalCount.text = [NSString stringWithFormat:@"%d",self.hotModels.count];
    
    return  self.hotModels.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.hotModels[indexPath.row];

//    NSLog(@"%@",self.hotModels[indexPath.row].goodsName);
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  180;
}

- (IBAction)jumpToBuy {
 
    
        
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
 
    
    
}

@end

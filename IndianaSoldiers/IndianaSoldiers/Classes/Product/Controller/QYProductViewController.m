//
//  QYProductViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYProductViewController.h"
#import "UIBarButtonItem+Item.h"
#import "QYLoginViewController.h"
#import "QYUserViewController.h"
#import "QYShopLeftTableViewCell.h"
#import "QYSHOPLeftModel.h"
#import "QYSHOPRightModel.h"
#import "QYShopRightTableViewCell.h"
#import "ZBGoodsDetailController.h"
#import <UIImageView+WebCache.h>
@interface QYProductViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
//左边的视图模型
@property (nonatomic, strong) NSMutableArray *leftArrayM;
@property (nonatomic, strong) NSMutableArray *rightArray;
@end

@implementation QYProductViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - 懒加载数据
- (NSMutableArray *)leftArrayM{
    if (_leftArrayM == nil) {
        _leftArrayM = [NSMutableArray array];
    }
    return _leftArrayM;
}

//初始化左边的模型数据
- (void)loadLeftModel{
    
    [self leftMethorWithValue:@"全部"];
    [self leftMethorWithValue:@"手机平板"];
    [self leftMethorWithValue:@"十元专区"];
    [self leftMethorWithValue:@"电脑办公"];
    [self leftMethorWithValue:@"数码影音"];
    [self leftMethorWithValue:@"家用电器"];
    [self leftMethorWithValue:@"游戏玩具"];
    [self leftMethorWithValue:@"户外装备"];
    [self leftMethorWithValue:@"美食天地"];
    [self leftMethorWithValue:@"虚拟产品"];
    [self leftMethorWithValue:@"其他"];
    
}
- (void)leftMethorWithValue:(NSString *)value{
    QYSHOPLeftModel *leftModel = [[QYSHOPLeftModel alloc]init];
    leftModel.name = value;
    [self.leftArrayM addObject:leftModel];
}

- (NSMutableArray *)rightArray{
    if (_rightArray == nil) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadLeftModel];
    //注册cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYShopLeftTableViewCell class]) bundle:nil] forCellReuseIdentifier:leftCell];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYShopRightTableViewCell class]) bundle:nil] forCellReuseIdentifier:rightCell];
    
    [self setupNavigationItem];
//    [self loadLeftShop];
    [self loadRightShopWithPage:1 rows:20 goodsName:@"全部"];

    //左边的tableView默认选中第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buyClick:) name:@"buy" object:nil ];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)buyClick:(NSNotification *)note
{

    
    QYSHOPRightModel *model = note.userInfo[@"dict"];
//    NSLog(@"%@",model.goodsName);

    
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"/car/saveCar.do"];

    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    //    unarchiveObjectWithFile会调用initWithCoder
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = account.id;
    parameters[@"processingId"]  = @1 ;
    parameters[@"goodsId"]  = [NSString stringWithFormat:@"%ld",model.goodsId];
    parameters[@"minTimes"] = @1;
    parameters[@"amount"] = @1;
    parameters[@"times"] =  [NSString stringWithFormat:@"%ld",model.times]; 
//
    
    
    [manager GET:address parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        
        NSLog(@"%@",dict);
        NSArray *array = [dict[@"data"]objectForKey:@"info"];
        self.rightArray = [QYSHOPRightModel mj_objectArrayWithKeyValuesArray:array];
//        [self.rightTableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"购买成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
}




- (void)setupNavigationItem{
    
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"info"] highImage:[UIImage imageNamed:@"info"] target:self action:@selector(leftClick)];
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"全部商品";
    
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

//- (void)loadLeftShop{
//    
//dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    
//    NSURL *url2 = [NSURL URLWithString:@"http://112.74.80.51/indiana/goodsType/getGoodsTypeList.do?"];
//    NSURLSession *session2 = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        //解析数据
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dict);
//        
//    }];
//    [dataTask2 resume];
//    
//});
//    
//}


- (void)loadRightShopWithPage:(NSInteger)page rows:(NSInteger)rows goodsName:(NSString *)goodsName{
    [self.rightArray removeAllObjects];
    
    
    
    [SVProgressHUD showWithStatus:@"请稍后"];
    
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"goodsProcessing/getGoodsTypeList.do?"];
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    if ([goodsName isEqualToString:@"全部"]) {
        [paramDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
        [paramDict setObject:[NSString stringWithFormat:@"%ld",rows] forKey:@"rows"];
    }else{
        [paramDict setObject:goodsName forKey:@"goodsTypeName"];
        
    }
    
    [manager POST:address parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        
        NSLog(@"%@",dict);
        NSArray *array = [dict[@"data"]objectForKey:@"info"];
        self.rightArray = [QYSHOPRightModel mj_objectArrayWithKeyValuesArray:array];
        [self.rightTableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];

}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTableView) {
        return 120;
    }else{
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftArrayM.count;
    }
    return self.rightArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//     左边表格
    if (tableView == self.leftTableView) {

        QYShopLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
        QYSHOPLeftModel *leftModel = self.leftArrayM[indexPath.row];
        cell.titleName.text = leftModel.name;
        //修改cell背景颜色
        UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
        backgroundViews.backgroundColor = [UIColor whiteColor];
        [cell setSelectedBackgroundView:backgroundViews];
        return cell;
    }else{
        
        QYShopRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell];
        cell.model = self.rightArray[indexPath.row];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        switch (indexPath.row) {
            case 0:
                [self loadRightShopWithPage:1 rows:20 goodsName:@"全部"];
                break;
                case 1:
                [self loadRightShopWithPage:0 rows:2 goodsName:@"手机平板"];
                break;
            case 2:
                [self loadRightShopWithPage:0 rows:5 goodsName:@"十元专区"];
                break;
            case 3:
                [self loadRightShopWithPage:0 rows:0 goodsName:@"电脑办公"];
                break;
            case 4:
                [self loadRightShopWithPage:1 rows:5 goodsName:@"数码影音"];
                break;
            case 5:
                [self loadRightShopWithPage:1 rows:5 goodsName:@"家用电器"];
                break;
            case 6:
                [self loadRightShopWithPage:2 rows:5 goodsName:@"游戏玩具"];
                break;
            case 7:
                [self loadRightShopWithPage:3 rows:6 goodsName:@"户外装备"];
                break;
            case 8:
                [self loadRightShopWithPage:2 rows:5 goodsName:@"美食天地"];
                break;
            case 9:
                [self loadRightShopWithPage:1 rows:8 goodsName:@"虚拟产品"];
                break;
            case 10:
                [self loadRightShopWithPage:2 rows:7 goodsName:@"其他"];
                break;
            default:
                break;
        }
    }else{
        
       
        
        ZBGoodsDetailController *detail = [[ZBGoodsDetailController alloc]init];
        
        detail.model = self.rightArray[indexPath.row];

        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}
@end

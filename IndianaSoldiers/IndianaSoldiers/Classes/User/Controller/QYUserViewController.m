//
//  QYUserViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/11.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYUserViewController.h"
#import "UIBarButtonItem+Item.h"
#import "QYSettingViewController.h"
#import "QYFastButton.h"
#import "PersonDetailController.h"

#import "PersonDetailController.h"


@interface QYUserViewController ()

//头像
@property (weak, nonatomic) IBOutlet QYFastButton *touxiang;
//id
@property (weak, nonatomic) IBOutlet UILabel *id;
@property (weak, nonatomic) IBOutlet UIButton *duobaobiBtn;

@property (nonatomic, strong) UserAccount *account;

@property (weak, nonatomic) IBOutlet QYFastButton *header;


@end

@implementation QYUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    
    
    
    _header.layer.cornerRadius = 50;
    _header.layer.masksToBounds =YES;
    
    
 
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.account = [UserAccount shareUserAccount];
    
    //解档
    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    //    unarchiveObjectWithFile会调用initWithCoder
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    self.account = account;
    
    if (!account.pwd) {
        self.id.text = [NSString stringWithFormat:@"ID: %@",self.account.id];
    }else{
        self.id.text = account.id;
    }
    
//     self.id.text = [NSString stringWithFormat:@"ID: %@",self.account.id];
    
    NSLog(@"%@", self.account.id);
    [self.duobaobiBtn setTitle:[NSString stringWithFormat:@"%ld夺宝币",self.account.currency] forState:UIControlStateNormal];
    [self.touxiang setTitle:[NSString stringWithFormat:@"%@",self.account.userName] forState:UIControlStateNormal];

    
    
   
  
    
    
    [self getHeading];
    
}



-(void)getHeading
{
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //拼接图片的全路径
    NSString *fullPath = [caches stringByAppendingPathComponent:@"haha.png"];
    
    //检查磁盘缓存
    NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
    
    
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        [self.header setImage:image forState:UIControlStateNormal];
        
    }
}




- (void)setNavigation{
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"个人中心";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"seting"] highImage:[UIImage imageNamed:@"seting"] target:self action:@selector(rightClick)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

- (void)rightClick{
   
    UIStoryboard *setingSb = [UIStoryboard storyboardWithName:@"QYSettingViewController" bundle:nil];
    QYSettingViewController *setting = [setingSb instantiateInitialViewController];
    [self.navigationController pushViewController:setting animated:YES];
}

//我的积分
- (IBAction)integralBtn:(id)sender {
   

}
//收货地址
- (IBAction)addressBtn:(id)sender {

}
//账号管理
- (IBAction)accountBtn:(id)sender {
}
//夺宝记录
- (IBAction)duoBaoBtn:(id)sender {
}
//中奖记录
- (IBAction)goldBtn:(id)sender {
}
//我的晒单
- (IBAction)shaidanBtn:(id)sender {
}
//分享
- (IBAction)share:(id)sender {
}
//签到
- (IBAction)qianDao:(id)sender {
}
//充值
- (IBAction)congZhiBtn:(id)sender {
}
- (IBAction)headerCick {
    
//     PersonDetailController * personDetailVC = [[PersonDetailController alloc ]init];
    
    PersonDetailController *per = [[PersonDetailController alloc]init];
    per.account = self.account;
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"PersonDetailController" bundle:nil];
    
    UITableViewController *vc = [story instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}



@end

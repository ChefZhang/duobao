//
//  QYLoginViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYLoginViewController.h"
#import "QYRegisterViewController.h"
#import "QYForgetViewController.h"
#import "UMSocial.h"
#import "NSString+Hash.h"
#import "UserAccount.h"
#import "QYPurchaseViewController.h"
@interface QYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic, strong) UserAccount *user;

@end

@implementation QYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.navigationItem.title = @"登陆";

}


//注册会员
- (IBAction)register:(id)sender {
    QYRegisterViewController *registerVC = [[QYRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

//忘记密码
- (IBAction)forgetPassword:(id)sender {
    
    QYForgetViewController *forget = [[QYForgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}
- (IBAction)share:(id)sender {
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon04.png"]
                                shareToSnsNames:nil
                                       delegate:nil];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//微博第三方登陆
- (IBAction)weiboLogin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId,response.message);
            
        } else {
            NSLog(@"微博登陆失败");
        }});

}

//登陆按钮
- (IBAction)loginBtn:(id)sender {
        
        NSString *address = [QYURLLong stringByAppendingPathComponent:@"user/sign.do?"];
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:address]];
        request.HTTPMethod = @"POST";
    
        //MD5加密
        NSString *md5Pwd = [self.password.text md5String];
        NSString *body = [NSString stringWithFormat:@"userName=%@&pwd=%@",self.account.text , md5Pwd];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSession *session = [NSURLSession sharedSession];
    
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
            
            
             NSString *status = dict[@"msg"];
            if ([status isEqualToString:@"成功"]) {
                
            self.user = [UserAccount mj_objectWithKeyValues:[dict[@"data"]objectForKey:@"info"]];
                //获取沙盒目录
                NSString *tempPath =  NSTemporaryDirectory();
                NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
                NSLog(@"%@",tempPath);
                
                //归档 archiveRootObject会调用encodeWithCoder:
                [NSKeyedArchiver archiveRootObject:self.user toFile:filePath];
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD dismiss];
                });
                
                NSLog(@"----%@",self.user.userName);
                
            }else{
                [SVProgressHUD showErrorWithStatus:status];
            }
            if (error != nil) {
                [SVProgressHUD showErrorWithStatus:@"服务器异常!"];
            }
        }];
        
        //5.执行Task
        [dataTask resume];
    

}



- (IBAction)QQLoogin:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n  message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId,response.message);
            
        }else{
            NSLog(@"QQ登陆失败");
        }});

}

//微信登陆
- (IBAction)wechatLogin:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n  message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.message);
            
        }else{
            NSLog(@"微信登陆失败");
        }
        
    });
}

@end

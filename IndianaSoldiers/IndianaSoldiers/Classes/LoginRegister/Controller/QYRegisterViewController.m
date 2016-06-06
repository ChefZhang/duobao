//
//  QYRegisterViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYRegisterViewController.h"
#import "NSString+Hash.h"

@interface QYRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmaText;
@end

@implementation QYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题

    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取验证码
- (IBAction)getKey:(id)sender {
    //正则表达式匹配
    if ([QYTool checkTelNumber:self.phoneText.text] == NO) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误"];
    }else{
    NSString *yanzhengma = [NSString stringWithFormat:@"http://112.74.80.51/indiana/user/insertCodeAndGetCode.do?phone=%@&type=1",self.phoneText.text];
    NSURL *url = [NSURL URLWithString:yanzhengma];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //解析数据
        NSLog(@"-----------%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        

        
        NSString *msg = dict[@"msg"];
        
        if ([msg  isEqual: @"该手机号已经注册了，请直接登录"]) {
              [SVProgressHUD showErrorWithStatus:@"该手机号已经注册了，请直接登录"];
        }else{
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功,请查看短信!"];
            if (error != nil) {
                NSLog(@"%@",error);
            }
        }
        
       
    }];
        
    [dataTask resume];
    }
}




- (IBAction)registerBtn:(id)sender {
    
    //正则表达式匹配
    if ([QYTool checkTelNumber:self.phoneText.text] == NO) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }else{

    NSString *address = [QYURLLong stringByAppendingPathComponent:@"user/register.do?"];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:address]];
        
    request.HTTPMethod = @"POST";
    //MD5加密
    NSString *md5Pwd = [self.passwordText.text md5String];
    NSString *body = [NSString stringWithFormat:@"userName=%@&pwd=%@&code=%@",self.phoneText.text,md5Pwd,self.yanzhengmaText.text];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        NSString *msg = dict[@"msg"];
        
        if ([msg  isEqual: @"验证码失效或错误"]) {
            [SVProgressHUD showErrorWithStatus:@"验证码失效或错误"];
        }else{
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功,请查看短信!"];
            if (error != nil) {
                NSLog(@"%@",error);
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                  [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD dismiss];
            });
            
            
          
        }
        

    }];
    
    //5.执行Task
    [dataTask resume];
    }
}

@end

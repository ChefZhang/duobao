//
//  QYForgetViewController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYForgetViewController.h"
#import "NSString+Hash.h"

@interface QYForgetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordApeat;
@end

@implementation QYForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //标题
    self.navigationItem.title = @"重设密码";
}


//获取验证码
- (IBAction)getCode:(id)sender {
    //正则表达式匹配
    if ([QYTool checkTelNumber:self.phone.text] == NO) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误"];
    }else{
        NSString *yanzhengma = [NSString stringWithFormat:@"http://112.74.80.51/indiana/user/insertCodeAndGetCode.do?phone=%@&type=2",self.phone.text];
        NSURL *url = [NSURL URLWithString:yanzhengma];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //解析数据
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            [SVProgressHUD showSuccessWithStatus:@"发送成功,请查看短信!"];
            if (error != nil) {
                NSLog(@"%@",error);
            }
        }];
        [dataTask resume];
    }
}

//修改密码
- (IBAction)updateBtn:(id)sender {
    
    if (![self.password.text isEqualToString:self.passwordApeat.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不匹配!"];
    }else{
    
    NSString *address = [QYURLLong stringByAppendingPathComponent:@"user/resetPassword-validate.do?"];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:address]];
    request.HTTPMethod = @"POST";
    //MD5加密
    NSString *md5Pwd = [self.password.text md5String];
    NSString *body = [NSString stringWithFormat:@"userName=%@&type=2&newPwd=%@&code=%@",self.phone.text,md5Pwd,self.code.text];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        NSString *status = dict[@"msg"];
        if ([status isEqualToString:@"成功"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功!"];
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
}

@end

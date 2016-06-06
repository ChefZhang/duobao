//
//  PersonDetailController.m
//  IndianaSoldiers
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "PersonDetailController.h"
#import "PersonNicknameController.h"
#import "ProvinceTextF.h"

#import <Foundation/Foundation.h>

@interface PersonDetailController ()<PersonNicknameControllerDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *userId;


@property (weak, nonatomic) IBOutlet UILabel *penny;

@property (weak, nonatomic) IBOutlet ProvinceTextF *cityName;

@property (weak, nonatomic) IBOutlet UIButton *header;



@end

@implementation PersonDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _header.layer.cornerRadius = 31;
    _header.layer.masksToBounds =YES;
    
    //解档
    NSString *tempPath =  NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"user.data"];
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    self.userId.text = account.id;
    self.phone.text = account.userName;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 5;
    [self setNavigation];
    
    
    self.nickName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    self.cityName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
    
    
    self.cityName.delegate = self;
    
    [self getHeader];
    
 
}

-(void)getHeader
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
    self.navigationItem.title = @"个人信息";
   

}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( indexPath.section == 0 && indexPath.row == 1) {
        PersonNicknameController * nick = [[PersonNicknameController alloc]init];
        
        nick.delegate =self;
        [self.navigationController pushViewController:nick animated:YES];
    }
       [self.cityName resignFirstResponder];
}

- (void)nickNameViewController:(PersonNicknameController *)NicknamelVc sendValue:(NSString *)name
{
    self.nickName.text = name;
    
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    [defautls setObject:name forKey:@"name"];
   

    
    //同步,立即写入文件.
    [defautls synchronize];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   
    
    
    [self.cityName resignFirstResponder];
    
  
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    
    NSString *p = self.cityName.text;
    
    [defautls setObject:p forKey:@"cityName"];
    
    //同步,立即写入文件.
    [defautls synchronize];
}

- (IBAction)headeClick {
    
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    UIImagePickerController *imagePikerC = [[UIImagePickerController alloc]init];
    imagePikerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePikerC.delegate = self;
    
    [self presentViewController:imagePikerC animated:YES completion:nil];
    
   
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.header setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    

    
    
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"haha.png"];
    
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:filename atomically:YES];
}







@end
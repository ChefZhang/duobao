//
//  PersonNicknameController.m
//  IndianaSoldiers
//
//  Created by leo on 16/5/15.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "PersonNicknameController.h"
#import "UIBarButtonItem+Item.h"
@interface PersonNicknameController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation PersonNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigation];
}

- (void)setNavigation{
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"修改昵称";
    
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"selected"] highImage:[UIImage imageNamed:@"selected"] target:self action:@selector(save)];
    

    

}

- (void)save
{
    
    
    if ([_delegate respondsToSelector:@selector(nickNameViewController:sendValue:)]) {
        [_delegate nickNameViewController:self sendValue:self.nameTF.text];
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

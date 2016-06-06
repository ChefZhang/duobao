//
//  ZBGoodsDetailController.m
//  IndianaSoldiers
//
//  Created by leo on 16/5/13.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "ZBGoodsDetailController.h"
#import <UIImageView+WebCache.h>


@interface ZBGoodsDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ZBGoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [self.headerImage sd_setImageWithURL:[NSURL URLWithString: [QYURLShort stringByAppendingPathComponent:self.model.logoPath]] placeholderImage:[UIImage imageNamed:@"tupian"]];
    
    
    //标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:25],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.title = @"详情";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        cell.textLabel.text = self.model.goodsName;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }else if(indexPath.section == 0 && indexPath.row == 1 ){
        cell.textLabel.text = [NSString stringWithFormat:@"期号:512535123513"];
        cell.detailTextLabel.text = @"05:05:00";
        
        
    }else if(indexPath.section == 1 && indexPath.row == 0 ){
        cell.textLabel.text = @"         声明：所有抽奖活动与苹果公司无关";
         cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }else if(indexPath.section == 2 && indexPath.row == 0 ){
        
        cell.textLabel.text = @"商品详情";
        cell.imageView.image = [UIImage imageNamed:@"shopIcon01"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
      
    }else if(indexPath.section == 2 && indexPath.row == 1 ){
        cell.textLabel.text = @"往期揭晓";
          cell.imageView.image = [UIImage imageNamed:@"shopIcon02"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
    }else if(indexPath.section == 2 && indexPath.row == 2 ){
        cell.textLabel.text = @"商品晒单";
          cell.imageView.image = [UIImage imageNamed:@"shopIcon03"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
    }else if(indexPath.section == 2 && indexPath.row == 3){
        cell.textLabel.text = @"参与记录";
          cell.imageView.image = [UIImage imageNamed:@"shopIcon04"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     
    }
    
    
    return cell;
    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 70;
    }else{
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 2 && indexPath.row == 0 ){
        
      
        
    }else if(indexPath.section == 2 && indexPath.row == 1 ){
      
        
    }else if(indexPath.section == 2 && indexPath.row == 2 ){
     
        
    }else if(indexPath.section == 2 && indexPath.row == 3){
     
    }
}
@end

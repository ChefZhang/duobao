//
//  QYTabBarController.m
//  IndianaSoldiers
//
//  Created by qy on 16/5/5.
//  Copyright © 2016年 qy. All rights reserved.
//

#import "QYTabBarController.h"
#import "QYNavigationController.h"
#import "QYPurchaseViewController.h"
#import "QYProductViewController.h"
#import "QYAnnouncedViewController.h"
#import "QYShopingViewController.h"
#import "UIImage+QYImage.h"
#import "QYTabBar.h"

@interface QYTabBarController ()
/** taBBar item 模型数组 */
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation QYTabBarController

- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAllController];
    [self setupAllTabBarItem];
    [self setuptabBar];
    [self setupTabBarItemColor];
    
}



//设置tabbaritem的字体颜色
- (void)setupTabBarItemColor {

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       QYColor(146, 146, 146), UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = QYColor(253, 117, 120);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
}

//tabBar上的按钮是在viewWillDidLoad上添加的
- (void)viewWillAppear:(BOOL)animated{
    //还原系统的做法
    [super viewWillAppear:animated];
    
}

- (void)setuptabBar {
    
    QYTabBar *tabBar = [[QYTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}

//添加所有ViewController
- (void)addAllController{
    
    //抢购
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([QYPurchaseViewController class]) bundle:nil];
    QYPurchaseViewController *pruchase = [storyboard instantiateInitialViewController];
    QYNavigationController *nav1 = [[QYNavigationController alloc]initWithRootViewController:pruchase];
    [self addChildViewController:nav1];
    
    //商品
    QYProductViewController *product = [[QYProductViewController alloc]init];
    QYNavigationController *nav2 = [[QYNavigationController alloc]initWithRootViewController:product];
    [self addChildViewController:nav2];
    

    
    //开奖
    QYAnnouncedViewController *announced = [[QYAnnouncedViewController alloc]init];
    QYNavigationController *nav3 = [[QYNavigationController alloc]initWithRootViewController:announced];
    [self addChildViewController:nav3];
    
    //购物车
//    QYShopingViewController *shoping = [[QYShopingViewController alloc]init];
    
    UIStoryboard *ShopStoryboard =[UIStoryboard storyboardWithName:NSStringFromClass([QYShopingViewController class]) bundle:nil];
    QYShopingViewController *shoping  = [ShopStoryboard instantiateInitialViewController];
    
    
    QYNavigationController *nav4 = [[QYNavigationController alloc]initWithRootViewController:shoping];
    [self addChildViewController:nav4];
    
}


//设置tabar的内容
- (void)setupAllTabBarItem{
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    [nav.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    nav.tabBarItem.title = @"抢购";
    nav.tabBarItem.image = [UIImage imageNamed:@"icon01.png"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"icon02.png"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"商品";
    nav1.tabBarItem.image = [UIImage imageNamed:@"icon03.png"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"icon04.png"];
    
    //    // 2:发布
    //    QYPublishViewController *publishVc = self.childViewControllers[2];
    //    publishVc.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
    //    publishVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    //    publishVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"最新揭晓";
    nav3.tabBarItem.image = [UIImage imageNamed:@"icon05.png"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"icon06.png"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"购物车";
    nav4.tabBarItem.image = [UIImage imageNamed:@"icon07.png"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"icon08.png"];
}



@end

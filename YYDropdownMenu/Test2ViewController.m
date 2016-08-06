//
//  Test2ViewController.m
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import "Test2ViewController.h"
#import "YYDropdownMenu.h"

@interface Test2ViewController ()<YYMenuDelegate> {
    NSMutableArray *provinces;
    NSMutableArray *cities;
    
    NSArray *leftArray;
    NSArray *rightArray;
}


@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDropdownMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDropdownMenu{
    // 数据
    NSArray *titleArray = @[@"最近", @"地区", @"等级"];
    
    provinces = [[NSMutableArray alloc] init];
    cities = [[NSMutableArray alloc] init];
    
    NSArray *pTemp = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    for (NSDictionary *dic in pTemp) {
        NSString *province = [dic objectForKey:@"state"];
        [provinces addObject:province];
        
        NSMutableArray *oneCity = [[NSMutableArray alloc] init];
        NSArray *cTemp = [dic objectForKey:@"cities"];
        for (NSDictionary *cDic in cTemp) {
            NSString *city = [cDic objectForKey:@"city"];
            NSDictionary *cityDic = [NSDictionary dictionaryWithObjectsAndKeys:city,@"title", nil];
            [oneCity addObject:cityDic];
        }
        [cities addObject:oneCity];
    }
    
    NSArray *One_leftArray = [[NSArray alloc] init];
    NSArray *Two_leftArray = provinces;
    NSArray *Three_leftArray = [[NSArray alloc] init];
    leftArray = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray,Three_leftArray, nil];
    
    NSArray *F_rightArray = @[];
    NSArray *S_rightArray = cities;
    NSArray *H_rightArray = @[
                              @[
                                  @{@"title":@"全部等级"},
                                  @{@"title":@"三级甲等"},
                                  @{@"title":@"二级甲等"}
                                  ] ,
                              ];
    rightArray = [[NSArray alloc] initWithObjects:F_rightArray, S_rightArray, H_rightArray,nil];
    
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    rect.size.height -= 64;
    YYDropdownMenu *dropdown = [[YYDropdownMenu alloc] initWithFrame: rect andTitles:titleArray andLeftListArray:leftArray andRightListArray:rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值
    [self.view addSubview:dropdown];
}

// 实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedIndex:(NSInteger)index LeftIndex:(NSString *)left RightIndex:(NSString *)right
{
//    if (index == 10001) {       // 按地区筛选
//        NSArray *temp = cities[[left integerValue]];
//        NSDictionary *cityDic = temp[[right integerValue]];
//        NSString *city = [cityDic objectForKey:@"title"];
//        
//        
//    }
//    else if (index == 10002) {      // 按医院等级筛选
//        
//    }
//    else {
//        return;
//    }
    
}

//顶部按钮事件回调,10000为第一个按钮
- (void)clickedMenuIndex:(NSInteger)index withShow:(BOOL)isShow
{
    if (index == 10000) {       // 按最近距离筛选
        
    }
}

@end

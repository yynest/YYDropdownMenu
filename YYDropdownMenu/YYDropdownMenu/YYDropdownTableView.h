//
//  YYDropdownTableView.h
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/18.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYTableViewDelegate <NSObject>

@required
- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second;
@end

@interface YYDropdownTableView : UIView

@property (nonatomic, strong) id <YYTableViewDelegate>delegate;

//初始化下拉菜单
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems;
//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right;
- (void)hideTableView;

@end

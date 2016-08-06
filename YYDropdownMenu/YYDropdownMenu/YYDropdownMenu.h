//
//  YYDropdownMenu.h
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYMenuDelegate <NSObject>

@optional
- (void)clickedMenuIndex:(NSInteger)index withShow:(BOOL)isShow;

- (void)dropdownSelectedIndex:(NSInteger)index LeftIndex:(NSString *)left RightIndex:(NSString *)right;

@end

@interface YYDropdownMenu : UIView

@property (assign, nonatomic) id<YYMenuDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray;

@end

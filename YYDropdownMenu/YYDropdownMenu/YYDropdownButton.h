//
//  YYDropdownButton.h
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYButtonDelegate <NSObject>

- (void)showMenu:(NSInteger)index withShow:(BOOL)isShow;

@end

@interface YYDropdownButton : UIView

@property (nonatomic, assign) id<YYButtonDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray*)titles;

- (void)changeButtonIndex:(NSInteger)index withTitle:(NSString *)title;

@end

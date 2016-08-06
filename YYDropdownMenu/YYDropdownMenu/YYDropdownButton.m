//
//  YYDropdownButton.m
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import "YYDropdownButton.h"

@interface YYDropdownButton (){
    CGFloat width;
    CGFloat height;
    NSInteger count;
    CGFloat widthCell;
    
    NSInteger lastTap;
    BOOL isSelected;
    
    UIImage *image;
    
    NSArray *titleList;
}

@end

@implementation YYDropdownButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray*)titles{
    if (self = [super initWithFrame:frame]) {
        titleList = titles;
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        width = CGRectGetWidth(frame);
        height = CGRectGetHeight(frame);
        count = titles.count;
        widthCell = width/count;
        
        [self addButtonToView:titles];
        
        lastTap = 10000;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenu:) name:@"hideMenu" object:nil];
    }
    return self;
}

- (void)hideMenu:(NSNotification *)notification {
    NSString *str = [notification object];
    [self changeButtionTag:[str integerValue]+10000];
}

- (void)addButtonToView:(NSArray *)titles {
    for (int i = 0; i < count; i++) {
        UIButton *button = [self makeButton:[titles objectAtIndex:i] andIndex:i];
        [self addSubview:button];
//        if (i > 0) {
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x, 10, 1, 20)];
//            lineView.backgroundColor = [UIColor colorWithRed:(217.0 / 255.0) green:(217.0 / 255.0) blue:(217.0 / 255.0) alpha:1.0f];
//            [self addSubview:lineView];
//        }
    }
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, 1)];
    bottomLine.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLine];
}

- (UIButton *)makeButton:(NSString *) title andIndex:(int)index{
    float offsetX = widthCell * index;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, 0, widthCell, 60)];
    button.tag = 10000 + index;
    [button setBackgroundColor:[UIColor whiteColor]];
    if (index == 0 && (titleList.count != 1)) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    else{
        CGFloat widthTitle = [self getWidthText:title];
        image = [UIImage imageNamed:@"nearbyhospital_downarrow_normal"];
        float padding = (widthCell - (image.size.width + widthTitle)) / 2;
        
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nearbyhospital_downarrow_selected"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"nearbyhospital_downarrow_selected"] forState:UIControlStateSelected];
        [button setImageEdgeInsets:UIEdgeInsetsMake(11, widthTitle + padding + 5, 11, 0)];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(11, 0, 11, image.size.width + 5)];
        
        CGRect rect = button.frame;
        rect.size.width = widthTitle;
        rect.origin.x = padding;
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:rect];
        lbTitle.tag = 100;
        lbTitle.textColor = [UIColor blackColor];
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.text = title;
        [button addSubview:lbTitle];
    }
    

    
    [button addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

- (CGFloat)getWidthText:(NSString *)text{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f]];
    return (size.width > widthCell*0.7) ? (widthCell*0.7) : (size.width);
}

- (void)showMenuAction:(id)sender {
    UIButton *bt = (UIButton *)sender;
    bt.selected = !bt.selected;
    NSInteger i = [bt tag];
    if(_delegate && [_delegate respondsToSelector:@selector(showMenu: withShow:)]){
        [_delegate showMenu:i withShow:bt.selected];
    }
    
    //切换之前的
    [self openMenuBtnAnimation:i];
}

- (void)openMenuBtnAnimation:(NSInteger)index {
    if (lastTap != index) {
        [self changeButtionTag:lastTap];
        lastTap = index;
    }
}

- (void)changeButtionTag:(NSInteger)index {
    UIButton *btn = (UIButton *)[self viewWithTag:index];
    BOOL selected = btn.selected;
    if (selected) {
        btn.selected = !selected;
    }
}

- (void)changeButtonIndex:(NSInteger)index withTitle:(NSString *)title{
    UIButton *btn = (UIButton *)[self viewWithTag:index];
    BOOL selected = btn.selected;
    if (selected) {
        btn.selected = !selected;
        UILabel *lb = (UILabel *)[btn viewWithTag:100];
        lb.text = title;
        
        CGFloat widthTitle = [self getWidthText:title];
        float padding = (widthCell - (image.size.width + widthTitle)) / 2;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(11, widthTitle + padding + 5, 11, 0)];
        
        CGRect rect = lb.frame;
        rect.size.width = widthTitle;
        rect.origin.x = padding;
        lb.frame = rect;
    }
}

@end

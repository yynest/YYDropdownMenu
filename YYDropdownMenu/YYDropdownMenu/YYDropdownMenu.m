//
//  YYDropdownMenu.m
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/15.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import "YYDropdownMenu.h"
#import "YYDropdownButton.h"
#import "YYDropdownTableView.h"

@interface YYDropdownMenu ()<YYButtonDelegate,YYTableViewDelegate>{
    CGRect rectTable;
    
    YYDropdownTableView *_tableView;
    YYDropdownButton *dropdownButton;
    NSInteger _lastIndex;
    NSArray *titleList;
}

@end

@implementation YYDropdownMenu


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray {
    if (self = [super initWithFrame:frame]) {
        titleList = titles;
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.backgroundColor = [UIColor clearColor];
        CGRect rect = frame;
        rect.origin.y = 0;
        rect.size.height = 60;
        dropdownButton = [[YYDropdownButton alloc] initWithFrame:rect withTitles:titles];
        dropdownButton.delegate = self;
        [self addSubview:dropdownButton];
        
        rectTable = frame;
        rectTable.origin.y = 61;
        rectTable.size.height -= 61;
        _tableView = [[YYDropdownTableView alloc] initWithFrame:rectTable andLeftItems:leftArray andRightItems:rightArray];
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark -YYButtonDelegate
- (void)showMenu:(NSInteger)index withShow:(BOOL)isShow{
    _lastIndex = index;
    if (index == 10000 && (titleList.count != 1)) {
        [_tableView hideTableView];
    }
    else {
        
        NSInteger _buttonSelectedIndex = index - 10000;
        NSString *selected = @"0-0";
        
        NSArray *selectedArray = [selected componentsSeparatedByString:@"-"];
        NSString *left = [selectedArray objectAtIndex:0];
        NSString *right = [selectedArray objectAtIndex:1];
        [_tableView showTableView:_buttonSelectedIndex WithSelectedLeft:left Right:right];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(clickedMenuIndex:withShow:)]) {
        [_delegate clickedMenuIndex:index withShow:YES];
    }
}


- (void)reduceBackgroundSize {
//    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 104)];
}


#pragma mark -YYTableViewDelegate
- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second{
    
    [self returnSelectedLeftIndex:first RightIndex:second];
    [dropdownButton changeButtonIndex:_lastIndex withTitle:second];
}

- (void)returnSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right {
    if (_delegate && [_delegate respondsToSelector:@selector(dropdownSelectedIndex:LeftIndex:RightIndex:)]) {
        [_delegate dropdownSelectedIndex:_lastIndex LeftIndex:left RightIndex:right];
    }
}


@end

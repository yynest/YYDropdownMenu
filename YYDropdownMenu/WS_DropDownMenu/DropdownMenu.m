//
//  DropdownMenu.m
//  Common
//
//  Created by Ryan Wong on 15/9/9.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

#import "DropdownMenu.h"
#import "CommonDefine.h"

@implementation DropdownMenu

- (id)initDropdownWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray {
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, 160);
        self.view.backgroundColor = [UIColor redColor];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        _button = [[DropdownButton alloc] initDropdownButtonWithTitles:titles];
        _button.delegate = self;
        _tableView = [[ConditionDoubleTableView alloc] initWithFrame:self.view.bounds andLeftItems:leftArray andRightItems:rightArray];
        _tableView.delegate = self;
        [self.view addSubview:_tableView.view];
        [self.view addSubview:_button];
        [self initSelectedArray:titles];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reduceBackgroundSize) name:@"hideMenu" object:nil];
    }
    return self;
}

- (void)initSelectedArray:(NSArray *)titles {
    _buttonIndexArray = [[NSMutableArray alloc] initWithCapacity:titles.count];
}

//button点击代理
- (void)showMenu:(NSInteger)index {
    _lastIndex = index;
    if (index == 10000) {
        [_tableView hideTableView];
    }
    else {
        [self.view setFrame:SCREEN_RECT];
        _buttonSelectedIndex = index - 10000;
        NSString *selected = @"0-0";
        if (_buttonIndexArray.count > _buttonSelectedIndex){
            selected = [_buttonIndexArray objectAtIndex:_buttonSelectedIndex];
        } else {
            [_buttonIndexArray addObject:selected];
        }
        NSArray *selectedArray = [selected componentsSeparatedByString:@"-"];
        NSString *left = [selectedArray objectAtIndex:0];
        NSString *right = [selectedArray objectAtIndex:1];
        [_tableView showTableView:_buttonSelectedIndex WithSelectedLeft:left Right:right];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(clickedMenuIndex:withShow:)]) {
        [_delegate clickedMenuIndex:index withShow:YES];
    }
}

- (void)hideMenu:(NSInteger)index {
    if (index != 10000) {
        [_tableView hideTableView];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(clickedMenuIndex:withShow:)]) {
        [_delegate clickedMenuIndex:index withShow:NO];
    }
}

- (void)reduceBackgroundSize {
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 104)];
}

- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second{
//    NSString *index = [NSString stringWithFormat:@"%@-%@", first, second];
////    [_buttonIndexArray setObject:index atIndexedSubscript:_buttonSelectedIndex];
    [self returnSelectedLeftIndex:first RightIndex:second];
}

- (void)returnSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right {
    if (_delegate && [_delegate respondsToSelector:@selector(dropdownSelectedIndex:LeftIndex:RightIndex:)]) {
        [_delegate dropdownSelectedIndex:_lastIndex LeftIndex:left RightIndex:right];
    }
}

@end

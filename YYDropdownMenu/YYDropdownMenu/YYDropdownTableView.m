//
//  YYDropdownTableView.m
//  YYDropdownMenu
//
//  Created by iosdev on 16/1/18.
//  Copyright © 2016年 iosdev. All rights reserved.
//

#import "YYDropdownTableView.h"

#define CELLHEIGHT 44.0;

@interface YYDropdownTableView ()<UITableViewDelegate, UITableViewDataSource>{
    
        UIView *_rootView;
        
        UITableView *_firstTableView;
        UITableView *_secondTableView;
        
        NSArray *_leftItems;
        NSArray *_rightItems;
        NSArray *_leftArray;
        NSArray *_rightArray;
        
        NSInteger firstSelectedIndex;
        NSInteger secondSelectedIndex;
        
        NSInteger _buttonIndex;
        
        BOOL isHidden;
        CGFloat tableHeight;
        CGFloat tableWidth;
}

@end

@implementation YYDropdownTableView


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems{
    self = [super initWithFrame:frame];
    if (self) {
        tableHeight = frame.size.height*0.7;
        tableWidth = frame.size.width;
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapDimissMenu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTableView)];
//        [self addGestureRecognizer:tapDimissMenu];
        
        frame.origin.y = 0;
        _rootView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_rootView];
        
        
        _buttonIndex = -1;
        isHidden = YES;
        _leftItems = leftItems;
        _rightItems = RightItems;
        
        [self initFirstTableView];
        [self initSecondTableView];
        
    }
    [self setHidden:YES];
    return self;
}

- (void)initFirstTableView {
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableWidth*0.3, tableHeight) style:UITableViewStylePlain];
    //1.分割线从最左边开始绘制
    _firstTableView.separatorInset = UIEdgeInsetsZero;
    _firstTableView.layoutMargins = UIEdgeInsetsZero;
    _firstTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _firstTableView.backgroundColor = [UIColor lightGrayColor];
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    [_rootView addSubview:_firstTableView];
}

- (void)initSecondTableView {
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableWidth*0.3, 0, tableWidth*0.7, tableHeight) style:UITableViewStylePlain];
    //1.分割线从最左边开始绘制
    _secondTableView.separatorInset = UIEdgeInsetsZero;
    _secondTableView.layoutMargins = UIEdgeInsetsZero;
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _secondTableView.backgroundColor = [UIColor whiteColor];
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    [_rootView addSubview:_secondTableView];
}

//2.分割线从最左边开始绘制
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _firstTableView) {
        return _leftArray.count;
    } else if (tableView == _secondTableView) {
        if (_rightArray.count > firstSelectedIndex) {
            NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
            return array.count;
        } else {
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (tableView == _firstTableView) {
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstCell"];
                }
                [self removeCellView:cell];
                if (_leftArray.count > 0) {
                    cell.textLabel.text = [_leftArray objectAtIndex:indexPath.row];
                }
                break;
            }
            default:
                break;
        }
        
        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        selectView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = selectView;
        cell.backgroundColor = [UIColor clearColor];
        
    } else if (tableView == _secondTableView){
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondCell"];
                }
                [self removeCellView:cell];
                NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
                if (array.count <= 0) {
                    break;
                }
                NSDictionary *dic = [array objectAtIndex:indexPath.row];
                cell.textLabel.text = [dic valueForKey:@"title"];
                //                cell.textLabel.highlightedTextColor = [self colorWithRGB:0x90EE90];
                break;
            }
            default:
                break;
        }
        //        UIView *noSelectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        //        UIView *noSelectLine = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width - 15, 0.5)];
        //        noSelectLine.backgroundColor = [self colorWithRGB:0xBEBEBE];
        //        [noSelectView addSubview:noSelectLine];
        //        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        //        UIView *selectLine = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width - 15, 0.5)];
        //        selectLine.backgroundColor = [self colorWithRGB:0x90EE90];
        //        [selectView addSubview:selectLine];
        //        cell.backgroundView = noSelectView;
        //        cell.selectedBackgroundView = selectView;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _firstTableView && _leftArray.count > 0) {
        firstSelectedIndex = indexPath.row;
        [_secondTableView reloadData];
    } else {
        [self returnSelectedValue:indexPath.row];
    }
    
}

- (void)removeCellView:(UITableViewCell*)cell {
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

#pragma mark - 私有方法
//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right {
    if (isHidden == YES || _buttonIndex != index) {
        _buttonIndex = index;
        isHidden = NO;
        self.alpha = 1.0;
        [self setHidden:NO];
        [self reloadTableViewData:index];
        [self showSingleOrDouble];
        [self showLastSelectedLeft:left Right:right];
        _rootView.center = CGPointMake(self.frame.size.width / 2, 0 - _rootView.bounds.size.height / 2);
        [UIView animateWithDuration:0.5 animations:^{
            _rootView.center = CGPointMake(self.frame.size.width / 2, _rootView.bounds.size.height / 2);
            
        }completion:^(BOOL finish){
            //半透明
            _rootView.backgroundColor = [UIColor blackColor];
            _rootView.alpha = 0.6;
        }];
    } else {
        [self hideTableView];
    }
}

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

- (void)showSingleOrDouble {
    NSInteger left = _leftArray.count;
    NSArray *array = [_rightArray objectAtIndex:0];
    NSInteger right = array.count;
    NSInteger count = (left>right) ? left : right;
    CGFloat height = count*CELLHEIGHT;
    height = (height>tableHeight) ? tableHeight : height;
    
    if (left <= 0 && right <= 0) {
        [_firstTableView setHidden:YES];
        _secondTableView.hidden = YES;
    }
    else if (left <= 0) {
        [_firstTableView setHidden:YES];
        _secondTableView.hidden = NO;
        _secondTableView.frame = CGRectMake( 0, 0, tableWidth, height);
    } else {
        [_firstTableView setHidden:NO];
//        _firstTableView.frame = CGRectMake(0, 0, tableWidth*0.3, height);
        _secondTableView.hidden = NO;
        _secondTableView.frame = CGRectMake(tableWidth*0.3, 0, tableWidth*0.7, height);
    }
}

//按了不同按钮,刷新菜单数据
- (void)reloadTableViewData:(NSInteger)index {
    _leftArray = [[NSArray alloc] initWithArray:[_leftItems objectAtIndex:index]];
    _rightArray = [[NSArray alloc] initWithArray:[_rightItems objectAtIndex:index]];
}

//渐渐隐藏菜单
- (void)hideTableView {
    isHidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finish){
        [self setHidden:YES];
        _rootView.center = CGPointMake(self.frame.size.width / 2, 0 - _rootView.bounds.size.height / 2);
        _rootView.backgroundColor = [UIColor clearColor];
    }];
}

//返回选中位置
- (void)returnSelectedValue:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFirstValue:SecondValue:)]) {
        NSInteger firstSelected = firstSelectedIndex > 0 ? firstSelectedIndex : 0;
//        NSString *firstIndex = [NSString stringWithFormat:@"%ld", firstSelected];
//        NSString *indexObj = [NSString stringWithFormat:@"%ld", (long)index];
        NSString *strLeft;
        if (_leftArray.count>firstSelected) {
            strLeft = [_leftArray objectAtIndex:firstSelected];
        }
        NSString *strRight = [[[_rightArray objectAtIndex:firstSelected] objectAtIndex:index] objectForKey:@"title"];
        [self.delegate performSelector:@selector(selectedFirstValue:SecondValue:) withObject:strLeft withObject:strRight];
        [self hideTableView];
    }
}

//显示最后一次选中位置
- (void)showLastSelectedLeft:(NSString *)leftSelected Right:(NSString *)rightSelected {
    
    NSInteger left = [leftSelected intValue];
    if (_leftArray.count > 0) {
        [_firstTableView reloadData];
        NSIndexPath *leftSelectedIndexPath = [NSIndexPath indexPathForRow:left inSection:0];
        [_firstTableView selectRowAtIndexPath:leftSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    firstSelectedIndex = left;
    
    NSInteger right = [rightSelected intValue];
    [_secondTableView reloadData];
    NSIndexPath *rightSelectedIndexPath = [NSIndexPath indexPathForRow:right inSection:0];
    //    [_secondTableView selectRowAtIndexPath:rightSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (UIColor*)colorWithRGB:(unsigned int)RGBValue
{
    return [UIColor colorWithRed:((RGBValue&0xFF0000)>>16)/255.0 green:((RGBValue&0xFF00)>>8)/255.0 blue:(RGBValue&0xFF)/255.0 alpha:1];
}

- (UIColor*)colorWithRGB:(unsigned int)RGBValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((RGBValue&0xFF0000)>>16)/255.0 green:((RGBValue&0xFF00)>>8)/255.0 blue:(RGBValue&0xFF)/255.0 alpha:alpha];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideMenu" object:nil];
}



@end

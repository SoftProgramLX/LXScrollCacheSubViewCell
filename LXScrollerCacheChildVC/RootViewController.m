//
//  ViewController.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/24.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "RootViewController.h"
#import "LXScrollViewCell.h"
#import "TwoScrollViewCell.h"
#import "OneScrollViewCell.h"
#import "LXScrollView.h"
#import "ScrollChildHeader.h"
#import "ThreeScrollViewCell.h"

@interface RootViewController () <LXScrollViewDelegate>

@property (nonatomic, weak)   LXScrollView *scrollerView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetup];

    NSMutableArray *titleArr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [titleArr addObject:[NSString stringWithFormat:@"title_%d", i]];
    }
    self.titleArray = titleArr;

    LXScrollView *scrollerView = [[LXScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    scrollerView.delegate = self;
    scrollerView.titleCanScroll = YES;
    scrollerView.titleArray = self.titleArray;
    [self.view addSubview:scrollerView];
    self.scrollerView = scrollerView;
}

- (LXScrollViewCell *)scrollView:(LXScrollView *)scrollView cellForIndex:(NSInteger)index
{
    if (index%4 == 0 ) {
        static NSString *cellId = @"OneScrollViewCell";
        OneScrollViewCell *viewCell = [scrollView dequeueReusableCellWithIdentifier:cellId];
        if (!viewCell) {
            viewCell = [[OneScrollViewCell alloc] initWithReuseIdentifier:cellId];
        }
        [viewCell refreshDataWithIndex:index];
        return viewCell;
        
    } else if (index%4 == 1) {
        static NSString *cellId = @"TwoScrollViewCell";
        TwoScrollViewCell *viewCell = [scrollView dequeueReusableCellWithIdentifier:cellId];
        if (!viewCell) {
            viewCell = [[TwoScrollViewCell alloc] initWithReuseIdentifier:cellId];
        }
        [viewCell refreshDataWithIndex:index];
        return viewCell;
    } else {
        static NSString *cellId = @"ThreeScrollViewCell";
        ThreeScrollViewCell *viewCell = [scrollView dequeueReusableCellWithIdentifier:cellId];
        if (!viewCell) {
            viewCell = [[ThreeScrollViewCell alloc] initWithReuseIdentifier:cellId];
        }
        [viewCell refreshDataWithIndex:index];
        return viewCell;
    }
}

- (void)scrollView:(LXScrollView *)tableView didSelectIndex:(NSInteger)index
{
    NSLog(@"点击了第 %ld 个标签", (long)index);
}

- (void)initSetup
{
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"ScrollerChildVCs";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.800 green:0.600 blue:0.800 alpha:0.5]];
    //下面句代码必不可少
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end




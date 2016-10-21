//
//  TwoScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "TwoListScrollView.h"

@implementation TwoListScrollView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        //在这里创建自己所需UI；
    }
    
    return self;
}

- (void)refreshDataWithIndex:(NSInteger)index
{
    //可以不用父类的label，在LXScrollViewCell里删除
    self.label.text = [NSString stringWithFormat:@"这是TwoScrollViewCell\n第 %ld 页", (long)index];
}

@end

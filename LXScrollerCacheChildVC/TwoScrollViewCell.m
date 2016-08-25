//
//  TwoScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "TwoScrollViewCell.h"

@implementation TwoScrollViewCell

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

- (void)refreshDataWithIndex:(NSInteger)index
{
    self.label.text = [NSString stringWithFormat:@"这是TwoScrollViewCell\n第 %ld 页", (long)index];
}

@end

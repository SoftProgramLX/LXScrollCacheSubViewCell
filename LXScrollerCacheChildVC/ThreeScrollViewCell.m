//
//  ThreeScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "ThreeScrollViewCell.h"

@implementation ThreeScrollViewCell

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)downlaodDataWithIndex:(NSInteger)index
{
    self.label.text = [NSString stringWithFormat:@"这是ThreeScrollViewCell\n第 %ld 页", (long)index];
}

@end

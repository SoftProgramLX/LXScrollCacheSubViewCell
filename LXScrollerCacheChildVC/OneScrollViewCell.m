//
//  OneScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "OneScrollViewCell.h"

@interface OneScrollViewCell ()

@end

@implementation OneScrollViewCell

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)refreshDataWithIndex:(NSInteger)index
{
    self.label.text = [NSString stringWithFormat:@"这是OneScrollViewCell\n第 %ld 页", (long)index];
}

@end



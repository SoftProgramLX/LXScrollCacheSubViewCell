//
//  UIScrollViewCell.m
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import "LXScrollViewCell.h"
#import "ScrollChildHeader.h"

@implementation LXScrollViewCell

+ (instancetype)cellWithScrollView:(LXScrollView *)ScrollView
{
    NSString *ID = NSStringFromClass(self);
    LXScrollViewCell *cell = [ScrollView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithReuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.reuseIdentifier = reuseIdentifier;
        
        //可以将此label删除，在子控制器里创建自己的UI
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 50)];
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        self.label = label;
    }

    return self;
}

- (void)refreshDataWithIndex:(NSInteger)index
{
    self.label.text = [NSString stringWithFormat:@"这是父类Cell\n第 %ld 页", (long)index];
}

@end

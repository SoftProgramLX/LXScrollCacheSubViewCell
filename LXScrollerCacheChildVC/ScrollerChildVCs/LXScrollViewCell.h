//
//  UIScrollViewCell.h
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/25.
//  Copyright © 2016年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXScrollView.h"

@interface LXScrollViewCell : UIView

@property (nonatomic, copy)   NSString *reuseIdentifier;
@property (nonatomic, weak)   UILabel *label;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
- (void)refreshDataWithIndex:(NSInteger)index;
+ (instancetype)cellWithScrollView:(LXScrollView *)ScrollView;

@end

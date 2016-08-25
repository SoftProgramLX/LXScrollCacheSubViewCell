//
//  ScrollChildHeader.h
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/24.
//  Copyright © 2016年 LX. All rights reserved.
//

#ifndef ScrollChildHeader_h
#define ScrollChildHeader_h

#import "UIView+Extension.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TITLE_HEIGHT 40
#define DEFAULT_TITLE_COLOR [UIColor blackColor]
#define RANDOM_COLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
#define IntgerToStr(index) [NSString stringWithFormat:@"%ld", (long)index]

#endif /* ScrollChildHeader_h */

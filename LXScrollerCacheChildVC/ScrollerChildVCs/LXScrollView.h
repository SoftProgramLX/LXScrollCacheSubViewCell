//
//  LXScrollView.h
//  LXScrollerCacheChildVC
//
//  Created by 李旭 on 16/8/24.
//  Copyright © 2016年 LX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXScrollListView;
@class LXScrollView;

@protocol LXScrollViewDelegate <NSObject>

@required
- (LXScrollListView *)scrollView:(LXScrollView *)scrollView cellForIndex:(NSInteger)index;

@optional
- (void)scrollView:(LXScrollView *)tableView didSelectIndex:(NSInteger)index;

@end

@interface LXScrollView : UIView

@property (nonatomic, assign) BOOL titleCanScroll;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak)   id<LXScrollViewDelegate> delegate;

- (LXScrollListView *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end

# LXScrollCacheSubViewCell
实现横向tableView功能，仿新闻首页标签栏和内容均可滚动

要实现横向滚动的像新闻首页这样的scrollView，用最笨的方法就是scrollView上添加不同的view，没有优化，没有缓存。假如标签栏有很多标签，并且大部分标签展示的页面的布局类似，这就很有必要采用缓存机制，类似tableView功能。

先看一下如下效果图：
![1499A456-6270-44FD-B4AD-1D8EA1FB8EF6.png](http://upload-images.jianshu.io/upload_images/301102-1d7b9e66ff98837a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



####基本原理：
滑动scrollview时，先判断是否需要加载新的cell，若需要，则先去缓存池取cell，如果取不到就创建cell。存取cell时有一个标识reuseIdentifier，即id，布局一样的界面就加载一样的cell，具有一样的id，加载cell时就通过传入的id匹配上缓存池中的cell的id就返回复用。


```objective-c

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    if (self.titleArray.count <= index) {
        return;
    }
    
    newIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(scrollView:cellForIndex:)]) {
        [self manageData];
        
        LXScrollViewCell *cell = [self.delegate scrollView:self cellForIndex:index];
        [self refreshCellFrame:cell withIndex:index];
    }
}
```



```objective-c

这self.showChildVCArr数组里记录的是当前屏幕能看到的cell，当需加载新的cell时，得判断数组里全部cell是否还能在屏幕上显示（如果点击离当前界面对应的标签更远的标签，那么showChildVCArr里的所有cell都不会在屏幕中显示）。
- (void)manageData
{
    //判断滑动方向，因为self.showChildVCArr的数据是根据X坐标升序排列的
    if (lastIndex < newIndex) {
        for (int i = 0; i < self.showChildVCArr.count; i++) {
            LXScrollViewCell *cell = self.showChildVCArr[i];
            
            if (cell.x/SCREEN_WIDTH < newIndex-1) {
                //判断了此cell已经没有显示在屏幕上
                [self changeDataWithCell:cell];
                i--;
            } else {
                break;
            }
        }
    } else {
        for (int i = (int)self.showChildVCArr.count - 1; i >= 0 && self.showChildVCArr.count > 0; i--) {
            LXScrollViewCell *cell = self.showChildVCArr[i];
            
            if (cell.x/SCREEN_WIDTH > newIndex+1) {
                //判断了此cell已经没有显示在屏幕上
                [self changeDataWithCell:cell];
            } else {
                break;
            }
        }
    }
}

- (void)changeDataWithCell:(LXScrollViewCell *)cell
{
    [self.showChildVCArr removeObject:cell];
    if ([self.cacheChildVCDic objectForKey:cell.reuseIdentifier] == nil) {
        [self.cacheChildVCDic setObject:[NSMutableArray array] forKey:cell.reuseIdentifier];
    }
    
    //将cell添加到缓存池中
    [[self.cacheChildVCDic objectForKey:cell.reuseIdentifier] addObject:cell];
}
```

然后在业务控制器里的集成代码如下：
```objective-c
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
    //标签栏可以由属性titleCanScroll设置能否滚动。
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
```
仿tableview的原理和协议方法做的复用，通过dequeueReusableCellWithIdentifier:实现缓存机制。

```objective-c
- (nullable __kindof LXScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    //先取显示中的cell
    if (lastIndex > newIndex) {//如果向右滑动
        for (int i = 0; i < self.showChildVCArr.count; i++) {
            LXScrollViewCell *cell = self.showChildVCArr[i];
            if (cell.x/SCREEN_WIDTH == newIndex) {//if成立说明这个cell还是显示在界面上的
                showing = YES;
                return cell;
            } else if (cell.x/SCREEN_WIDTH > newIndex){
                break;
            }
        }
    } else {
        for (int i = (int)self.showChildVCArr.count - 1; i >= 0; i--) {
            LXScrollViewCell *cell = self.showChildVCArr[i];
            if (cell.x/SCREEN_WIDTH == newIndex) {
                showing = YES;
                return cell;
            } else if (cell.x/SCREEN_WIDTH < newIndex){
                break;
            }
        }
    }
    
    //再取缓存中的cell
    NSArray *cellArr = [self.cacheChildVCDic objectForKey:identifier];
    if (cellArr.count > 0) {
        //随意取一个相同id的cell返回
        return [cellArr firstObject];
    }
    
    return nil;
}
```


----


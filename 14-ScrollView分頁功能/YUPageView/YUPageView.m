//
//  YUPageView.m
//  14-ScrollView分頁功能
//
//  Created by 游宗翰 on 2016/9/15.
//  Copyright © 2016年 han. All rights reserved.
//

#import "YUPageView.h"

@interface YUPageView () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCroller;

@property (weak, nonatomic) NSTimer *timer;
@end

@implementation YUPageView

+ (instancetype)pageView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.scrollView.delegate = self;
    
    self.pageCroller.hidesForSinglePage = YES;
    
    [self startTimer];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    NSUInteger count = imageNames.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.pageCroller.numberOfPages = count;
    
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;
    
    for (int i = 0; i < self.imageNames.count; i++) {
        self.scrollView.subviews[i].frame = CGRectMake(i * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight);
    }
    
    self.scrollView.contentSize = CGSizeMake(self.imageNames.count * scrollViewWidth, scrollViewHeight);
}

#pragma mark - Timer
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
}

- (void)nextPage {
    NSUInteger page = self.pageCroller.currentPage + 1;
    if (page == self.imageNames.count) {
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * page, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    self.pageCroller.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startTimer];
}




@end


//
//  LZScrollView.m
//  AcdseeImage
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "LZScrollView.h"
#import "ImgScrllView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface LZScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *mainScrollView;

@property (nonatomic,strong)ImgScrllView *ImgView;

@property (nonatomic,strong)UILabel *numLable;

@property (nonatomic,strong)UIWindow *window;

@property (nonatomic,strong)NSArray *LImgArray;

@end

@implementation LZScrollView

-(instancetype)initWithImgArray:(NSArray *)imgArray{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.LImgArray = imgArray;
        //当前窗口
        _window = [UIApplication sharedApplication].keyWindow;
        self.mainScrollView.contentSize = CGSizeMake(self.LImgArray.count * SCREEN_WIDTH +10*(self.LImgArray.count), SCREEN_HEIGHT);
        
        //增加滚动视图
        [self ImgScrollViewAdd];
        
    }
    return self;
}

#pragma mark 增加滚动图片View
-(void)ImgScrollViewAdd{
    
    for (int i=0;i<self.LImgArray.count; i++) {
       ImgScrllView *imgView  = [[ImgScrllView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH +10)*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imgView setImgViewurlStr:self.LImgArray[i]];
        imgView.Single = ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.mainScrollView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        };
        [self.mainScrollView addSubview:imgView];
    }
}
#pragma mark 显示
-(void)show{
    [_window addSubview:self.mainScrollView];
    
    [_window addSubview:self.numLable];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.mainScrollView) {
        int i = scrollView.contentOffset.x/(SCREEN_WIDTH);
        self.numLable.text = [NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)self.LImgArray.count];
    }
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+10, SCREEN_HEIGHT)];
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.maximumZoomScale = 2;
        _mainScrollView.minimumZoomScale = 1;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
    
}

-(UILabel *)numLable{
    if (!_numLable) {
        _numLable = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, SCREEN_HEIGHT-60, 80,30)];
        _numLable.textColor = [UIColor whiteColor];
        _numLable.textAlignment = NSTextAlignmentCenter;
        _numLable.text = [NSString stringWithFormat:@"1/%ld",self.LImgArray.count];
    }
    return _numLable;
}

-(NSArray *)LImgArray{
    if (!_LImgArray) {
        _LImgArray = [NSArray array];
    }
    return _LImgArray;
}
@end

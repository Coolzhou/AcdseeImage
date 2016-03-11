//
//  ImgScrllView.m
//  AcdseeImage
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "ImgScrllView.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size;

@end

@implementation UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    if (widthRatio > heightRatio) {
        imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
    } else {
        imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
    }
    
    return imageSize;
}

@end

@interface UIImageView (VIUtil)

- (CGSize)contentSize;

@end

@implementation UIImageView (VIUtil)

- (CGSize)contentSize
{
    return [self.image sizeThatFits:self.bounds.size];
}

@end

@interface ImgScrllView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *PicView;

@end

@implementation ImgScrllView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 1;
        self.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
        self.bounces = YES;
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        
        //添加手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleClickTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleClickTap:)];
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleClickTap:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;//需要点两下
        twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
        
        [self.PicView addGestureRecognizer:singleTap];
        [self.PicView addGestureRecognizer:doubleTap];
        [self.PicView addGestureRecognizer:twoFingerTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
    }
    return self;
}

#pragma mark 设置图片
-(void)setImgViewurlStr:(NSString *)urlStr{
    
    [_PicView sd_setImageWithURL:[NSURL URLWithString:urlStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize imgSize = _PicView.contentSize;
        if (imgSize.width == SCREEN_WIDTH) {
            _PicView.frame = CGRectMake(0, (SCREEN_HEIGHT-imgSize.height)/2.0, imgSize.width, imgSize.height);
        }else{
            _PicView.frame = CGRectMake((SCREEN_WIDTH-imgSize.width)/2.0, 0, imgSize.width, imgSize.height);
        }
    }];
    _PicView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.PicView];
}

#pragma mark 单击
-(void)SingleClickTap:(UITapGestureRecognizer *)tap{
    self.Single();
}

#pragma mark 双击
-(void)DoubleClickTap:(UITapGestureRecognizer *)tap{
    if (self.zoomScale ==1) {
        float newScale = [self zoomScale] *2;
        CGRect zoomRect = [self zoomRectForScal:newScale withCenter:self.center andScrollView:self];
        [self zoomToRect:zoomRect animated:YES];
    }else{
        float newScale = [self zoomScale]/2;
        CGRect zoomRect = [self zoomRectForScal:newScale withCenter:self.center andScrollView:self];
        [self zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark 放大缩小方法
-(CGRect)zoomRectForScal:(CGFloat)newscale withCenter:(CGPoint)center andScrollView:(UIScrollView *)scrollView{
    
    CGRect zoomRect = CGRectZero;
    zoomRect.size.height = scrollView.frame.size.height/newscale;
    zoomRect.size.width = scrollView.frame.size.width/newscale;
    zoomRect.origin.x = center.x - (zoomRect.size.width/2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height/2.0);
    
    return zoomRect;
}

#pragma mark 图片放大缩小
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _PicView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    if (_PicView.frame.size.width<=scrollView.frame.size.width) {
        centerPoint.x = scrollView.frame.size.width/2;
    }
    
    if (_PicView.frame.size.height<=scrollView.frame.size.height) {
        centerPoint.y = scrollView.frame.size.height/2;
    }
    _PicView.center = centerPoint;
    
}

-(UIImageView *)PicView{
    if (!_PicView) {
        _PicView = [[UIImageView alloc]initWithFrame:self.bounds];
        _PicView.userInteractionEnabled = YES;
    }
    return _PicView;
}
@end

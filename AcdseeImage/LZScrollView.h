//
//  LZScrollView.h
//  AcdseeImage
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZScrollView : UIView

#pragma mark 初始化
-(instancetype)initWithImgArray:(NSArray *)imgArray;
#pragma mark 显示LZScrollView
-(void)show;

@end

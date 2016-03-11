//
//  ImgScrllView.h
//  AcdseeImage
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SingleClick)(void);

@interface ImgScrllView : UIScrollView

@property (nonatomic,copy) SingleClick Single;

-(void)setImgViewurlStr:(NSString *)urlStr;
@end

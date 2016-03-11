//
//  ViewController.m
//  AcdseeImage
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "ViewController.h"
#import "LZScrollView.h"
@interface ViewController ()


@property(nonatomic,strong)NSArray *picArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.picArray = [NSArray arrayWithObjects:@"http://h.hiphotos.baidu.com/image/pic/item/8601a18b87d6277f39626cd22c381f30e824fcec.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/2cf5e0fe9925bc3177425f725adf8db1cb137038.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/9a504fc2d5628535fc058dcb94ef76c6a6ef6376.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/4d086e061d950a7bb013102e0ed162d9f2d3c932.jpg",nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    LZScrollView *lzScrollView = [[LZScrollView alloc]initWithImgArray:self.picArray];
    [lzScrollView show];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

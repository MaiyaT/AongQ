//
//  ImageWebViewController.m
//  QNote
//
//  Created by 林宁宁 on 2017/3/5.
//  Copyright © 2017年 林宁宁. All rights reserved.
//

#import "ImageWebViewController.h"
#import <YYKit/UIImageView+YYWebImage.h>

@interface ImageWebViewController ()

@property (retain, nonatomic) UIImageView * imageV;

@end

@implementation ImageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refreshImage)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    self.imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageV.autoresizingMask = 0xff;
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageV];
    
    [self refreshImage];
}

- (void)refreshImage
{
    /**
    YYWebImageManager 中的 YYWebImageOption 图片处理类型
     
     状态栏显示图片加载提示
     YYWebImageOptionShowNetworkActivity = 1 << 0,
     
     图片加载的进度 从上往下一点一点的加载显示出来
     YYWebImageOptionProgressive = 1 << 1,
     
     图片加载进度 模糊效果
     YYWebImageOptionProgressiveBlur = 1 << 2,
     
     使用NSURLCache中的缓存
     YYWebImageOptionUseNSURLCache = 1 << 3,
     
     允许后台加载图片
     YYWebImageOptionAllowBackgroundTask = 1 << 5,
     
     处理缓存.
     YYWebImageOptionHandleCookies = 1 << 6,
     
     刷新图片缓存
     YYWebImageOptionRefreshImageCache = 1 << 7,
     
     不加载本地磁盘的缓存
     YYWebImageOptionIgnoreDiskCache = 1 << 8,
     
     忽略预设图片
     YYWebImageOptionIgnorePlaceHolder = 1 << 9,
     
     忽略图片编码
     YYWebImageOptionIgnoreImageDecoding = 1 << 10,
     
     忽略有动画的图片
     YYWebImageOptionIgnoreAnimatedImage = 1 << 11,
     
     加完完图片之后动画渐变显示
    YYWebImageOptionSetImageWithFadeAnimation = 1 << 12,
     
     清除图片并设置
     YYWebImageOptionAvoidSetImage = 1 << 13,
     
     忽略无效链接
     YYWebImageOptionIgnoreFailedURL = 1 << 14,
     
     */
    
    [self.imageV setImageWithURL:[NSURL URLWithString:@"http://img5q.duitang.com/uploads/item/201506/23/20150623203928_HzBWU.jpeg"]
                     placeholder:[UIImage imageNamed:@"profile-image-placeholder"] options:
     
     YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache | YYWebImageOptionProgressiveBlur
     
                         manager:nil progress:nil transform:nil completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

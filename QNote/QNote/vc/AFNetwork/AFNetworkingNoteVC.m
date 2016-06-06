//
//  AFNetworkingNoteVC.m
//  QNote
//
//  Created by 林宁宁 on 16/6/5.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AFNetworkingNoteVC.h"
#import <AFNetworking.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface AFNetworkingNoteVC ()

@end

@implementation AFNetworkingNoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 在头文件 AFNetworking 中 有三个主要文件
    // AFURLRequestSerialization 请求的序列
    // AFURLResponseSerialization 回调的序列
    // AFSecurityPolicy.h 安全协议
    
    
    // AFPercentEscapedStringFromString 方法  就是urlencode
    // 参考... http://www.cnblogs.com/Mike-zh/p/5152073.html
    NSString * queryWord = @"汉字&ssss";
    
    NSString * escapedString1 = [queryWord stringByAddingPercentEscapesUsingEncoding:4];
    NSString * escapedString2 = AFPercentEscapedStringFromString(queryWord);
    
    NSString * urlStr1 = [NSString stringWithFormat:@"https://www.baidu.com/s?ie=UTF-8&wd=%@",escapedString1];
    NSString * urlStr2 = [NSString stringWithFormat:@"https://www.baidu.com/s?ie=UTF-8&wd=%@",escapedString2];
    
    NSLog(@"urlStr1 == %@ \n urlStr2 == %@",urlStr1,urlStr2);
    // urlStr1 == https://www.baidu.com/s?ie=UTF-8&wd=%E6%B1%89%E5%AD%97&ssss
    // urlStr2 == https://www.baidu.com/s?ie=UTF-8&wd=%E6%B1%89%E5%AD%97%26ssss
    
    
    
    
    
    
    // AFQueryStringFromParameters   将字典数据拼接成url的参数
    
    NSString * str = AFQueryStringFromParameters(@{@"name":@"000",@"phone":@"001"});
    NSLog(@"####%@",str);
    //name=000&phone=001
    
    
    /**
     *  AFURLRequestSerialization 协议

     中只有一个返回请求 NSURLRequest
     
     */
    
    
    
    /**
     *  参考
     
     https://github.com/AFNetworking/AFNetworking
     
     */
    
    
    
    // #############  AFURLSessionManager
   
    
    {
        // 文件下载
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL * url = [NSURL URLWithString:@"http://bmob-cdn-250.b0.upaiyun.com/2016/04/20/2b4567fca78246e3a99513f80eca14fd.mp4"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        __unused NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            NSLog(@"%f__%f",(float)downloadProgress.totalUnitCount,(float)downloadProgress.completedUnitCount);
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            //存储的目录
            
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            NSLog(@"File downloaded to: %@", filePath);
            
        }];
        
        [downloadTask resume];
    }
    
    

    {
        // 文件上传
        
        AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURL * urlUpload = [NSURL URLWithString:@"http://example.com/upload"];
        NSURLRequest * requestUpload = [NSURLRequest requestWithURL:urlUpload];
        
        NSURL * filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
        NSURLSessionUploadTask * uploadTask =  [manager uploadTaskWithRequest:requestUpload fromFile:filePath progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"Success: %@ %@", response, responseObject);
            }
            
        }];
        
        [uploadTask resume];
    }
    
    
    {
        // NSMutableURLRequest 多数据格式请求
        
        AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSMutableURLRequest * multiRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
             [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
            
        } error:nil];
        
        
        NSURLSessionUploadTask * multiUploadTask = [manager uploadTaskWithStreamedRequest:multiRequest progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"%f",uploadProgress.fractionCompleted);
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
            }
        }];
        
        [multiUploadTask resume];
    }
    
    
    
    {
        // Data Task
        AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURL * url = [NSURL URLWithString:@"http://httpbin.org/get"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
           
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
            }
            
        }];
        
        [dataTask resume];
    }
    
    
    {
    
        NSString *URLString = @"http://example.com";
        NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
        
        
        
        [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
        
        //GET http://example.com?foo=bar&baz[]=1&baz[]=2&baz[]=3
        
        
        
        
        [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
        
        /**
         POST http://example.com/
         Content-Type: application/x-www-form-urlencoded
         
         foo=bar&baz[]=1&baz[]=2&baz[]=3
         */
        
        
        
        
        [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
        
        /**
         POST http://example.com/
         Content-Type: application/json
         
         {"foo": "bar", "baz": [1,2,3]}
         */
    }
    
    
    
    {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
    
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
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

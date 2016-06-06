//
//  YHHttps.m
//  QNote
//
//  Created by 林宁宁 on 16/6/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "YHHttps.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>

static NSInteger const kTimeOutInterval = 20;

@implementation YHHttps

+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}

+(void)httpsGetWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock
{
    [self httpsGetWithURL:url andParameterDic:parameterDic andResponseBlock:responseBlock withIsJson:YES];
}

+(void)httpsGetWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock
{
    [self httpsGetWithURL:url andParameterDic:parameterDic andResponseBlock:responseBlock withIsJson:NO];
}


+ (void)httpsGetWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock withIsJson:(BOOL)isJson
{
    // get请求也可以直接将参数放在字典里，AFN会自己讲参数拼接在url的后面，不需要自己凭借
    
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    
    if(isJson)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    [manager GET:url parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功
        if(responseObject)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            RequestResultObj * obj = [RequestResultObj new];
            obj.data = dict;
            obj.url = task.currentRequest.URL.absoluteString;
            obj.jsonStr = [[NSString alloc] initWithData:responseObject encoding:4];
            
            if(responseBlock)
            {
                responseBlock(obj);
            }
        }
        else
        {
            if(responseBlock)
            {
                responseBlock(nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if(responseBlock)
        {
            responseBlock(nil);
        }
    }];
}

+ (void)httpsPostWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock
{
    [self httpsPostWithURL:url andParameterDic:parameterDic andResponseBlock:responseBlock withIsJson:NO];
}


+ (void)httpsPostWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock
{
    [self httpsPostWithURL:url andParameterDic:parameterDic andResponseBlock:responseBlock withIsJson:YES];
}


+ (void)httpsPostWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj *))responseBlock withIsJson:(BOOL)isJson
{
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    
    if(isJson)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    [manager POST:url parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功
        if(responseObject)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            RequestResultObj * obj = [RequestResultObj new];
            obj.data = dict;
            obj.url = task.currentRequest.URL.absoluteString;
            obj.jsonStr = [[NSString alloc] initWithData:responseObject encoding:4];
            
            if(responseBlock)
            {
                responseBlock(obj);
            }
        }
        else
        {
            if(responseBlock)
            {
                responseBlock(nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        if(responseBlock)
        {
            responseBlock(nil);
        }
    }];
    
}

+ (void)httpsPostWithURL:(NSString *)url andData:(NSData *)postData andResponseBlock:(void (^)(RequestResultObj *))responseBlock
{
    NSParameterAssert(postData);
    
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:@{} error:&serializationError];
    [request setHTTPBody:postData];
    
    if (serializationError) {
        if (responseBlock) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(manager.completionQueue ?: dispatch_get_main_queue(), ^{
                responseBlock(nil);
            });
#pragma clang diagnostic pop
        }
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [manager dataTaskWithRequest:request
                             uploadProgress:nil
                           downloadProgress:nil
                          completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                              
                              if (responseObject)
                              {
                                  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                  
                                  RequestResultObj * obj = [RequestResultObj new];
                                  obj.data = dict;
                                  obj.url = response.URL.absoluteString;
                                  obj.jsonStr = [[NSString alloc] initWithData:responseObject encoding:4];
                                  
                                  
                                  if (responseBlock)
                                  {
                                      responseBlock(obj);
                                  }
                              }
                              else
                              {
                                  if (responseBlock) {
                                      responseBlock(nil);
                                  }
                              }
                          }];
    
    [dataTask resume];
}




+ (void)httpsDownLoadWithUrl:(NSString *)urlString andProgressBlock:(void (^)(float))progressBlock andSavePathBlock:(NSURL *(^)(NSURL *, NSURLResponse *))savePathBlock andFinishBlock:(void (^)())finishBlock
{
    //    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //    return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        if(progressBlock)
        {
            progressBlock(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
        
    } destination:savePathBlock completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        if(finishBlock)
        {
            finishBlock();
        }
    }];
    // 5.启动下载任务
    [task resume];
}


+(void)httpsUploadWithUrl:(NSString *)urlString andParemeter:(NSDictionary *)parmeter andUploadImage:(UIImage *)image andProgressBlock:(void (^)(float))progressBlock andFinishBlock:(void (^)(BOOL))finishBlock
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    
    [manager POST:urlString parameters:parmeter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(image);
        // 拼接数据到请求题中
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        if(progressBlock)
        {
            progressBlock(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        if(finishBlock)
        {
            finishBlock(YES);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
        if(finishBlock)
        {
            finishBlock(NO);
        }
    }];
}



- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}


@end





@implementation RequestResultObj



@end

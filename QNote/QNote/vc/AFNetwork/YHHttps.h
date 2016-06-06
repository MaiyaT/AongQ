//
//  YHHttps.h
//  QNote
//
//  Created by 林宁宁 on 16/6/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RequestResultObj;

@interface YHHttps : NSObject

/** get 上传格式普通*/
+ (void)httpsGetWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void(^)(RequestResultObj * resultObj))responseBlock;

/** get 上传格式json*/
+ (void)httpsGetWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void(^)(RequestResultObj * resultObj))responseBlock;


/** post 上传格式普通*/
+ (void)httpsPostWithURL:(NSString *)url andParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj * resultObj))responseBlock;

/** post 上传格式json*/
+ (void)httpsPostWithURL:(NSString *)url andJSonParameterDic:(NSDictionary *)parameterDic andResponseBlock:(void (^)(RequestResultObj * resultObj))responseBlock;

/** post 上传格式data*/
+ (void)httpsPostWithURL:(NSString *)url andData:(NSData *)postData andResponseBlock:(void (^)(RequestResultObj * resultObj))responseBlock;

/** 文件下载*/
+ (void)httpsDownLoadWithUrl:(NSString *)urlString andProgressBlock:(void(^)(float progress))progressBlock andSavePathBlock:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))savePathBlock andFinishBlock:(void(^)())finishBlock;

/** 文件上传*/
+ (void)httpsUploadWithUrl:(NSString *)urlString andParemeter:(NSDictionary *)parmeter andUploadImage:(UIImage *)image andProgressBlock:(void(^)(float progress))progressBlock  andFinishBlock:(void(^)(BOOL isSuccess))finishBlock;

@end

@interface RequestResultObj : NSObject

@property (retain, nonatomic) id data;

@property (copy, nonatomic) NSString * url;

@property (copy, nonatomic) NSString * jsonStr;

@end


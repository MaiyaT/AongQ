//
//  AFAppDotNetAPIClient.h
//  QNote
//
//  Created by 林宁宁 on 16/6/5.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

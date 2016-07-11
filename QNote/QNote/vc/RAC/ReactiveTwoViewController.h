//
//  ReactiveTwoViewController.h
//  QNote
//
//  Created by 林宁宁 on 16/7/7.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BaseViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ReactiveTwoViewController : BaseViewController

@property (retain, nonatomic) RACSubject * passSignalDelegate;

@end

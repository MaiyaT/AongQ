//
//  ReactiveCocoaExample.m
//  QNote
//
//  Created by 林宁宁 on 16/7/5.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "ReactiveCocoaExample.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SignInService.h"
#import "NSObject+Caculator.h"
#import "ReactiveTwoViewController.h"

/**
 
 参考：
 http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1
 
 响应式编程
 函数响应式式编程FRP  Function Reactive Programming
 
 */

@interface ReactiveCocoaExample()

@property (retain, nonatomic) RACCommand * command;

@end


@implementation ReactiveCocoaExample

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITextField * textFName = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, CGRectGetWidth(self.view.frame)-100, 40)];
    
    textFName.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    textFName.placeholder = @"请输入用户名:";
    
    [self.view addSubview:textFName];
    
    
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, CGRectGetWidth(self.view.frame)-100, 40)];
    
    password.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    password.placeholder = @"请输入密码:";
    password.secureTextEntry = YES;
    [self.view addSubview:password];
    
    
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    loginBtn.frame = CGRectMake(50, 220, CGRectGetWidth(self.view.frame)-100, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:loginBtn];
    
//    [[[textFName.rac_textSignal map:^id(NSString*text) {
//
//        return @(text.length);
//
//    }] filter:^BOOL(NSNumber*length) {
//
//        return[length integerValue] > 3;
//
//    }] subscribeNext:^(id x) {
//
//        NSLog(@"%@", x);
//        
//    }];

    
    
    
    
//    [[textFName.rac_textSignal filter:^BOOL(id value) {
//      
//        return ((NSString *)value).length > 5;
//        
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
    
    
//    RACSignal * validAbleNameSignal = [textFName.rac_textSignal map:^id(NSString * value) {
//       
//        return @(value.length > 5);
//        
//    }];
//    
//    [[validAbleNameSignal map:^id(NSNumber * value) {
//       
//        return [value boolValue]?[UIColor greenColor]:[UIColor orangeColor];
//        
//    }] subscribeNext:^(UIColor * color) {
//        
//        textFName.backgroundColor = color;
//        
//    }];
    
    
    
    
//    [[textFName.rac_textSignal map:^id(NSString * value) {
//        
//        return (value.length > 5)?[UIColor greenColor]:[UIColor orangeColor];
//        
//    }] subscribeNext:^(UIColor * color) {
//        
//        textFName.backgroundColor = color;
//        
//    }];
    

    
//    //RAC的宏 直接把信号输出的信息用到对象的属性上，第一个属性值的对象，第二个是属性名
//    RAC(textFName,backgroundColor) = [textFName.rac_textSignal map:^id(NSString * value) {
//        
//        return (value.length > 3)?[UIColor redColor]:[UIColor blueColor];
//        
//    }];



    
//    RACSignal * validableName = [textFName.rac_textSignal map:^id(NSString * value) {
//        return @(value.length > 3);
//    }];
//    
//    
//    RACSignal * validablePsd = [password.rac_textSignal map:^id(NSString * value) {
//        return @(value.length > 5);
//    }];
//    
//    
//    RACSignal * signupSignal = [RACSignal combineLatest:@[validableName,validablePsd] reduce:^id(NSNumber * usernameValid, NSNumber * passwordValid){
//       
//        return @([usernameValid boolValue]&&[passwordValid boolValue]);
//        
//    }];
//    
//    [signupSignal subscribeNext:^(NSNumber * x) {
//        
//        loginBtn.backgroundColor = [x boolValue]?[UIColor blueColor]:[UIColor grayColor];
//        
//        loginBtn.enabled = [x boolValue];
//        
//    }];
//    
//    //flatten 从内部信号发送事件到外部信号
//    [[[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^id(id value) {
//        
//        RACSignal * signInSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            [SignInService signInWithUsername:textFName.text password:password.text complete:^(BOOL isSuccess) {
//                
//                [subscriber sendNext:@(isSuccess)];
//                
//                [subscriber sendCompleted];
//                
//            }];
//            
//            return nil;
//        }];
//
//        return signInSignal;
//        
//    }] subscribeNext:^(id x) {
//        
//        NSLog(@"Sign in result: %@", x);
//        
//    }];
    
    
    
//    @weakify(self,textFName,password);
//    RACSignal * backgroundColorSignal = [textFName.rac_textSignal map:^id(NSString * value) {
//        return (value.length > 3)?[UIColor redColor]:[UIColor orangeColor];
//    }];
//    
//    RACDisposable * subscription = [backgroundColorSignal subscribeNext:^(UIColor * x) {
//       
//        @strongify(self);
//        
//        textFName.backgroundColor = x;
//    }];
//    
//    [subscription dispose];
    
    
    
//    {
//    /**
//     参考：
//     http://www.jianshu.com/p/87ef6720a096
//     */
//    
//    
//    /**
//     *  编程的思想
//     *
//        1.面向过程
//        2.面向对象
//        3.链式编程
//        4.响应式编程
//        5.函数式编程
//     */
//    
//    
//    //链式编码
//    
//    int result = [NSObject makeCaculator:^(CaculatorMaker *make) {
//       
//        //(4*4-1)/3
//        make.add(4).muilt(4).sub(1).divide(3);
//    }];
//    
//    NSLog(@"result == %d",result);
//    
//    
//    
//    CaculatorMaker * maker = [CaculatorMaker new];
//    
//    BOOL isEqule = [[[maker caculatorAdd:^int(int result) {
//        
//        result += 2;
//        result *= 5;
//        return result;
//        
//    }] equle:^BOOL(int result) {
//       
//        return result == 10;
//        
//    }] isEqual];
//    
//    NSLog(@"isEqule %d", isEqule);
//    }
    
    
    
    {
        /**

         参考：
         http://www.jianshu.com/p/87ef6720a096
         
         ReactiveCocoa 的编程思想
         
         结合了几种编程风格
         函数式编程： Foundation Programming
         响应式编程： Reactive Programming
         
         所有ReactiveCocoa被描述成 Foundation Reactive Programming 函数响应式编程（FRP）框架
         
         不需要考虑调用的顺序，直接考虑结果，把每一次操作都写成一些列嵌套的方法中，代码高聚合，方便管理。
         
         
         ReactiveCocoa的核心类是 RACSignal信号类。
         
         RACSignal：信号类，一般表示将来有数据传递，只要只有有数据改变的时候，信号内部就会接收到数据，就会马上发出数据。
         
         * 信号类本身不具备发送信号的能力，只有内部数据发生变化的时候才会发送，交给内部的一个订阅者去发出...
         
         *  默认一个信号是冷信号，值改变了也不会触发消息。只有订阅了这个信号,这个信号才会变成热型号，值改变了才会触发消息。
         
         *  订阅信号：调用信号RACSignal的subscriptionNext就能订阅
         
         */
        
        
        /**

         *  RACSignal使用
         
         *  1.创建信号：createSignal
         
         *  2.订阅信号，才会激活型号：subscribeNext：
         
         *  3.发送信号：sendNext
         
         
         
         RACSignal底层实现
         
         *  1.创建信号， 首先把didsubscribe保存到信号中,还不会触发
            2.当信号被订阅，调用subscribeNext
            2.1 subscribeNext内部会滴啊用siganl的didsubscribe
            2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到这个订阅者subscriber中
            3.siganl的didsubscriber中调用 senderNext发送信号
             sendNext底层其实就是执行subscriber的NextBlock

         */
        
        
        //创建信号
        RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            //block回调 每当有订阅者订阅信号 就会调用
            
            //发送信号
            [subscriber sendNext:@1];
            
            //如果不需要发送数据 取消订阅，内部会自动调用 RACDispose disposeable 取消订阅
            [subscriber sendCompleted];
            
            
            return [RACDisposable disposableWithBlock:^{
               
                //调用了这个block：当信号发送完成或者发送错误，就会执行这个block，取消订阅\
                执行完block后，当前信号就不在被订阅
                
                NSLog(@"信号被销毁 不再订阅");
                
            }];
            
        }];
        
        //订阅信号 才会激活信号
        [signal subscribeNext:^(id x) {
           
            //block执行的时候 每当信号发出数据就会执行
            NSLog(@"接收到的数据");
            
        }];
        
    }
    
    
    {
        /**
         
         RACSubscriber:订阅者，用于发送信号，他是一个协议不是一个类。只要遵守这个协议，并且实现这个方法才能成为订阅者，通过crete创建的信号，都是一个订阅者，帮助他发送数据。。
         
         RACDisposeable：用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候出发。如果不想监听某个信号时，可以通过这样子取消订阅。
         
         RACSubject：信号提供者，自己可以充当信号，又能发送信号。通常用来替代代理，有了他，就不必要定义代理了。
         
         RACReplaySubject：重复提供信号类，RACSubject的子类。RACReplaySubject是可以先发送信号，在订阅信号，RACSubject就不可以。
         
         
         RACSubject使用步骤
         1.创建信号  RACSubject subject。
         2.订阅信号  subscribeNext：
         3.发送信号  sendNext：
         
         RACSubject的底层实现跟RACSignal不一样
         1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的Nextblock已经赋值了
         2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock
         
         
         RACReplaySubject 使用步骤：
         1.创建信号 RACReplaySubject subject跟RACSignal不一样
         2.可以先订阅信号，再发送信号
         2.1 订阅信号：subscribeNext：
         2.2 发送信号：sendNext：
         
         RACReplaySubject
         如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
         就可以先保存值在订阅值
         可先发送再订阅
         
         */
        
        
        RACSubject * subject = [RACSubject subject];
        
        
        [subject subscribeNext:^(id x) {
            NSLog(@"subject_第一个订阅者%@",x);
        }];
        
        [subject subscribeNext:^(id x) {
            NSLog(@"subject_第二个订阅者%@",x);
        }];
        
        [subject sendNext:@"1"];
        
        
        
        
        RACReplaySubject * replaySubject = [RACReplaySubject subject];
        
        [replaySubject sendNext:@1];
        [replaySubject sendNext:@2];
        
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"第一个订阅者收到的数据%@",x);
        }];
        
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"第二个订阅者收到的数据%@",x);
        }];
    }
    
    
    
    {
//        /**
//         
//         RACSubject替代代理
//         
//         需求：
//         1.给当前控制器添加一个按钮，modal到另外一个控制器界面
//         2.另外一个控制器view中有一个按钮，点击按钮，通知当前控制器
//         
//         */
//        loginBtn.backgroundColor = [UIColor grayColor];
//        
//        [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//           
//            ReactiveTwoViewController * vc = [[ReactiveTwoViewController alloc] init];
//            
//            vc.passSignalDelegate = [RACSubject subject];
//            
//            [vc.passSignalDelegate subscribeNext:^(id x) {
//               
//                [[[UIAlertView alloc] initWithTitle:x message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//                
//            }];
//            
//            [self presentViewController:vc animated:YES completion:nil];
//            
//        }];
    }
    
    
    {
        /**
         
         RACTuple:元组类， 类似NSArray，用来包装值
         
         RACSequence：RAC中集合类。用来替代NSArray，NSDictionary，可以使用它来快速遍历数组和字典。。。
         
         */
        
        NSArray * numbers = @[@1,@2,@3,@4,@5];
        
        /**
            1、把数组转换成集合RACSequence number.rac_sequence
            2. 把集合Sequence转换成signal信号类， 
            3. 信号订阅 激活信号 自动把集合中的所有值遍历出来
         */
        [numbers.rac_sequence.signal subscribeNext:^(id x) {
           
            NSLog(@"rac_sequence %@",x);
            
        }];
        
        
        
        //遍历字典 键值会包装成RACTuple元组对象
        NSDictionary * dict = @{@"name":@"sss",@"tag":@1000};
        
        [dict.rac_sequence.signal subscribeNext:^(RACTuple * x) {
           
            RACTupleUnpack(NSString * key, NSString * value) = x;
            
            NSLog(@"%@  %@",key,value);
            
        }];
        
        
        
        /**
         
         RACCommand 处理事件类，可以把事件如果处理，事件如果处理，事件中数据如果传递，包装到这个类中。他可以很方便的监控事件的执行过程
         
         // 一、RACCommand使用步骤:
         // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
         // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
         // 3.执行命令 - (RACSignal *)execute:(id)input
         
         // 二、RACCommand使用注意:
         // 1.signalBlock必须要返回一个信号，不能传nil.
         // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
         // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
         // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
         
         // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
         // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
         // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
         
         // 四、如何拿到RACCommand中返回信号发出的数据。
         // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
         // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
         
         // 五、监听当前命令是否正在执行executing
         
         // 六、使用场景,监听按钮点击，网络请求
         
         */
        
        
//        RACCommand  * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//           
//            //创建空信号 必须返回信号
//            // return [RACSignal empty];
//            
//            
//            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//               
//                [subscriber sendNext:@"请求数据123123"];
//                
//                //数据传递完成 调用这个 结束订阅
//                [subscriber sendCompleted];
//                
//                return nil;
//            }];
//        }];
//        
//        //强引用 不要被销毁 否则接收不到数据
//        _command = command;
//        
//        
//        [command.executionSignals subscribeNext:^(id x) {
//           
//            [x subscribeNext:^(id x) {
//               
//                NSLog(@"%@",x);
//            }];
//            
//        }];
//        
//        
//        [command.executionSignals.switchToLatest subscribeNext:^(id x) {
//            NSLog(@"%@",x);
//        }];
//        
//        //.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
//        [[command.executing skip:1] subscribeNext:^(id x) {
//           
//            if([x boolValue])
//            {
//                NSLog(@"正在执行");
//            }
//            else
//            {
//                NSLog(@"执行完成");
//            }
//        }];
//        
//        [self.command execute:@1];
        
    }
    
    
    {
        /**
         
         RACMulticastConnection 用于一个信号 被多次订阅的时候保证创建信号时，避免多次调用创建的信号中的block，照成副作用，可以使用这个类处理
         
         
         
         */
        
        // RACMulticastConnection使用步骤:
        // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
        // 2.创建连接 RACMulticastConnection *connect = [signal publish];
        // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
        // 4.连接 [connect connect]
        
        // RACMulticastConnection底层原理:
        // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
        // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
        // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
        // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
        // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
        // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
        // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
        
        
        // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
        // 解决：使用RACMulticastConnection就能解决.
        
//        // 1.创建请求信号
//        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            
//            NSLog(@"发送请求");
//            
//            return nil;
//        }];
//        // 2.订阅信号
//        [signal subscribeNext:^(id x) {
//            
//            NSLog(@"接收数据");
//            
//        }];
//        // 2.订阅信号
//        [signal subscribeNext:^(id x) {
//            
//            NSLog(@"接收数据");
//            
//        }];
//        
//        // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
//        
//        
//        // RACMulticastConnection:解决重复请求问题
//        // 1.创建信号
//        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            
//            NSLog(@"发送请求");
//            [subscriber sendNext:@1];
//            
//            return nil;
//        }];
//        
//        // 2.创建连接
//        RACMulticastConnection *connect = [signal publish];
//        
//        // 3.订阅信号，
//        // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
//        [connect.signal subscribeNext:^(id x) {
//            
//            NSLog(@"订阅者一信号");
//            
//        }];
//        
//        [connect.signal subscribeNext:^(id x) {
//            
//            NSLog(@"订阅者二信号");
//            
//        }];
//        
//        // 4.连接,激活信号
//        [connect connect];
        
    }
    
    
    //例子
    {
        /**
         代替代理
         
         自定义redView,监听红色view的按钮点击
         
         rac_signalForSelector调用某个对象的方法的信息转换成信号，调用这个方法，就会发送信号
        
         
         // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
         [[redV rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
         NSLog(@"点击红色按钮");
         }];
         
         // 2.KVO
         // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
         // observer:可以传入nil
         [[redV rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
         
         NSLog(@"%@",x);
         
         }];
         
         // 3.监听事件
         // 把按钮点击事件转换为信号，点击按钮，就会发送信号
         [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         
         NSLog(@"按钮被点击了");
         }];
         
         // 4.代替通知
         // 把监听到的通知转换信号
         [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
         NSLog(@"键盘弹出");
         }];
         
         // 5.监听文本框的文字改变
         [_textField.rac_textSignal subscribeNext:^(id x) {
         
         NSLog(@"文字改变了%@",x);
         }];
         
         // 6.处理多个请求，都返回结果的时候，统一做处理.
         RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         
         // 发送请求1
         [subscriber sendNext:@"发送请求1"];
         return nil;
         }];
         
         RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         // 发送请求2
         [subscriber sendNext:@"发送请求2"];
         return nil;
         }];
         
         // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
         [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];

         
         
         // 更新UI
         - (void)updateUIWithR1:(id)data r2:(id)data1
         {
         NSLog(@"更新UI%@  %@",data,data1);
         }
         
         */
        
        
        
    }
    
    
//    @weakify(self);
//    
//    [[loginBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
//       
//        @strongify(self);
//        
//        [self loginEvent:nil];
//        
//    }];
    
}


- (void)tapEvent:(id)sender
{
    NSLog(@"tap event");
}

- (void)loginEvent:(UIButton *)sender
{
    NSLog(@"login....");
}




















@end

//
//  YYKitModelVController.m
//  QNote
//
//  Created by 林宁宁 on 16/7/1.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "YYKitModelVController.h"
#import <YYKit.h>


////////////////////////////////////////////////////////////////////////////////
#pragma mark - BOOk

@interface YHBook : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) uint64_t pages;
@property (nonatomic, strong) NSDate *publishDate;

@end

@implementation YHBook

@end


static void SimpleObjectBook()
{
    YHBook * book = [YHBook modelWithJSON:@"     \
                     {                                           \
                     \"name\": \"Harry Potter\",              \
                     \"pages\": 512,                          \
                     \"publishDate\": \"2010-01-01\"          \
                     }"];
    
    NSLog(@"name = %@__date = %@",book.name,book.publishDate);
    
    NSLog(@"BOOk : %@",[book modelToJSONString]);
}

////////////////////////////////////////////////////////////////////////////////

#pragma mark - model-inner-model nest object

@interface YYUser : NSObject
@property (nonatomic, assign) uint64_t uid;
@property (nonatomic, copy) NSString *name;
@end

@implementation YYUser
@end

@interface YYRepo : NSObject
@property (nonatomic, assign) uint64_t rid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) YYUser *owner;
@end

@implementation YYRepo
@end

static void NestObjectRepo()
{
    YYRepo * repo = [YYRepo modelWithJSON:@"         \
                     {                                               \
                     \"rid\": 123456789,                         \
                     \"name\": \"YYKit\",                        \
                     \"createTime\" : \"2011-06-09T06:24:26Z\",  \
                     \"owner\": {                                \
                        \"uid\" : 989898,                       \
                        \"name\" : \"ibireme\"                  \
                     } \
                     }"];
    
    NSLog(@"owner name %@",repo.owner.name);
    
    NSLog(@"Repo: %@", [repo modelToJSONString]);
}


////////////////////////////////////////////////////////////////////////////////

@interface YYPhoto : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;
@end

@implementation YYPhoto
@end

@interface YYAlbum : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *photos; // Array<YYPhoto>
@property (nonatomic, strong) NSDictionary *likedUsers; // Key:name(NSString) Value:user(YYUser)
@property (nonatomic, strong) NSSet *likedUserIds; // Set<NSNumber>
@end

@implementation YYAlbum

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"photos":YYPhoto.class,
             @"likedUsers":[YYUser class],
             @"likedUserIds":NSNumber.class};
}


@end


static void ContainerObject()
{
    YYAlbum *album = [YYAlbum modelWithJSON:@"          \
                      {                                                   \
                      \"name\" : \"Happy Birthday\",                      \
                      \"photos\" : [                                      \
                      {                                               \
                      \"url\":\"http://example.com/1.png\",       \
                      \"desc\":\"Happy~\"                         \
                      },                                              \
                      {                                               \
                      \"url\":\"http://example.com/2.png\",       \
                      \"desc\":\"Yeah!\"                          \
                      }                                               \
                      ],                                                  \
                      \"likedUsers\" : {                                  \
                      \"Jony\" : {\"uid\":10001,\"name\":\"Jony\"},   \
                      \"Anna\" : {\"uid\":10002,\"name\":\"Anna\"}    \
                      },                                                  \
                      \"likedUserIds\" : [10001,10002]                    \
                      }"];
    NSString *albumJSON = [album modelToJSONString];
    NSLog(@"Album: %@", albumJSON);
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark Custom Mapper Example

@interface YYMessage : NSObject
@property (nonatomic, assign) uint64_t messageId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *time;
@end

@implementation YYMessage
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"messageId":@"i",
             @"content":@"c",
             @"time":@"t"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    uint64_t timestamp = [dic unsignedLongLongValueForKey:@"t" default:0];
    self.time = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    
    return YES;
}
- (void)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"t"] = @([self.time timeIntervalSince1970] * 1000).description;
}
@end

static void CustomMapperExample() {
    YYMessage *message = [YYMessage modelWithJSON:@"{\"i\":\"2000000001\",\"c\":\"Hello\",\"t\":\"1437237598000\"}"];
    NSString *messageJSON = [message modelToJSONString];
    NSLog(@"Book: %@", messageJSON);
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark Coding/Copying/hash/equal Example

@interface YYShadow :NSObject <NSCoding, NSCopying>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIColor *color;
@end

@implementation YYShadow
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { return [self modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }
- (NSUInteger)hash { return [self modelHash]; }
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; }
@end

static void CodingCopyingHashEqualExample() {
    YYShadow *shadow = [YYShadow new];
    shadow.name = @"Test";
    shadow.size = CGSizeMake(10, 0);
    shadow.color = [UIColor blueColor];
    
    YYShadow *shadow2 = [shadow deepCopy]; // Archive and Unachive
    //    shadow2.name = @"TT";
    BOOL equal = [shadow isEqual:shadow2];
    NSLog(@"shadow equals: %@",equal ? @"YES" : @"NO");
}


////////////////////////////////////////////////////////////////////////////////





@interface YYKitModelVController ()

@end

@implementation YYKitModelVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SimpleObjectBook();
    
    NestObjectRepo();
    
    ContainerObject();
    
    CustomMapperExample();
    
    CodingCopyingHashEqualExample() ;
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





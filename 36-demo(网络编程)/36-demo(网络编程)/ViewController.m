//
//  ViewController.m
//  36-demo(网络编程)
//
//  Created by Agan on 16/9/1.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
//天气
#define kWeatherInfoAPI @"http://weather.com.cn/data/sk/101010100.html"
//登录
#define api_login_validate @"https://www.oschina.net/action/api/login_validate"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *InfoLab;
- (IBAction)senderRequest:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
   
}

- (IBAction)senderRequest:(id)sender {
    [self loadWeatherDate];
    [self loadJsonWeatherDate];
    [self montierNetWork];
}

-(void)loadWeatherDate{
    
//    NSURL *url=[NSURL URLWithString:kWeatherInfoAPI];
    
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
//    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        JSONDecoder *jd=[[JSONDecoder alloc] init];
//        
//        NSDictionary *weatherInfo=[jd objectWithData:operation.responseData];
//        
//        NSDictionary *weatherValue=[weatherInfo objectForKey:@"weatherinfo"];
    
//        NSString *city=[weatherValue objectForKey:@"city"];
    
//        NSString *temp=[weatherValue objectForKey:@"temp"];
    
//        self.InfoLab.text=[NSString stringWithFormat:@"%@:%@摄氏度",city,temp];
//          NSLog(@"有网");
    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"没有网");
//    }];
//    [operation start];
    
    NSURL *url=[NSURL URLWithString:kWeatherInfoAPI];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *oprea=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    [oprea setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        JSONDecoder *jd=[[JSONDecoder alloc] init];
        NSDictionary *weatherInfo=[jd objectWithData:operation.responseData];
        NSDictionary *weatherValue=[weatherInfo objectForKey:@"weatherinfo"];
        NSString *city=[weatherValue objectForKey:@"city"];
        NSString *temp=[weatherValue objectForKey:@"temp"];
        self.InfoLab.text=[NSString stringWithFormat:@"%@:%@摄氏度",city,temp];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"");
    }];
    
    
    
    
}
//网络监控
-(void)montierNetWork{
    
    NSURL *baseURl=[NSURL URLWithString:@"http://www.baidu.com"];
    
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURl];
    NSOperationQueue *operationQueue=manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
                case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
}

-(void)loadJsonWeatherDate{
     AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:kWeatherInfoAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误");
    }];
}
-(void)loadJsonWeatherDate2{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:kWeatherInfoAPI parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"错误");
    }];
}
-(void)loginOSChina{
    
     AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
    
    NSDictionary *myParameters=@{
                                 
                                 @"username":@"",
                                 @"paw":@""
                      
                                 };
    [manager POST:api_login_validate parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"");
    }];
    
}

@end














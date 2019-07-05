//
//  ViewController.m
//  MediaCloud
//
//  Created by  TRS on 2019/6/17.
//  Copyright © 2019  TRS. All rights reserved.
//

#import "ViewController.h"
#import "MCSDK.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.navigationItem.title = @"MCSDK-Demo";
    self.tableView.tableFooterView = [UIView new];
    
    // 初始化数据
    _datasource = @[@"栏目树",@"获得栏目列表",@"获得稿件详情"];

    //注册MCSDK服务
    [MCSDK initMCSDKWithUrl:@"http://223.240.84.240:81"];
}

- (void)showAlert:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"运行结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];    
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _datasource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: //栏目数941
        {
            [MCSDK getChannelsBySiteId:941 completion:^(BOOL success, NSDictionary * _Nonnull response, NSError * _Nonnull error) {
                
                [self showAlert:[self dictionaryToJSONString:response] ];
            }];
            break;
        }
            
        case 1: //栏目列表
        {
            [MCSDK getChnlDocs:9820 pageNo:1 pageSize:20 completion:^(BOOL success, NSDictionary * _Nonnull response, NSError * _Nonnull error) {
               
                [self showAlert:[self dictionaryToJSONString:response] ];
            }];
            break;
        }
            
        case 2: //稿件详情
        {
            [MCSDK getDocument:887652 completion:^(BOOL success, NSDictionary * _Nonnull response, NSError * _Nonnull error) {

                [self showAlert:[self dictionaryToJSONString:response] ];
            }];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - JSON转字符串

- (NSString * _Nullable)dictionaryToJSONString:(NSDictionary * _Nonnull)dictionary {
    
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if(error) {
        NSLog(@"字典转化为JSON字符串错误: %@", error.localizedDescription);
    }
    else {
        jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end

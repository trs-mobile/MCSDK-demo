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
{
    NSArray *arr2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册MCSDK服务
    [MCSDK initMCSDKWithUrl:@"http://223.240.84.240:81"];
    arr2 = @[@"栏目树",@"获得栏目列表",@"获得稿件详情"];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arr2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = arr2[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: //栏目数94
            [MCSDK getChannelsBySiteId:941 completion:^(BOOL success, NSDictionary * _Nonnull ressponse, NSError * _Nonnull error) {
                
            }];
            break;
        case 1: //栏目列表
            [MCSDK getChnlDocs:9820 pageNo:1 pageSize:20 completion:^(BOOL success, NSDictionary * _Nonnull ressponse, NSError * _Nonnull error) {
                
            }];
            break;
        case 2: //稿件详情
            [MCSDK getDocument:887652 completion:^(BOOL success, NSDictionary * _Nonnull ressponse, NSError * _Nonnull error) {
                
            }];
            break;
        default:
            break;
    }
}

@end

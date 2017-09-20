//
//  StudentListViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/18.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "StudentListViewController.h"
#import "StudentDetailTableViewCell.h"
#import "ModifyViewController.h"
#import "AddViewController.h"
#import "YYModel.h"
#import "lyhaoSocketManager.h"

static NSString *kStudentDetailTableViewCellID = @"kStudentDetailTableViewCellID";

@interface StudentListViewController ()<UITableViewDelegate, UITableViewDataSource,lyhaoSocketManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [lyhaoSocketManager shareInstance];
    [[lyhaoSocketManager shareInstance] setDelegate:self];
    [[lyhaoSocketManager shareInstance] sendMsg:@"aaa"];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"Student List";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.tableView.rowHeight = 77;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    AddViewController *addVC = [[AddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark - lyhaoSocketManagerDelegate
- (void)recvMsg:(NSArray *)msg {
    self.dataArr = [NSMutableArray arrayWithArray:msg];
    //回主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudentDetailTableViewCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StudentDetailTableViewCell" owner:nil options:nil] firstObject];
    }
//    [cell refreshViewWithData:[StudentModel yj_initWithDictionary:self.dataArr[indexPath.row]]];
    [cell refreshViewWithData:[StudentModel yy_modelWithDictionary:self.dataArr[indexPath.row]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

//可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [[lyhaoSocketManager shareInstance] sendMsg:@"DELETE "];
        [self.tableView reloadData];
    }];
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ModifyViewController *modifyVC = [[ModifyViewController alloc] init];
        modifyVC.name = [self.dataArr[indexPath.row] objectForKey:@"name"];
        modifyVC.gender = [self.dataArr[indexPath.row] objectForKey:@"gender"];
        modifyVC.age = [self.dataArr[indexPath.row] objectForKey:@"age"];
        modifyVC.studentID = [self.dataArr[indexPath.row] objectForKey:@"studentID"];
        [self.navigationController pushViewController:modifyVC animated:YES];
    }];
    
    return @[deleteAction, modifyAction];
}

@end

//
//  ModifyViewController.m
//  cfstreamMsg
//
//  Created by lyhao on 2017/9/19.
//  Copyright © 2017年 lyhao. All rights reserved.
//

#import "ModifyViewController.h"
#import "lyhaoSocketManager.h"

@interface ModifyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *studentIDTextField;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData {
    self.nameLabel.text = self.name;
    self.genderLabel.text = self.gender;
    self.ageLabel.text = self.age;
    self.studentIDLabel.text = self.studentID;
}

- (IBAction)modifyAction:(UIButton *)sender {
    //修改student sql语句
    NSString *name;
    NSString *gender;
    NSString *age;
    NSString *studentID;
    
    (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) ? (name = self.name) : (name = self.nameTextField.text);
    (self.genderTextField.text == nil || [self.genderTextField.text isEqualToString:@""]) ? (gender = self.gender) : (gender = self.genderTextField.text);
    (self.ageTextField.text == nil || [self.ageTextField.text isEqualToString:@""]) ? (name = self.age) : (name = self.ageTextField.text);
    (self.studentIDTextField.text == nil || [self.studentIDTextField.text isEqualToString:@""]) ? (name = self.name) : (name = self.studentIDTextField.text);
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE studentListTable SET name = '%@',gender = '%@',age = '%@',studentID = '%@' WHERE name = '%@'",name,gender,age,studentID,self.name];
    [[lyhaoSocketManager shareInstance] sendMsg:sql];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

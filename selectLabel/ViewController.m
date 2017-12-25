//
//  ViewController.m
//  selectLabel
//
//  Created by vteam on 2017/7/28.
//  Copyright © 2017年 vteam. All rights reserved.
//

#import "ViewController.h"
#import "selectLabelView.h"

@interface ViewController ()

@property (strong , nonatomic)UITableView  *table;

@property (strong , nonatomic)NSArray      *allArray;

@property (strong , nonatomic)NSArray      *myArray;

@property (strong , nonatomic)UITextView   *textView;

@end

@implementation ViewController

-(NSArray *)allArray{
    if (!_allArray) {
        _allArray=@[@"Objective-c",@"Swift",@"Go",@"Java",@"JavaScript",@"C#",@"C++",@"Matlab",@"PHP",@"C",@"Objective-c",@"Swift",@"Go",@"Java",@"JavaScript",@"C#",@"C++",@"Matlab",@"PHP",@"C"];
    }
    return _allArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"标签";
    
    self.view.backgroundColor=KBackColor;
    
    __weak typeof(self) weakSelf = self;
    selectLabelView *selectView=[[selectLabelView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kHPercentage(400)) titleFont:[UIFont systemFontOfSize:kHPercentage(13)] allArray:self.allArray];
    [selectView setClickSureBtn:^(NSArray *array){
        NSLog(@"%@",array);
        NSError *error;
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        weakSelf.textView.text=jsonString;
    }];
    [self.view addSubview:selectView];
    
    [self showTapTextView];
    
}

-(void)showTapTextView{
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(kWPercentage(10), kHPercentage(400), kScreenW-kWPercentage(20), kHPercentage(200))];
    self.textView.editable=NO;
    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.font=[UIFont systemFontOfSize:kHPercentage(13)];
    [self.view addSubview:self.textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

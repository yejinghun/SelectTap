//
//  selectLabelView.m
//  selectLabel
//
//  Created by vteam on 2017/7/28.
//  Copyright © 2017年 vteam. All rights reserved.
//

#import "selectLabelView.h"

@interface selectLabelView ()<UITableViewDataSource,UITableViewDelegate>{
    
    int           _rowCount;                    //标签行数
    int           _lastWidth;                   //累加当前一行标签的宽度
    NSDictionary  *_myDic;
    UILabel       *_label;
    UIButton      *_sureBtn;
    
}

@property (strong , nonatomic)UITableView     *tableView;

@property (strong , nonatomic)NSMutableArray  *allNSArray;             //上个页面传过来的数组

@property (strong , nonatomic)NSMutableArray  *selectNSArray;          //选中的数组

@property (strong , nonatomic)UIView          *selectView;

@property (strong , nonatomic)UIFont          *titleFont;              //标签字体

@end

@implementation selectLabelView

-(NSMutableArray *)allNSArray{
    if (!_allNSArray) {
        _allNSArray=[NSMutableArray new];
    }
    return _allNSArray;
}

-(NSMutableArray *)selectNSArray{
    if (!_selectNSArray) {
        _selectNSArray=[NSMutableArray new];
    }
    return _selectNSArray;
}

-(instancetype)initWithFrame:(CGRect)frame titleFont:(UIFont *)titleFont allArray:(NSArray *)allArray{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor grayColor];
        
        _rowCount=_lastWidth=0;
        self.titleFont=titleFont;
        [self.allNSArray addObjectsFromArray:allArray];
        
        self.tableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.estimatedSectionFooterHeight=0;
        self.tableView.estimatedSectionHeaderHeight=0;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator=NO;
        [self addSubview:self.tableView];
        
        [self.tableView setTableFooterView:[self footView]];
        
        [self headViewAndFootView];
        
    }
    return self;
    
}

-(UIView *)footView{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kHPercentage(50))];
    _sureBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreenW-kWPercentage(50))/2, kHPercentage(15), kWPercentage(50), kHPercentage(20))];
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.backgroundColor=[UIColor blueColor];
    _sureBtn.titleLabel.font=[UIFont systemFontOfSize:kHPercentage(15)];
    _sureBtn.layer.cornerRadius=kHPercentage(5);
    _sureBtn.clipsToBounds=YES;
    [_sureBtn addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_sureBtn];
    return footView;
    
}

-(void)clickSure{
    
    if (self.clickSureBtn) {
        self.clickSureBtn(self.selectNSArray);
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if (self.selectNSArray.count==0) {
            return 0;
        }else{
            return 1;
        }
    }else{
        if (self.allNSArray.count==0) {
            return 0;
        }else{
            return 1;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (self.selectNSArray.count==0) {
            return 0;
        }else{
            return [self showLabelViewWithHeight:self.selectNSArray];
        }
    }else{
        if (self.allNSArray.count==0) {
            return 0;
        }else{
            return [self showLabelViewWithHeight:self.allNSArray];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHPercentage(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kHPercentage(50))];
    headView.backgroundColor=[UIColor grayColor];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWPercentage(10), 0, kWPercentage(250), kHPercentage(50))];
    titleLabel.text=section==0?@"我的标签":@"所有标签";
    titleLabel.font=[UIFont systemFontOfSize:kHPercentage(15)];
    [headView addSubview:titleLabel];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectLabel"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        [cell addSubview:[self showSelectViewArray:self.selectNSArray]];
    }else{
        [cell addSubview:[self showSelectViewArray:self.allNSArray]];
    }
    return cell;
    
}

-(UIView *)showSelectViewArray:(NSArray *)array{
    
    self.selectView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self showLabelViewWithHeight:array])];
    _rowCount=_lastWidth=0;
    [self showLabel:array];
    return self.selectView;
    
}

-(void)showLabel:(NSArray *)array{
    
    for (int i=0; i<array.count; i++) {
        
        if (i==0) {
            
            _label=[[UILabel alloc]initWithFrame:CGRectMake(kWPercentage(10), kHPercentage(10), kWPercentage(10)+[self getWidthWithTitle:array[i] font:[UIFont systemFontOfSize:kHPercentage(13)]], kHPercentage(17))];
            _lastWidth=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
            
        }else{
            
            if (_lastWidth+kWPercentage(20)+[self getWidthWithTitle:array[i] font:self.titleFont]+kWPercentage(10)>self.frame.size.width) {
                
                _lastWidth=0;
                _rowCount+=1;
                _label=[[UILabel alloc]initWithFrame:CGRectMake(kWPercentage(10), kHPercentage(10)+kHPercentage(27)*_rowCount, kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont], kHPercentage(17))];
                _lastWidth+=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
                
            }else{
                
                _label=[[UILabel alloc]initWithFrame:CGRectMake(kWPercentage(10)+_lastWidth, kHPercentage(10)+kHPercentage(27)*_rowCount, kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont], kHPercentage(17))];
                _lastWidth+=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
                
            }
            
        }
        _label.text=array[i];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=self.titleFont;
        _label.layer.borderWidth=1;
        _label.layer.borderColor=[UIColor redColor].CGColor;
        _label.layer.cornerRadius=2;
        _label.clipsToBounds=YES;
        _label.tag=([array isEqualToArray:self.selectNSArray]?100:10000)+i;
        _label.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)];
        [_label addGestureRecognizer:tap];
        [self.selectView addSubview:_label];
        
    }
}

-(void)clickLabel:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag/10000>=1) {
        [self.selectNSArray addObject:self.allNSArray[sender.view.tag%10000]];
        [self.allNSArray removeObjectAtIndex:(sender.view.tag%10000)];
        [self.tableView reloadData];
    }else{
        [self.allNSArray addObject:self.selectNSArray[sender.view.tag%100]];
        [self.selectNSArray removeObjectAtIndex:(sender.view.tag%100)];
        [self.tableView reloadData];
    }
    
}

-(CGFloat)showLabelViewWithHeight:(NSArray *)array{
    
    _rowCount=_lastWidth=0;
    for (int i=0; i<array.count; i++) {
        
        if (i==0) {
            
            _lastWidth=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
            
        }else{
            
            if (_lastWidth+kWPercentage(20)+[self getWidthWithTitle:array[i] font:self.titleFont]+kWPercentage(10)>self.frame.size.width) {
                
                _lastWidth=0;
                _rowCount+=1;
                _lastWidth+=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
                
            }else{
                
                _lastWidth+=kWPercentage(10)+kWPercentage(10)+[self getWidthWithTitle:array[i] font:self.titleFont];
                
            }
            
        }
        
    }
    return kHPercentage(10)+kHPercentage(27)*(_rowCount+1);
}

-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

-(void)headViewAndFootView{
    //用UITableViewStyleGrouped时，用以下代码可以准备到具体位置
//    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
    //分段的tableView去掉段头段位
//    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 0;
}

@end

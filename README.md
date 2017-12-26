# SelectTap

* An easy way to select tap, when you click button, you can get the value which you click

## How to use selectTap

* Drag `selectLabelView.h`  and `selectLabelView.m`  to your project
* Import the main file: `import "selectLabelView.h"`

## Reference

```objective-c
selectLabelView *selectView=[[selectLabelView     alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kHPercentage(400))     titleFont:[UIFont systemFontOfSize:kHPercentage(13)]     allArray:self.allArray];//初始化，传入标签label的字体大小、所有的标签
[selectView setClickSureBtn:^(NSArray *array){
NSLog(@"%@",array);//输入选中的标签内容
}];
[self.view addSubview:selectView];
```

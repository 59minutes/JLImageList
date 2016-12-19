#FJLImageList
##博客详情
[http://blog.csdn.net/fivenineminutes/article/details/52901050](http://blog.csdn.net/fivenineminutes/article/details/52901050) 
##如何使用
```oc  
ZoomImageView *imageView = [[ZoomImageView alloc] initWithFrame:CGRectMake(15 + (itemWith + 10) * i - ((i > 2)?((itemWith + 10) * 3):(0)), 64 + 50 + ((i > 2)?(itemWith + 10):(0)), itemWith, itemWith) withImage:[NSString stringWithFormat:@"tu_%li",i + 1]];
imageView.desArray = desArr;
imageView.imageArray = imageNames;
[self.view addSubview:imageView];
```

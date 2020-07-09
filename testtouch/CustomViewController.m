//
//  CustomViewController.m
//  testtouch
//
//  Created by 泽鹏邵 on 2020/6/24.
//  Copyright © 2020 泽鹏邵. All rights reserved.
//

#import "CustomViewController.h"
#import "DemoViewController1.h"
#import "DemoViewController2.h"

@interface CustomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *listView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self listView];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    curVC = self;
    
}

static CustomViewController *curVC = nil;

- (NSArray *)listArray
{
    if (!_listArray) {
        _listArray = @[@"样式1(存边框闪烁)",@"样式2(闪烁小球)",@"样式3(对称移动变色光线)",@"开样式4(多个闪烁小球)"];
    }
    return _listArray;
}

- (UITableView *)listView
{
    if (!_listView) {
        CGFloat listY = 0;
        CGFloat listH = self.view.frame.size.height - listY;
//        listH = 200;
        
        UITableView *listView = [[UITableView alloc] initWithFrame:CGRectMake(0, listY, self.view.frame.size.width, listH) style:UITableViewStylePlain];
        listView.delegate = self;
        listView.dataSource = self;
        listView.backgroundColor = [UIColor whiteColor];
        listView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:listView];
        _listView = listView;
    }
    return _listView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *cellArray = [self.listView visibleCells];
    NSLog(@"cellArray = %@",cellArray);
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"abc"];
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd--->%@",indexPath.row,self.listArray[indexPath.row]];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0){
        DemoViewController1 *demo1 = [[DemoViewController1 alloc] init];
        [self.navigationController pushViewController:demo1 animated:YES];
    }else if (indexPath.row == 1){
        DemoViewController2 *demo2 = [[DemoViewController2 alloc] init];
        [self.navigationController pushViewController:demo2 animated:YES];
    }else if (indexPath.row == 2){
        //敬请期待
    }else if (indexPath.row == 3){
        //敬请期待
    }
 }

- (void)test1
{
    NSLog(@"%s",__func__);
    
}

- (void)test2
{
    NSLog(@"%s",__func__);
    [self test2];

}

- (void)test3
{
    [self test3];
    NSLog(@"%s",__func__);
    

}



- (id)test
{
    NSLog(@"%s",__func__);
    return nil;
}

- (void)jh_run
{

    [curVC jh_run];

    NSLog(@"今天是个好日子");
}


@end

//
//  ViewController.m
//  tableview多选
//
//  Created by WOSHIPM on 16/7/5.
//  Copyright © 2016年 WOSHIPM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *button;
}

@property(nonatomic,strong)NSMutableArray *array;//数据源


@property (nonatomic,strong)NSMutableArray *selectorPatnArray;//存放选中数据
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    //添加数据源
    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d行",i + 1];
        [self.array addObject:str];
    }
    
    button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"选择" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 0, 50, 20);
//    [_tableView addSubview:button];
    [button addTarget:self action:@selector(selectMore:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell addSubview:button];
    cell.textLabel.text = self.array[indexPath.row];
    
//    　　 cell的selectionStyle不要设置为UITableViewSelectionStyleNone
    
    
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
    [self.selectorPatnArray addObject:self.array[indexPath.row]];
    
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectorPatnArray.count > 0) {
        
        [self.selectorPatnArray removeObject:self.array[indexPath.row]];
    }
    
}

#pragma mark - 点击事件

- (void)selectMore:(UIBarButtonItem *)action{
    if ([button.titleLabel.text isEqualToString:@"选择"]) {
        //移除之前选中的内容
        if (self.selectorPatnArray.count > 0) {
            [self.selectorPatnArray removeAllObjects];
        }
        [button setTitle:@"确认" forState:(UIControlStateNormal)];
        //进入编辑状态
        [self.tableView setEditing:YES animated:YES];
    }else{
        
        [button setTitle:@"选择" forState:(UIControlStateNormal)];
        　　　　　//对选中内容进行操作
        NSLog(@"选中个数是 : %lu   内容为 : %@",(unsigned long)self.selectorPatnArray.count,self.selectorPatnArray);
        //取消编辑状态
        [self.tableView setEditing:NO animated:YES];
        
    }
}


#pragma mark -懒加载

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)selectorPatnArray{
    if (!_selectorPatnArray) {
        _selectorPatnArray = [NSMutableArray array];
    }
    return _selectorPatnArray;
}



@end

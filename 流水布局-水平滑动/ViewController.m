//
//  ViewController.m
//  流水布局-水平滑动
//
//  Created by 杜志 on 2017/7/23.
//  Copyright © 2017年 杜志. All rights reserved.
//

#import "ViewController.h"
#import "DZCollectionViewFloeLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DZCollectionViewFloeLayout * flowLayout = [[DZCollectionViewFloeLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(110, 110);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
    
}

#pragma delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell  * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
@end

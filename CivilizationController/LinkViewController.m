//
//  LinkViewController.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "LinkViewController.h"
#import "LinkCollectionViewCell.h"
#import "LinkDetailViewController.h"

@interface LinkViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *englisgArr;
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr=@[@"嘉兴文明网联盟",@"浙江文明网",@"嘉兴在线",@"浙江在线",@"中国社区网",@"金华未成年人网",@"红船网",@"南湖文明网",@"秀洲文明网",@"星期六义务劳动联盟",@"桐乡文明网",@"海宁文明网",@"嘉兴国防教育网",@"嘉兴群众路线网",@"南湖青少年网"];
    _englisgArr=@[@"Jiaxing civilization network alliance",@"Zhejiang civilization network",@"Jiaxing online",@"Zhejiang online",@"The Chinese community",@"Jinhua minor remarks",@"The red ship network",@"South lake civilization network",@"Show chau civilization network",@"Compulsory labor union on Saturday",@"Tongxiang city civilization network",@"Haining civilization network",@"Jiaxing defense education network",@"Jiaxing defense education network",@"South lake youth network"];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    //注册
    [self.collectionView registerClass:[LinkCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
}
//个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.titleArr.count;
}
//绘制cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LinkCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.name.text=self.titleArr[indexPath.row];
    cell.number.text=[NSString stringWithFormat:@"%02ld",(long)indexPath.row+1];
    cell.englishName.text=self.englisgArr[indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2==1) {
        return CGSizeMake(176, 81);
    }else{
    
        return CGSizeMake(176, 100);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //传值
    NSString *titles=[NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    NSString *num=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSArray *array=@[titles,num];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setValue:array forKey:@"key"];
    
    //故事版跳转
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LinkDetailViewController *linkDetail=[story instantiateViewControllerWithIdentifier:@"linkDetailViewController"];
    [self presentViewController:linkDetail animated:YES completion:nil];
   
    
}
@end

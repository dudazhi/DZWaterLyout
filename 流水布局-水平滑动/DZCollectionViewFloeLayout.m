//
//  DZCollectionViewFloeLayout.m
//  流水布局-水平滑动
//
//  Created by 杜志 on 2017/7/23.
//  Copyright © 2017年 杜志. All rights reserved.
//

#import "DZCollectionViewFloeLayout.h"

@implementation DZCollectionViewFloeLayout
//icarouse
//不能在init里初始化，init初始化时，collectionView还未加进来
-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat inset = (self.collectionView.frame.size.width-self.itemSize.width)/2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes * attr = [[UICollectionViewLayoutAttributes alloc]init];
    attr.alpha = 0.1;
    return attr;
}



/*决定每个cell的布局和属性,一个cell有一个UICollectionViewLayoutAttributes,
 这个方法只执行一次，要想实现通过滑动改变布局要调用shouldInvalidateLayoutForBoundsChange
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获取super已经算好的UICollectionViewLayoutAttributes
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    //在原有的布局属性上微调
    /*
     1.根据cell的centerX与collection的centerX的距离算缩放比例（反比）
     2.cell的centerX的坐标原点的x值是contensize的x值，为了坐标原点一致，collection的centerX应该是collection的偏移量价上collection宽的一半
  
     */
    //collection的centerX
    CGFloat centerX = self.collectionView.contentOffset.x+self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes * atrr in array) {
        //cell的centerX与collection的centerX的距离
        CGFloat distance =ABS(centerX-atrr.center.x);
        //cell的缩放比例
        CGFloat scale = 1-distance/self.collectionView.frame.size.width;
        //微调比例
        atrr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}
//滑动就刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
//这个方法的返回值决定了collectionview停止滚动时的偏移量
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSArray * array = [super layoutAttributesForElementsInRect:CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height)];
    
    //这里应该用proposedContentOffset（滑动停止本应该的偏移量）
    CGFloat centerX = proposedContentOffset.x+self.collectionView.frame.size.width/2;
    
    //存放最小的间距
    CGFloat minDistance = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * atrr in array) {
        if (ABS(minDistance)>ABS(atrr.center.x-centerX)) {
            minDistance = atrr.center.x-centerX;
        }
    }
    //微调
    proposedContentOffset.x +=minDistance;
    return proposedContentOffset;
}

@end

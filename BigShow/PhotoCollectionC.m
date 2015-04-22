//
//  PhotoCollectionC.m
//  BigShow
//
//  Created by tindle on 15/4/21.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "PhotoCollectionC.h"
#import "PassValueDelegate.h"

@interface PhotoCollectionC () <UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    NSArray *recipeImages;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation PhotoCollectionC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *images = [NSArray arrayWithObjects:@"apple.png", @"apple.png", @"apple.png", @"apple.png", @"apple.png", nil];
    NSArray *images2 = [NSArray arrayWithObjects:@"apple.png", @"apple.png", @"apple.png", @"apple.png", @"apple.png", nil];
    recipeImages = [NSArray arrayWithObjects:images, images2, nil];
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [recipeImages count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[recipeImages objectAtIndex:section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView
               dequeueReusableCellWithReuseIdentifier:@"image_cell" forIndexPath:indexPath];
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
    image.image = [UIImage imageNamed:[recipeImages[indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(130, 130);
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"tap 1");
//    
//    return YES;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * imageName =[recipeImages[indexPath.section] objectAtIndex:indexPath.row];
    [self.delegate passValue:imageName];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

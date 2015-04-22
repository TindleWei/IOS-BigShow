//
//  EditThirdTableC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditThirdTableC.h"

@interface EditThirdTableC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditThirdTableC

-(void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"question_cell" forIndexPath:indexPath];
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ends_cell" forIndexPath:indexPath];
    
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
    image.frame = CGRectMake(0, 0, 90, 90); 
    image.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString* imageName = [NSString stringWithFormat:@"head"];
    image.image = [UIImage imageNamed:imageName];
//    cell.imageView.image = [UIImage imageNamed:@"head"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 56;
    }
    return 98;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end

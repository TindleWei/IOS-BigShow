//
//  EditThirdTableC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditThirdTableC.h"
#import "EndsTableCell.h"
#import "End.h"
#import "DataEditTool.h"

@interface EditThirdTableC () <UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

//这里面放的是End
@property (nonatomic, strong) NSMutableArray *endsArray;

@property (weak, nonatomic) IBOutlet UIImageView *addImage;

@end

@implementation EditThirdTableC


#pragma mark - View & LifeCycle

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"3 viewWillDisappear");
}

-(void)viewDidLoad {
    [super viewDidLoad];
    //从数据库中取数据
    
    self.endsArray = [DataEditTool shareEditDateTool].array;
    
    [self.endsArray addObject:[[End alloc] init]];
    [self.endsArray addObject:[[End alloc] init]];
    
    //Image点击监听
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewData)];
    [self.addImage addGestureRecognizer:singleTap];
    
    
}

-(void)addNewData{
    End *end = [[End alloc] init];
    [self.endsArray addObject:end];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareVisibleCellsForAnimation];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateVisibleCells];
}

-(void)prepareVisibleCellsForAnimation {
    for (int i=0; i<[self.tableView.visibleCells count]; i++){
        EndsTableCell *cell = (EndsTableCell *)
        [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
    }
}

-(void)animateVisibleCells {
    for (int i=0; i<[self.tableView.visibleCells count]; i++) {
        EndsTableCell *cell = (EndsTableCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.alpha = 1.f;
        [UIView animateWithDuration:0.25f delay:i*0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        } completion:nil];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
       
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}


#pragma mark - 软键盘操作

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.endsArray count]>=4){
        self.addImage.hidden = YES;
    }else{
        self.addImage.hidden = NO;
    }
    
//    NSLog(@"Third %ld", [self.endsArray count]);
//    NSLog(@"DataTool %ld", [[EditDataTool shareEditDateTool].array count]);
    
    return [self.endsArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        return [tableView dequeueReusableCellWithIdentifier:@"question_cell" forIndexPath:indexPath];
    } else{
        
        static NSString *CellIdentifier = @"EndsTableCell";
        EndsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EndsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        //Image点击监听
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCellData:)] ;
        [[cell deleteImage] addGestureRecognizer:singleTap];
        [cell deleteImage].tag = indexPath.row;
        
        [cell setKeyTypeDone];
        
        return cell;
    }
}

-(void)deleteCellData:(UITapGestureRecognizer*)tap{
    
    UIImageView *imageView = (UIImageView *)tap.view;
    [self.endsArray removeObjectAtIndex:(imageView.tag-1)];
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    return 98;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

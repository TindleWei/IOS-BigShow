//
//  BSFindC.m
//  BigShow
//
//  Created by tindle on 15/4/7.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "BSFindListC.h"

#import "Story.h"
#import "BSFindCell.h"
#import <UIViewController+MMDrawerController.h> 
#import <MMDrawerController.h>
#import <SIAlertView/SIAlertView.h>
#import "BSNavView.h"
#import "BSSearchBar.h"
#import "Story.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import <AVOSCloud/AVGlobal.h>

#define  QUERY_LIMIT 30
#define  ORDER_BY @"createdAt"


@interface BSFindListC ()<UITextFieldDelegate>{
    BOOL updateRefreshView;
    BOOL dragStart;
    
    BOOL isAddNew;
}
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, copy) NSString *newid;
@property (nonatomic, copy) NSString *lastid;
@property (nonatomic)UIButton *moreBtn;

@property (nonatomic, retain) BSProgressView *refreshView;

//应该是搜索的关键字
@property (nonatomic, strong) NSString *keyword;

@end

@implementation BSFindListC

-(void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    self.lastid=self.newid=nil;
    
    self.array=[NSMutableArray array];
    [self.tableView reloadData];
    
    self.moreBtn.hidden=YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)onSwipe:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction==UISwipeGestureRecognizerDirectionRight) {
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    } else {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AVAnalytics beginLogPageView:@"产品列表"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AVAnalytics endLogPageView:@"产品列表"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    self.title=@" ";
    self.newid = [[NSUserDefaults standardUserDefaults] objectForKey:@"CacheCourse"];
    
//    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
//    
//    swipe.direction=UISwipeGestureRecognizerDirectionRight;
//    
//    [self.view addGestureRecognizer:swipe];
//    
//    swipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
//    
//    swipe.direction=UISwipeGestureRecognizerDirectionLeft;
//    
//    [self.view addGestureRecognizer:swipe];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.backgroundView=[[UIImageView alloc] initWithImage:[BSTheme bgImage]];
    self.navigationItem.titleView = self.refreshView = [BSProgressView new];
    
    self.array=[NSMutableArray array];
    
    UIView *btmV=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, 10, 280, 40);
    btn.layer.borderWidth=1;
    btn.layer.borderColor=[UIColor colorWithWhite:1 alpha:0.8].CGColor;
    btn.clipsToBounds=YES;
    btn.layer.cornerRadius=4;
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [btn setTitle:@"更 多" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden=YES;
    self.moreBtn=btn;
    
    [btmV addSubview:btn];
    self.tableView.tableFooterView=btmV;
    
    if (is7orLater()) {
        [self.tableView setContentInset:UIEdgeInsetsMake([BSNavView height], 0, 0, 0)];
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTitleTap:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
    
    [self resetSearchBtn];
    
    [self loadNew];
    
}

-(void)resetSearchBtn{
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 44, 44);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
}

-(void)onSearchBtn:(UIButton*)btn{
    BSSearchBar *tf=[[BSSearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
    tf.delegate=self;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:tf];
    [tf becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    NSString *s=textField.text;
    
    if ([s isEqualToString:self.keyword]) {
        return NO;
    }
    
    if (s.length==0) {
        [self resetSearchBtn];
    }else{
        [(BSSearchBar*)textField tiny];
        self.keyword=s;
        [self loadNew];
    }
    
    return NO;
}

-(void)onSearchBarClose:(BSSearchBar*)sb{
    self.keyword=nil;
    [self loadNew];
    [self resetSearchBtn];
}


-(void)onTitleTap:(UITapGestureRecognizer*)tap{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 10, 1) animated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"showPostsWithPicsOnly"]) {
        [self.array removeAllObjects];
        [self loadNew];
    }
}

-(void)onGetNewPosts:(NSArray*)objects isMore:(BOOL)isMore{
    if (objects.count) {
        NSMutableArray *newObjs=[NSMutableArray array];
        NSArray *ids= [self.array valueForKeyPath:@"objectId"];
        for (AVObject *post in objects) {
            NSString *pid=post.objectId;
            if (![ids containsObject:pid]) {
                [newObjs addObject:post];
            }
        }
        
        objects=[newObjs sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ORDER_BY ascending:NO]]];
        
        long offset=0;
        if (isMore) {
            offset=self.array.count;
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:self.newid forKey:@"CacheCourse"];
            self.newid=objects[0][ORDER_BY];
        }
        
        NSIndexSet *iset=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(offset, objects.count)];
        
        [self.array insertObjects:objects atIndexes:iset];
        if(objects.count>=QUERY_LIMIT){
            self.lastid=[[self.array lastObject][ORDER_BY] copy];
            self.moreBtn.hidden=NO;
        }else{
            self.lastid=nil;
            self.moreBtn.hidden=YES;
        }

        [self.tableView reloadData];
    }
}

-(AVQuery*)getQuery{
    AVQuery *q = [Story query];
    q.cachePolicy = kAVCachePolicyNetworkElseCache;
    [q orderByAscending:ORDER_BY];
    [q setMaxCacheAge:60*60];
    [q setLimit:QUERY_LIMIT];
    [q whereKeyExists:@"pics"];
    [q whereKey:@"type" equalTo:@(0)];
    
    if (self.keyword) {
        [q whereKey:@"text" containsString:self.keyword];
    }
    return q;
}

-(void)loadNew {
    [self showRefresh];
    
    AVQuery *q=[self getQuery];
    if (self.newid) {
        [q whereKey:ORDER_BY greaterThan:self.newid];
    }
    
    __weak BSFindListC* ws = self;
    
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"出错了" andMessage:[
                                      error localizedDescription]];
            [alertView addButtonWithTitle:@"重试"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                      [ws showRefresh];
                                      [ws loadNew];
                                  }];
            [alertView addButtonWithTitle:@"取消"
                                     type:SIAlertViewButtonTypeCancel
             handler:^(SIAlertView *alertView) {
                 [ws.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
             }];
            
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            
            [alertView show];
        } else {
            [ws onGetNewPosts:objects isMore:NO];
        }
        [self hideRefreshView];
    }];
}

-(IBAction)loadMore:(id)sender{
    if (!self.lastid) {return;};
    
    AVQuery *q = [self getQuery];
    
    [q whereKey:ORDER_BY lessThan:self.lastid];
    
    self.lastid=nil;
    
    __weak BSFindListC* ws = self;
    [ws.moreBtn setTitle:@"" forState:UIControlStateNormal];
    
    UIActivityIndicatorView *av=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    av.center=ws.moreBtn.center;
    [av startAnimating];
    [ws.moreBtn.superview addSubview:av];
    ws.moreBtn.userInteractionEnabled=NO;
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"出错了" andMessage:[error localizedDescription]];
            
            [alertView addButtonWithTitle:@"重试"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alert) {
                                      [ws loadNew];
                                  }];
            
            [alertView addButtonWithTitle:@"取消"
                                     type:SIAlertViewButtonTypeCancel
                                  handler:^(SIAlertView *alert) {
                                      [ws.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
                                  }];
            
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            
            [alertView show];
        }else{
            [ws onGetNewPosts:objects isMore:YES];
            
            [av removeFromSuperview];
            [ws.moreBtn setTitle:@"更 多" forState:UIControlStateNormal];
        }
        ws.moreBtn.userInteractionEnabled=YES;
    }];
}


-(void)hideRefreshView{
    
    [UIView animateWithDuration:0.2 animations:^{
        if (is7orLater()) {
            [self.tableView setContentInset:UIEdgeInsetsMake([BSNavView height], 0, 0, 0)];
        } else {
            [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
     } completion:^(BOOL finished) {
         self.refreshView.infinite=NO;
         self.refreshView.progress=1;
         updateRefreshView=NO;
     }];
}

-(void)showRefresh{
    if (updateRefreshView) {
        return;
    }
    
    updateRefreshView=YES;
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableView setContentInset:UIEdgeInsetsMake([BSNavView height]+REFRESH_HEIGHT, 0, 0, 0)];
    }];
    
    self.refreshView.infinite=YES;
}

-(void)scrollViewDidBeginDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dragStart=YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float y=scrollView.contentOffset.y;
    
    if (!updateRefreshView && y<=-REFRESH_TRIGGER-REFRESH_HEIGHT) {
        [self.tableView setContentInset:UIEdgeInsetsMake(-y, 0, 0, 0)];
        
        [self showRefresh];
        [self loadNew];
        
        dragStart=NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float y=scrollView.contentOffset.y;
    
    if (dragStart && !updateRefreshView && y<0) {
        [self.refreshView setProgress:(1.0-(-y-REFRESH_HEIGHT)*1.0f/REFRESH_TRIGGER) animated:NO];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"PostCell0";
    BSFindCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    cell.table=tableView;
    
    Story *story=self.array[indexPath.row];
    cell.story = story;
    cell.characterLabel.text = story.cName;
    
    NSString *url = [story objectForKey:@"cAvatar"];
    [cell.characterImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"characterImage"]];
    
    NSString *name = [story objectForKey:@"cName"];
    cell.characterLabel.text = [NSString stringWithFormat:@"%@", name];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(BSFindCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (cell.canAnimate) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.duration = .5f;
        
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        [cell.layer addAnimation:scaleAnimation forKey:@"scale"];
        
        cell.canAnimate = NO;
    }
    [cell loadPhoto];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Story *story = self.array[indexPath.row];
    //跳转至详细界面
    
    //    self.mm_drawerController.rightDrawerViewController=pc;
    //
    //    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];

//    VZPostViewC *pc=[self.storyboard instantiateViewControllerWithIdentifier:@"PostViewC"];
//    pc.post=post;
//    [self.navigationController pushViewController:pc animated:YES];
}


@end

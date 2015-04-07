//
//  BSHomeC.m
//  BigShow
//
//  Created by tindle on 15/4/3.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "BSHomeC.h"

@interface BSHomeC ()
@property (weak, nonatomic) IBOutlet UIImageView *charcterImg;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

//索引
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong)NSThread *thread;

@end

@implementation BSHomeC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSArray arrayWithObjects:@"avatar_v", @"avatar_batman", @"avatar_soldier",@"avatar_thief",@"avatar_sponge",nil];
    
    self.charcterImg.image = [UIImage imageNamed:self.imageArray[0]];
    
    self.index = 0;
    
    //Button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startLong:)];
    longPress.minimumPressDuration = 0.8;
    [self.startBtn addGestureRecognizer:longPress];
    
    //Image点击监听
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage)];
    [self.charcterImg addGestureRecognizer:singleTap];
    
}

-(void)startLong:(UILongPressGestureRecognizer *)gestrueRecognizer{
    if ([gestrueRecognizer state] == UIGestureRecognizerStateBegan) {
        self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(changeImage) object:nil];
        [self.thread start];
        
    } else if ([gestrueRecognizer state] == UIGestureRecognizerStateEnded){
        [self.thread cancel];
        NSLog(@"Ended");
    }
}

-(void)changeImage{
    
    while ([[NSThread currentThread] isCancelled] == NO){
        [NSThread sleepForTimeInterval:0.1];
        
        NSLog(@"图片 %ld", self.index);
        self.index++;
        if(self.index>4){
            self.index=0;
        }
        [self performSelectorOnMainThread:@selector(resetImage) withObject:nil waitUntilDone:NO];
        
        NSLog(@"Thread Loop");
    }
}

-(void)resetImage{
    self.charcterImg.image = [UIImage imageNamed:self.imageArray[self.index]];
}

-(void)onClickImage{
    NSLog(@"图片被点击 %ld", self.index);
    self.index ++;
    if(self.index>4){
        self.index=0;
    }
    self.charcterImg.image = [UIImage imageNamed:self.imageArray[self.index]];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

//
//  BSFindCell.m
//  BigShow
//
//  Created by tindle on 15/4/7.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "BSFindCell.h"
#import <AVOSCloud/AVOSCloud.h>

#import "BSM.h"

#define avatarFrame CGRectMake(8, 17, 80, 80)

@implementation UIImageView(Progress)

-(void)setProgressImageWithUrl:(NSString*)url placeholderImage:(UIImage*)placeholderImage{
    [[self viewWithTag:1000] removeFromSuperview];
    
    AVFile* file=[AVFile fileWithURL:url];
    BOOL hasData = [file isDataAvailable];
    if(hasData){
        NSData* data = [file getData];
        UIImage* image = [UIImage imageWithData:data];
        self.image = image;
    } else {
        self.image=placeholderImage;
        
        BSProgressView *pv=[[BSProgressView alloc] initWithWidth:self.frame.size.width/2];
        pv.bgLineColor=[UIColor colorWithWhite:1 alpha:0.4];
        pv.fgLineColor=[UIColor whiteColor];
        pv.tag=1000;
        [self addSubview:pv];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(error){
                [pv removeFromSuperview];
            }else{
                UIImage* image=[UIImage imageWithData:data];
                self.image=image;
                [pv removeFromSuperview];
            }
        } progressBlock:^(NSInteger percentDone) {
            pv.progress=percentDone;
        }];
    }
}

@end

@interface BSFindCell()

@property(weak,nonatomic) NSMutableDictionary *oldFrame;

@end

@implementation BSFindCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)loadPhoto {
    
//    NSArray *pics=[self.story objectForKey:@"uAvatar"];
//    if (pics) {
//        NSString *url=pics[0];
//        url = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//        [self.storyImage setProgressImageWithUrl:url placeholderImage:[UIImage imageNamed:nil]];
//    }
//    
//    int c=pics.count;
//    if (c>1) {
//        self.pageControl.hidden=NO;
//        [self.pageControl setNumberOfPages:pics.count];
//        
//    }else{
//        self.pageControl.hidden=YES;
//    }
}

-(void)stopLoadPhoto{
    
}

//- (void)awakeFromNib {
//    self.characterLabel.textColor=[BSTheme textColor];
//    self.contentLabel.layer.cornerRadius = 4;
//    self.characterImage.clipsToBounds = YES;
//    self.characterImage.layer.borderWidth = 1;
//    self.characterImage.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    self.storyImage.backgroundColor = [UIColor clearColor];
//    self.characterImage.layer.cornerRadius = 20;
//}

-(void)prepareForReuse{
    [self reset];
}


-(void)reset{
//    if (self.oldFrame) {
//        self.characterImage.frame=avatarFrame;
//        self.characterImage.layer.cornerRadius=25;
//        
//        self.oldFrame=nil;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

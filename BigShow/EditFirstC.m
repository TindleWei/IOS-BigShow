//
//  EditFirstC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditFirstC.h"
#import "PhotoTweaksViewController.h"

@interface EditFirstC() <UITextFieldDelegate, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, PhotoTweaksViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation EditFirstC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.titleText.delegate = self;
    self.nameText.delegate = self;
    
    //Image点击监听
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage2)];
    [self.avatarImage addGestureRecognizer:singleTap];

}

-(void)onClickImage2{
    NSLog(@"图片被点击");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.navigationBarHidden = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    }];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField == _titleText){
        [_nameText becomeFirstResponder];
    }else if(textField == _nameText){
        [_nameText resignFirstResponder];
    }
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:image];
    photoTweaksViewController.delegate = self;
    photoTweaksViewController.autoSaveToLibray = NO;
    [picker pushViewController:photoTweaksViewController animated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishWithCroppedImage:(UIImage *)croppedImage{
    NSLog(@"图片 finishWithCroppedImage");
    self.avatarImage.image = croppedImage;
}

@end

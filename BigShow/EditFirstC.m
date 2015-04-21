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
    CGRect frame = textField.frame;
    //键盘高度是216 还有一个80是自己设的
    int offset = frame.origin.y + 80 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset>0){
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //输入框编辑完成以后，将视图恢复到原始状态
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"图片 imagePickerControllerDidCancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage{
    NSLog(@"图片 photoTweaksController");
    self.avatarImage.image = croppedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

//
//  EditFirstC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditFirstC.h"
#import "PhotoTweaksViewController.h"
#import "PhotoCollectionC.h"
#import "PassValueDelegate.h"
#import "EditSegmentC.h"

@interface EditFirstC() <UITextFieldDelegate, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UIActionSheetDelegate,
    PhotoTweaksViewControllerDelegate,  PassValueDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

//图片的传值
@property (nonatomic, copy) NSString* imagePath;

@end

@implementation EditFirstC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.titleText.delegate = self;
    self.nameText.delegate = self;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSheet:)];
    [self.avatarImage addGestureRecognizer:singleTap];
    
}

#pragma mark - 软键盘操作

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //随便点击空白处 隐藏键盘
    [self.titleText resignFirstResponder];
    [self.nameText resignFirstResponder];
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

#pragma mark - 图片剪裁

/**
 进入PhotoTweaks剪裁图片
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:image];
    photoTweaksViewController.delegate = self;
    photoTweaksViewController.autoSaveToLibray = NO;
    [picker pushViewController:photoTweaksViewController animated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage{
    self.avatarImage.image = croppedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - ActionSheet选项

- (IBAction)showSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"从相册中选取"
                                  otherButtonTitles:@"从网格中选取",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"从相册中选取");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.navigationBarHidden = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (buttonIndex == 1) {
        NSLog(@"从网格中选取");
        PhotoCollectionC *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionC"];
        //设置第二个界面的中的delegate为第一个j界面self
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(buttonIndex == 2) {
        NSLog(@"取消选取");
    }
}
/**
 暂时只传image，也可以穿对象
 */

-(void)passValue:(NSString *)value{
    self.imagePath = value;
    self.avatarImage.image = [UIImage imageNamed: self.imagePath];
}

@end

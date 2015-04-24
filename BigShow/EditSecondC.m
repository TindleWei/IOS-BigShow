//
//  EditSecondC.m
//  BigShow
//
//  Created by tindle on 15/4/20.
//  Copyright (c) 2015年 tindle. All rights reserved.
//

#import "EditSecondC.h"
#import "PhotoTweaksViewController.h"
#import "PhotoCollectionC.h"
#import "PassValueDelegate.h"
#import "Slot.h"
#import "DataEditTool.h"

@interface EditSecondC() <UITextViewDelegate , UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UIActionSheetDelegate,
    PhotoTweaksViewControllerDelegate,  PassValueDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@property (nonatomic, strong) Slot *slot;

//图片的传值
@property (nonatomic, copy) NSString* imagePath;

@end

@implementation EditSecondC

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"2 viewDidDisappear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"2 viewWillDisappear");
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.contentText.delegate = self;
    
    //Image点击监听
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSheet:)];
    [self.contentImage addGestureRecognizer:singleTap];
    
    self.slot = [DataEditTool shareEditDateTool].slot;
    
}

#pragma mark - 软键盘操作

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //随便点击空白处 隐藏键盘
    [self.contentText resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    //键盘高度是216 还有一个80是自己设的
    int offset = frame.origin.y + 100 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset>0){
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

-(void)textViewDidEndEditing:(UITextField *)textField {
    //输入框编辑完成以后，将视图恢复到原始状态
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
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
    self.contentImage.image = croppedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - ActionSheet选项

- (IBAction)showSheet:(id)sender {
    NSLog(@"show sheet");
    
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
    self.contentImage.image = [UIImage imageNamed: self.imagePath];
}


@end

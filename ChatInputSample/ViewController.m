//
//  ViewController.m
//  AutoGrowingTextInput
//
//  Created by Marat Alekperov (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

@synthesize textView = _textView, chatInput = _chatInput, emojiInputView = _emojiInputView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] init];
    if (self.view == nil) {
        [super loadView];
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) viewDidLoad {
   
   [super viewDidLoad];
	
    self.chatInput = [[THChatInput alloc] initWithFrame:CGRectMake(0, 417, 320, 44) ofType:THInputOnly];
    self.chatInput.delegate = self;
    self.chatInput.backgroundColor = [UIColor clearColor];
    
//    self.chatInput.inputBackgroundView.image = [[UIImage imageNamed:@"Chat_Footer_BG.png"] stretchableImageWithLeftCapWidth:80 topCapHeight:25];
//   
//	[self.chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp.png"] forState:UIControlStateNormal];
//	[self.chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateHighlighted];
//	[self.chatInput.attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateSelected];
//   
//	[self.chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon.png"] forState:UIControlStateNormal];
//	[self.chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateHighlighted];
//	[self.chatInput.emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateSelected];
//
//    [self.chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button.png"] forState:UIControlStateNormal];
//	[self.chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateHighlighted];
//	[self.chatInput.sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateSelected];
//	[self.chatInput.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.view addSubview:self.chatInput];
}

- (void) didReceiveMemoryWarning {
   
   [super didReceiveMemoryWarning];
}


#pragma mark - THChatDelegate methods

- (void) sendButtonPressed:(id)sender {
   
    self.textView.text = _chatInput.inputText;   
    [self.chatInput clearText];
}


- (void) showEmojiInput:(id)sender {
   
//   self.chatInput.textView.inputView = _chatInput.textView.inputView == nil ? _emojiInputView : nil;
//   
//   [self.chatInput.textView reloadInputViews];
}

- (void) returnButtonPressed:(id)sender {
   
   self.textView.text = [sender text];
    [sender resignFirstResponder];
//   self.chatInput.textView.text = @"";
   [self.chatInput adjustTextViewHeight];
}

@end

//
//  ViewController.h
//  AutoGrowingTextInput
//
//  Created by Marat Alekperov (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THChatInput.h"


@interface ViewController : UIViewController <THChatInputDelegate>

@property (strong, nonatomic)  UITextView *textView;

@property (strong, nonatomic)  THChatInput *chatInput;
@property (strong, nonatomic)  UIView *emojiInputView;

@end

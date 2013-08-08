//
//  Created by Marat Alekperov (aka Timur Harleev) (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    THInputOnly
} THChatInputType;

@interface THChatInput : UIView <UITextViewDelegate> {
    id __unsafe_unretained delegate;

//    UIButton* sendButton;
//    UIButton* attachButton;
//    UIButton* emojiButton;
//    UITextView* textView;
    
}
@property (unsafe_unretained) id delegate;
@property (nonatomic, strong, readonly) NSString *inputText;

//@property (strong, nonatomic) UIButton* sendButton;
//@property (strong, nonatomic) UIButton* attachButton;
//@property (strong, nonatomic) UIButton* emojiButton;
//@property (strong, nonatomic) UITextView* textView;

- (id) initWithFrame:(CGRect)frame ofType:(THChatInputType)type;

- (void) clearText;
- (void) adjustTextViewHeight;
- (void) setText:(NSString*)text;

@end

@protocol THChatInputDelegate

@required
- (void) sendButtonPressed:(id)sender;
- (void) returnButtonPressed:(id)sender;

@optional
- (void) textViewDidBeginEditing:(UITextView*)textView;
- (void) textViewDidEndEditing:(UITextView*)textView;
- (BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text;
- (void) textViewDidChange:(UITextView*)textView;
- (void) showAttachInput:(id)sender;
- (void) showEmojiInput:(id)sender;

@end

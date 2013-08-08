//
//  Created by Marat Alekperov (aka Timur Harleev) (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "THChatInput.h"

@interface THChatInput() {
    UILabel *_lblPlaceholder;
//    UIView *_inputBackgroundView;

//    UIButton *_attachButton;
//    UIButton *_emojiButton;
    UIButton *_sendButton;
    UITextView *_textView;
    int _inputHeightWithShadow;
    BOOL _autoResizeOnKeyboardVisibilityChanged;
}

@end

@implementation THChatInput

@synthesize delegate = _delegate;

- (id) initWithFrame:(CGRect)frame ofType:(THChatInputType)type
{  
    if (self = [super initWithFrame:frame])
    {
//        _inputHeight = 38.0f;
        _inputHeightWithShadow = CGRectGetHeight(frame);
        _autoResizeOnKeyboardVisibilityChanged = YES;
        
        if (type == THInputOnly) {
            [self composeInputandSend];
        }
    }
    return self;
}

-(NSString*)inputText
{
    return _textView.text;
}


- (void)composeInputandSend
{
    CGSize size = self.frame.size;
    
    // Input
//	_inputBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    _inputBackgroundView.backgroundColor = [UIColor grayColor];
//	[self addSubview:_inputBackgroundView];
    
	// Text field
	_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 230, 15)];
    _textView.backgroundColor = [UIColor whiteColor];
	_textView.delegate = self;
    _textView.contentInset = UIEdgeInsetsMake(-4, -2, -4, 0);
    _textView.showsVerticalScrollIndicator = NO;
    _textView.showsHorizontalScrollIndicator = NO;
	_textView.font = [UIFont systemFontOfSize:15.0f];
    _textView.layer.cornerRadius = 6;
	[self addSubview:_textView];
    
    [self adjustTextInputHeightForText:@"" animated:NO];
    
    _lblPlaceholder = [[UILabel alloc] initWithFrame:_textView.frame];
    _lblPlaceholder.font = [UIFont systemFontOfSize:15.0f];
    _lblPlaceholder.text = @" Type here...";
    _lblPlaceholder.textColor = [UIColor lightGrayColor];
    _lblPlaceholder.backgroundColor = [UIColor clearColor];
    [self addSubview:_lblPlaceholder];
    
    
    //http://stackoverflow.com/questions/2808888/is-it-even-possible-to-change-a-uibuttons-background-color
    _sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_sendButton.frame = CGRectMake(size.width - 64.0f, 10.0f, 58.0f, 27.0f);
    [_sendButton setTitle:@"send" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_sendButton];
}

- (void) composeView
{
   
   //	// Attach buttons
//	_attachButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_attachButton.frame = CGRectMake(6.0f, 12.0f, 26.0f, 27.0f);
//	_attachButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//   [_attachButton addTarget:self action:@selector(showAttachInput:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:_attachButton];
//	
//	_emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_emojiButton.frame = CGRectMake(12.0f + _attachButton.frame.size.width, 12.0f, 26.0f, 27.0f);
//	_emojiButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//   [_emojiButton addTarget:self action:@selector(showEmojiInput:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:_emojiButton];
	
	// Send button

   
}

- (void) adjustTextInputHeightForText:(NSString*)text animated:(BOOL)animated {
   
   int h1 = [text sizeWithFont:_textView.font].height;
   int h2 = [text sizeWithFont:_textView.font constrainedToSize:CGSizeMake(_textView.frame.size.width - 16, 170.0f) lineBreakMode:NSLineBreakByCharWrapping].height;
   
   [UIView animateWithDuration:(animated ? .1f : 0) animations:^
    {
       int h = h2 == h1 ? _inputHeightWithShadow : h2 + 24;
       int delta = h - self.frame.size.height;
       CGRect r2 = CGRectMake(0, self.frame.origin.y - delta, self.frame.size.width, h);
       self.frame = r2; //CGRectMake(0, self.frame.origin.y - delta, self.superview.frame.size.width, h);
//       _inputBackgroundView.frame = CGRectMake(0, 0, self.frame.size.width, h);
       
       CGRect r = _textView.frame;
//       r.origin.y = 10;
       r.size.height = h - 18;
       _textView.frame = r;
       
    } completion:^(BOOL finished)
    {
       //
    }];
}

- (void) clearText
{
    _textView.text = @"";
    [self adjustTextViewHeight];
}

- (void) adjustTextViewHeight {
   
   [self adjustTextInputHeightForText:_textView.text animated:YES];
}

- (void) setText:(NSString*)text {
   
   _textView.text = text;
   _lblPlaceholder.hidden = text.length > 0;
   [self adjustTextViewHeight];
}


#pragma mark UITextFieldDelegate Delegate

- (void) textViewDidBeginEditing:(UITextView*)textView
{
   
   if (_autoResizeOnKeyboardVisibilityChanged)
   {
      [UIView animateWithDuration:.25f animations:^{
         CGRect r = self.frame;
         r.origin.y -= 216;
         [self setFrame:r];
      }];
      [self adjustTextViewHeight];
   }
   if ([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
      [self.delegate performSelector:@selector(textViewDidBeginEditing:) withObject:textView];
}

- (void) textViewDidEndEditing:(UITextView*)textView {
   
   if (_autoResizeOnKeyboardVisibilityChanged)
   {
      [UIView animateWithDuration:.25f animations:^{
         CGRect r = self.frame;
         r.origin.y += 216;
         [self setFrame:r];
      }];
      
      [self adjustTextViewHeight];
   }
   _lblPlaceholder.hidden = _textView.text.length > 0;
   
   if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)])
      [self.delegate performSelector:@selector(textViewDidEndEditing:) withObject:textView];
}

- (BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
   
   if ([text isEqualToString:@"\n"])
   {
      if ([self.delegate respondsToSelector:@selector(returnButtonPressed:)])
         [self.delegate performSelector:@selector(returnButtonPressed:) withObject:_textView afterDelay:.1];
      return NO;
   }
   else if (text.length > 0)
   {
      [self adjustTextInputHeightForText:[NSString stringWithFormat:@"%@%@", _textView.text, text] animated:YES];
   }
   return YES;
}

- (void) textViewDidChange:(UITextView*)textView {
   
    _lblPlaceholder.hidden = _textView.text.length > 0;
   
   [self adjustTextViewHeight];
   
   if ([self.delegate respondsToSelector:@selector(textViewDidChange:)])
      [self.delegate performSelector:@selector(textViewDidChange:) withObject:textView];
}


#pragma mark THChatInput Delegate

- (void) sendButtonPressed:(id)sender {
   
   if ([self.delegate respondsToSelector:@selector(sendButtonPressed:)])
      [self.delegate performSelector:@selector(sendButtonPressed:) withObject:sender];
}

- (void) showAttachInput:(id)sender {
   
   if ([self.delegate respondsToSelector:@selector(showAttachInput:)])
      [self.delegate performSelector:@selector(showAttachInput:) withObject:sender];
}

- (void) showEmojiInput:(id)sender {
   
   if ([self.delegate respondsToSelector:@selector(showEmojiInput:)])
   {
      if ([_textView isFirstResponder] == NO) [_textView becomeFirstResponder];

      [self.delegate performSelector:@selector(showEmojiInput:) withObject:sender];
   }
}

@end

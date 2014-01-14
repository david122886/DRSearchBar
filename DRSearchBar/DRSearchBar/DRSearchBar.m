//
//  DRSearchBar.m
//  DRSearchBar
//
//  Created by david on 14-1-13.
//  Copyright (c) 2014年 david. All rights reserved.
//

#import "DRSearchBar.h"
@interface DRSearchBar()
@property (weak, nonatomic) IBOutlet UIImageView *searchBackView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBt;
@property (weak, nonatomic) IBOutlet UITextField *searchTextLabel;

@end
@implementation DRSearchBar
- (IBAction)cancelBtClicked:(id)sender {
    self.searchTextLabel.text = @"";
    [self.searchTextLabel resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(drSearchBar:didCancelSearchText:)]) {
        [self.delegate drSearchBar:self didCancelSearchText:self.searchTextLabel.text];
    }
}
- (IBAction)searchBarClicked:(id)sender {
    if (!self.searchTextLabel.text || [self.searchTextLabel.text isEqualToString:@""]) {
        return;
    }
     [self.searchTextLabel resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(drSearchBar:didBeginSearchText:)]) {
        [self.delegate drSearchBar:self didBeginSearchText:self.searchTextLabel.text];
    }
}

#pragma mark UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *oldString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([newString isEqualToString:@""]) {
        oldString = [oldString stringByReplacingCharactersInRange:NSMakeRange(oldString.length-1, 1) withString:newString];
    }else{
        oldString = [NSString stringWithFormat:@"%@%@",oldString,newString];
    }
    
    if ([oldString isEqualToString:@""] ) {
        [self.cancelBt setHidden:YES];
    }else{
        [self.cancelBt setHidden:NO];
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        [self.cancelBt setHidden:YES];
    }else{
        [self.cancelBt setHidden:NO];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(drSearchBar:didBeginSearchText:)]) {
        [self.delegate drSearchBar:self didBeginSearchText:self.searchTextLabel.text];
    }
    return YES;
}
#pragma mark --


- (id)initWithFrame:(CGRect)frame
{
    NSArray *subViews = [[NSBundle mainBundle] loadNibNamed:@"DRSearchBar" owner:self options:nil];
    DRSearchBar *searchBar = [subViews firstObject];
    if (searchBar) {
        searchBar.frame = frame;
        searchBar.searchTextLabel.delegate = searchBar;
        [searchBar.cancelBt setHidden:YES];
        searchBar.searchBackView.image = [[UIImage imageNamed:@"searchBar_Backview.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
//        searchBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    }
    return searchBar;
}

//-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView* result = [super hitTest:point withEvent:event];
//    if (result)
//        return result;
//    for (UIView* sub in [self.subviews reverseObjectEnumerator]) {
//        CGPoint pt = [self convertPoint:point toView:sub];
//        result = [sub hitTest:pt withEvent:event];
//        if (result)
//            return result;
//    }
//    return nil;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark property
-(NSString *)searchText{
    return self.searchTextLabel.text;
}
#pragma mark --
@end

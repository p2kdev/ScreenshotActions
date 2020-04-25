#line 1 "Tweak.xm"
#import "UIKit/UIKit.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MLIMGURUploader.h"

#define IMGUR_CLIENT_ID @"4fb524843c272ea"

@interface SSSScreenshot
@end

@interface UIImage (SSSScreenshot)
	+(id)_sss_imageFromScreenshot:(id)arg1;
@end

@interface SSSScreenshotsViewController : UIViewController
	-(NSArray *)visibleScreenshots;
	-(void)presentActivityViewController;
	@property(readonly, nonatomic) SSSScreenshot* currentScreenshot;
	@property (nonatomic,retain) UIAlertController* busyController;
	- (void)_updateTopBarProperties;
	- (void)_cancelSharing;
	- (void)uploadToImgur;
	- (void)displayAlert:(NSString*)arg1;
@end

@interface SSSContainerViewController : UIViewController
	@property (nonatomic,retain) UIAlertController* busyController;
	- (void)screenshotsViewController:(SSSScreenshotsViewController *)viewController requestsDeleteForScreenshots:(NSArray *)screenshots deleteOptions:(unsigned long long)options forReason:(NSUInteger)reason;
	- (void)screenshotsViewController:(id)arg1 requestsDeleteForScreenshots:(id)arg2 forReason:(unsigned long long)arg3;
	- (void)deleteRequestedForAllScreenshotsFromScreenshotsViewController:(id)screenshotsController animatingDeletion:(BOOL)deletion;
	- (void)dismissScreenshotsAnimated:(_Bool)arg1 completion:(id)arg2;
	- (void)screenshotsViewController:(id)arg1 requestsPresentingActivityViewControllerWithBlock:(id)arg2;
	- (void)copyImageToClipboard;
	- (void)deleteImages;
	- (void)showShareSheet;
	- (void)uploadToImgur;
	- (void)displayAlert:(NSString*)arg1;
	- (void)showAlert;
@end

@interface SSSActionsAlertController : UIAlertController

@end

@implementation SSSActionsAlertController


	-(BOOL)_canShowWhileLocked {
		return YES;
	}

@end

static BOOL shouldStopTimer = NO;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SSSScreenshotsViewController; @class SSSContainerViewController; @class SSSDittoDismissTimer; 
static void (*_logos_orig$_ungrouped$SSSContainerViewController$viewDidAppear$)(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SSSContainerViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SSSContainerViewController$showAlert(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSContainerViewController$showShareSheet(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSContainerViewController$uploadToImgur(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSContainerViewController$displayAlert$(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$SSSContainerViewController$copyImageToClipboard(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSContainerViewController$deleteImages(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$)(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SSSScreenshotsViewController$uploadToImgur(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSScreenshotsViewController$displayAlert$(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST, SEL, NSString *); static void (*_logos_orig$_ungrouped$SSSDittoDismissTimer$_timerFired)(_LOGOS_SELF_TYPE_NORMAL SSSDittoDismissTimer* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SSSDittoDismissTimer$_timerFired(_LOGOS_SELF_TYPE_NORMAL SSSDittoDismissTimer* _LOGOS_SELF_CONST, SEL); 

#line 55 "Tweak.xm"


__attribute__((used)) static UIAlertController* _logos_method$_ungrouped$SSSContainerViewController$busyController(SSSContainerViewController * __unused self, SEL __unused _cmd) { return (UIAlertController*)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SSSContainerViewController$busyController); }; __attribute__((used)) static void _logos_method$_ungrouped$SSSContainerViewController$setBusyController(SSSContainerViewController * __unused self, SEL __unused _cmd, UIAlertController* rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SSSContainerViewController$busyController, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }


	static void _logos_method$_ungrouped$SSSContainerViewController$viewDidAppear$(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
		_logos_orig$_ungrouped$SSSContainerViewController$viewDidAppear$(self, _cmd, arg1);
		if (arg1)
		{
			shouldStopTimer = NO;
			[self showAlert];	
		}
	}

	
	
	
	
	

	

	static void _logos_method$_ungrouped$SSSContainerViewController$showAlert(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		SSSActionsAlertController * alert = [SSSActionsAlertController
																alertControllerWithTitle:@"ScreenShotActions"
																message:@"What would you like to do?"
																preferredStyle:UIAlertControllerStyleActionSheet];

	UIAlertAction* copyWithoutDeleteButton = [UIAlertAction
                              actionWithTitle:@"Copy Image"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
															[self copyImageToClipboard];
														}];

		UIAlertAction* copyButton = [UIAlertAction
	                              actionWithTitle:@"Copy Image & Delete"
	                              style:UIAlertActionStyleDestructive
	                              handler:^(UIAlertAction * action) {
																[self copyImageToClipboard];
																[self deleteImages];
															}];

		UIAlertAction* deleteButton = [UIAlertAction
		                          actionWithTitle:@"Delete Image(s)"
		                          style:UIAlertActionStyleDestructive
		                          handler:^(UIAlertAction * action) {
															[self deleteImages];
														}];

		UIAlertAction* shareButton = [UIAlertAction
																actionWithTitle:@"Share Image"
																style:UIAlertActionStyleDefault
																handler:^(UIAlertAction * action) {
																[self showShareSheet];
																}];

		UIAlertAction* uploadButton = [UIAlertAction
																actionWithTitle:@"Upload to Imgur"
																style:UIAlertActionStyleDefault
																handler:^(UIAlertAction * action) {
																[self uploadToImgur];

																}];

		UIAlertAction* cancelButton = [UIAlertAction
																actionWithTitle:@"Cancel"
																style:UIAlertActionStyleCancel
																handler:^(UIAlertAction * action) {
																}];

	  [alert addAction:uploadButton];
		[alert addAction:shareButton];
		[alert addAction:copyWithoutDeleteButton];
		[alert addAction:copyButton];
		[alert addAction:deleteButton];
		[alert addAction:cancelButton];

	  [self presentViewController:alert animated:YES completion:nil];
	}

	

	static void _logos_method$_ungrouped$SSSContainerViewController$showShareSheet(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		SSSScreenshotsViewController *screenshotsController = MSHookIvar<SSSScreenshotsViewController *>(self, "_screenshotsViewController");
		[screenshotsController presentActivityViewController];
	}



	

	static void _logos_method$_ungrouped$SSSContainerViewController$uploadToImgur(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		SSSScreenshotsViewController *screenshotsController = MSHookIvar<SSSScreenshotsViewController *>(self, "_screenshotsViewController");

		self.busyController = [UIAlertController alertControllerWithTitle:nil
																																		 message:@"Please wait..."
																															preferredStyle:UIAlertControllerStyleAlert];
			[self presentViewController:self.busyController animated:YES completion:nil];

			NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		[MLIMGURUploader uploadPhoto:UIImagePNGRepresentation([UIImage _sss_imageFromScreenshot:screenshotsController.currentScreenshot])
				title:[dateFormatter stringFromDate:[NSDate date]]
				description:@"Auto uploaded screenshot from the iOS Tweak ScreenshotActions"
				imgurClientID:IMGUR_CLIENT_ID
				completionBlock:^(NSString *result)
				{
					[self.busyController dismissViewControllerAnimated:YES completion:nil];

						if (result)
						{
								[[UIPasteboard generalPasteboard] setString:result];
								[self displayAlert:@"Image upload successful! URL has been copied to the clipboard"];
						}
				}
				failureBlock:^(NSURLResponse *a, NSError *error, NSInteger c){
						[self displayAlert:[NSString stringWithFormat:@"An error occured while uploading the screenshot: %@", error ? [error localizedDescription] : @"Unknown Error while uploading image!"]];
						}];
	}

	

	static void _logos_method$_ungrouped$SSSContainerViewController$displayAlert$(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
		SSSActionsAlertController * errorAlert = [SSSActionsAlertController
																alertControllerWithTitle:@"Imgur Upload"
																message:arg1
																preferredStyle:UIAlertControllerStyleAlert];

			UIAlertAction* cancelButton = [UIAlertAction
																	actionWithTitle:@"Ok"
																	style:UIAlertActionStyleCancel
																	handler:^(UIAlertAction * action) {
																	}];

			[errorAlert addAction:cancelButton];
			[self presentViewController:errorAlert animated:YES completion:nil];
	}

	

	static void _logos_method$_ungrouped$SSSContainerViewController$copyImageToClipboard(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		UIPasteboard *pb = [UIPasteboard generalPasteboard];
		[pb setData:UIImagePNGRepresentation([UIImage _sss_imageFromScreenshot:MSHookIvar<SSSScreenshotsViewController *>(self, "_screenshotsViewController").currentScreenshot]) forPasteboardType:(__bridge NSString *)kUTTypePNG];
	}

	

	static void _logos_method$_ungrouped$SSSContainerViewController$deleteImages(_LOGOS_SELF_TYPE_NORMAL SSSContainerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		SSSScreenshotsViewController *screenshotsController = MSHookIvar<SSSScreenshotsViewController*>(self, "_screenshotsViewController");
		
		if ([self respondsToSelector:@selector(screenshotsViewController:requestsDeleteForScreenshots:forReason:)])
			[self screenshotsViewController:screenshotsController requestsDeleteForScreenshots:[screenshotsController visibleScreenshots] forReason:0];
		
		else if ([self respondsToSelector:@selector(deleteRequestedForAllScreenshotsFromScreenshotsViewController:animatingDeletion:)])
		  [self deleteRequestedForAllScreenshotsFromScreenshotsViewController:screenshotsController animatingDeletion:YES];
		
		else if ([self respondsToSelector:@selector(screenshotsViewController:requestsDeleteForScreenshots:deleteOptions:forReason:)])
			[self screenshotsViewController:screenshotsController requestsDeleteForScreenshots:[screenshotsController visibleScreenshots] deleteOptions:0 forReason:0];

		[self dismissScreenshotsAnimated:YES completion:nil];
	}



@interface UIAlertController (SSActions)
	-(NSMutableArray *)_actions;
	-(NSArray*)actions;
	-(void)_removeAllActions;
	-(void)_setActions:(id)arg1;
@end



__attribute__((used)) static UIAlertController* _logos_method$_ungrouped$SSSScreenshotsViewController$busyController(SSSScreenshotsViewController * __unused self, SEL __unused _cmd) { return (UIAlertController*)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SSSScreenshotsViewController$busyController); }; __attribute__((used)) static void _logos_method$_ungrouped$SSSScreenshotsViewController$setBusyController(SSSScreenshotsViewController * __unused self, SEL __unused _cmd, UIAlertController* rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SSSScreenshotsViewController$busyController, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }


	static void _logos_method$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
		_logos_orig$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$(self, _cmd, arg1);
		UIAlertController *origAlert = MSHookIvar<UIAlertController*>(self,"_doneActionSheet");
		NSMutableArray *origActions = [[origAlert actions] mutableCopy];

		UIAlertAction* uploadButton = [UIAlertAction
																actionWithTitle:@"Upload to Imgur"
																style:UIAlertActionStyleDefault
																handler:^(UIAlertAction * action) {
																	[self uploadToImgur];
																}];
			[origActions insertObject:uploadButton atIndex:origActions.count<= 1 ? 0 : origActions.count - 2];
			[origAlert _removeAllActions];

			for(id action in origActions)
				[origAlert addAction:action];
	}

	

	static void _logos_method$_ungrouped$SSSScreenshotsViewController$uploadToImgur(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		self.busyController = [UIAlertController alertControllerWithTitle:nil
																																		 message:@"Please wait..."
																															preferredStyle:UIAlertControllerStyleAlert];
			[self presentViewController:self.busyController animated:YES completion:nil];

			NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
			[MLIMGURUploader uploadPhoto:UIImagePNGRepresentation([UIImage _sss_imageFromScreenshot:self.currentScreenshot])
				title:[dateFormatter stringFromDate:[NSDate date]]
				description:@"Auto uploaded screenshot from the iOS Tweak ScreenshotActions"
				imgurClientID:IMGUR_CLIENT_ID
				completionBlock:^(NSString *result)
				{
					[self.busyController dismissViewControllerAnimated:YES completion:nil];
					[self _cancelSharing];
						if (result)
						{
								[[UIPasteboard generalPasteboard] setString:result];
								[self displayAlert:@"Image upload successful! URL has been copied to the clipboard"];
						}
				}
				failureBlock:^(NSURLResponse *a, NSError *error, NSInteger c){
						[self displayAlert:[NSString stringWithFormat:@"An error occured while uploading the screenshot: %@", error ? [error localizedDescription] : @"Unknown Error while uploading image!"]];
						}];
	}

	

	static void _logos_method$_ungrouped$SSSScreenshotsViewController$displayAlert$(_LOGOS_SELF_TYPE_NORMAL SSSScreenshotsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
		SSSActionsAlertController * errorAlert = [SSSActionsAlertController
																alertControllerWithTitle:@"Imgur Upload"
																message:arg1
																preferredStyle:UIAlertControllerStyleAlert];

			UIAlertAction* cancelButton = [UIAlertAction
																	actionWithTitle:@"Ok"
																	style:UIAlertActionStyleCancel
																	handler:^(UIAlertAction * action) {
																	}];

			[errorAlert addAction:cancelButton];
			[self presentViewController:errorAlert animated:YES completion:nil];
	}




	static void _logos_method$_ungrouped$SSSDittoDismissTimer$_timerFired(_LOGOS_SELF_TYPE_NORMAL SSSDittoDismissTimer* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		if (shouldStopTimer)
		{
			
			
			
			return;
		}

		_logos_orig$_ungrouped$SSSDittoDismissTimer$_timerFired(self, _cmd);
	}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SSSContainerViewController = objc_getClass("SSSContainerViewController"); MSHookMessageEx(_logos_class$_ungrouped$SSSContainerViewController, @selector(viewDidAppear:), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$viewDidAppear$, (IMP*)&_logos_orig$_ungrouped$SSSContainerViewController$viewDidAppear$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(showAlert), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$showAlert, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(showShareSheet), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$showShareSheet, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(uploadToImgur), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$uploadToImgur, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(displayAlert:), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$displayAlert$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(copyImageToClipboard), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$copyImageToClipboard, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(deleteImages), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$deleteImages, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIAlertController*)); class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(busyController), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$busyController, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIAlertController*)); class_addMethod(_logos_class$_ungrouped$SSSContainerViewController, @selector(setBusyController:), (IMP)&_logos_method$_ungrouped$SSSContainerViewController$setBusyController, _typeEncoding); } Class _logos_class$_ungrouped$SSSScreenshotsViewController = objc_getClass("SSSScreenshotsViewController"); MSHookMessageEx(_logos_class$_ungrouped$SSSScreenshotsViewController, @selector(_showActionSheetForDoneButton:), (IMP)&_logos_method$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$, (IMP*)&_logos_orig$_ungrouped$SSSScreenshotsViewController$_showActionSheetForDoneButton$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSScreenshotsViewController, @selector(uploadToImgur), (IMP)&_logos_method$_ungrouped$SSSScreenshotsViewController$uploadToImgur, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SSSScreenshotsViewController, @selector(displayAlert:), (IMP)&_logos_method$_ungrouped$SSSScreenshotsViewController$displayAlert$, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIAlertController*)); class_addMethod(_logos_class$_ungrouped$SSSScreenshotsViewController, @selector(busyController), (IMP)&_logos_method$_ungrouped$SSSScreenshotsViewController$busyController, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIAlertController*)); class_addMethod(_logos_class$_ungrouped$SSSScreenshotsViewController, @selector(setBusyController:), (IMP)&_logos_method$_ungrouped$SSSScreenshotsViewController$setBusyController, _typeEncoding); } Class _logos_class$_ungrouped$SSSDittoDismissTimer = objc_getClass("SSSDittoDismissTimer"); MSHookMessageEx(_logos_class$_ungrouped$SSSDittoDismissTimer, @selector(_timerFired), (IMP)&_logos_method$_ungrouped$SSSDittoDismissTimer$_timerFired, (IMP*)&_logos_orig$_ungrouped$SSSDittoDismissTimer$_timerFired);} }
#line 312 "Tweak.xm"

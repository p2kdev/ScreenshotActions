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


static BOOL shouldStopTimer = NO;

%hook SSSContainerViewController

%property (nonatomic,retain) UIAlertController* busyController;

	- (void)_handlePileLongPress:(UIGestureRecognizer*)arg1
	//- (void)_pileTapped
	{
		shouldStopTimer = YES;
		[self showAlert];
	}

	%new
	- (void)showAlert
	{
		UIAlertController * alert = [UIAlertController
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

	%new
	- (void)showShareSheet
	{
		SSSScreenshotsViewController *screenshotsController = MSHookIvar<SSSScreenshotsViewController *>(self, "_screenshotsViewController");
		[screenshotsController presentActivityViewController];
	}



	%new
	- (void)uploadToImgur
	{
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

	%new
	- (void)displayAlert:(NSString *)arg1
	{
		UIAlertController * errorAlert = [UIAlertController
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

	%new
	- (void)copyImageToClipboard
	{
		UIPasteboard *pb = [UIPasteboard generalPasteboard];
		[pb setData:UIImagePNGRepresentation([UIImage _sss_imageFromScreenshot:MSHookIvar<SSSScreenshotsViewController *>(self, "_screenshotsViewController").currentScreenshot]) forPasteboardType:(__bridge NSString *)kUTTypePNG];
	}

	%new
	- (void)deleteImages
	{
		SSSScreenshotsViewController *screenshotsController = MSHookIvar<SSSScreenshotsViewController*>(self, "_screenshotsViewController");
		//iOS12
		if ([self respondsToSelector:@selector(screenshotsViewController:requestsDeleteForScreenshots:forReason:)])
			[self screenshotsViewController:screenshotsController requestsDeleteForScreenshots:[screenshotsController visibleScreenshots] forReason:0];
		//iOS11
		else if ([self respondsToSelector:@selector(deleteRequestedForAllScreenshotsFromScreenshotsViewController:animatingDeletion:)])
		  [self deleteRequestedForAllScreenshotsFromScreenshotsViewController:screenshotsController animatingDeletion:YES];
		//iOS13
		else if ([self respondsToSelector:@selector(screenshotsViewController:requestsDeleteForScreenshots:deleteOptions:forReason:)])
			[self screenshotsViewController:screenshotsController requestsDeleteForScreenshots:[screenshotsController visibleScreenshots] deleteOptions:0 forReason:0];

		[self dismissScreenshotsAnimated:YES completion:nil];
	}

%end

@interface UIAlertController (SSActions)
	-(NSMutableArray *)_actions;
	-(NSArray*)actions;
	-(void)_removeAllActions;
	-(void)_setActions:(id)arg1;
@end

%hook SSSScreenshotsViewController

%property (nonatomic,retain) UIAlertController* busyController;

	- (void)_showActionSheetForDoneButton:(id)arg1
	{
		%orig;
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

	%new
	- (void)uploadToImgur
	{
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

	%new
	- (void)displayAlert:(NSString *)arg1
	{
		UIAlertController * errorAlert = [UIAlertController
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
%end

%hook SSSDittoDismissTimer
	- (void)_timerFired
	{
		if (shouldStopTimer)
		{
			// NSTimer *timer = MSHookIvar<NSTimer*>(self,"_currentTimer");
			// [timer invalidate];
			// timer = nil;
			return;
		}

		%orig;
	}
%end

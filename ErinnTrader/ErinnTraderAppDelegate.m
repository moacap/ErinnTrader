
#import "ErinnTraderAppDelegate.h"

@implementation ErinnTraderAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize launcherViewController = _launcherViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)dealloc {
  self.launcherViewController = nil;
  self.navigationController = nil;
  self.window = nil;
  [super dealloc];
}

@end

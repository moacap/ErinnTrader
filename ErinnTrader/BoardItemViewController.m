
#import "BoardItemViewController.h"
#import "BoardViewDataSource.h"

@interface BoardItemViewController ()
- (void)initView;
- (void)layoutView;
@end

@implementation BoardItemViewController

@synthesize boardItem = _boardItem;
@synthesize titleLabel = _titleLabel;
@synthesize detailText = _detailText;

#pragma mark -
#pragma mark Private Methods

- (void)initView {
  self.view = [[[TTView alloc] initWithFrame:TTScreenBounds()] autorelease];
  self.titleLabel = [[UILabel alloc] init];
  self.detailText = [[UITextView alloc] init];
  self.detailText.editable = NO;
  [self.view addSubview:self.titleLabel];
  [self.view addSubview:self.detailText];
}

- (void)layoutView {
  self.view.backgroundColor = [UIColor lightGrayColor];
  self.titleLabel.frame = CGRectMake(0, 0, 320, 44);
  self.detailText.frame = CGRectMake(0, 45, 320, 400);
  
  self.titleLabel.text = self.boardItem.title;
  self.detailText.text = self.boardItem.content;
}

#pragma mark -
#pragma mark Inherit Methods

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query { 
  self = [super init];
  if (self) {
    self.boardItem = (BoardItem *)[query objectForKey:@"item"];
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)loadView {
  [super loadView];
  [self initView];
  [self layoutView];
}


- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [super dealloc];
}

@end

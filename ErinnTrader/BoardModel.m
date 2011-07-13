
#import "BoardModel.h"
#import "BoardItem.h"

static NSString* const kServiceBaseURL  = @"http://kuku-api.heroku.com/";
static NSString* const kServiceEndPoint = @"erinn_trader/board/";
static NSString* const kLabelMari       = @"mari/";
static NSString* const kLabelRuari      = @"ruari/";
static NSString* const kLabelTarlach    = @"tarlach/";
static NSString* const kLabelMorrighan  = @"morrighan/";
static NSString* const kLabelCichol     = @"cichol/";
static NSString* const kLabelTriona     = @"triona/";

@interface BoardModel ()
- (NSString *)resourcePath;
@end

@implementation BoardModel

@synthesize boardItems = _boardItems;
@synthesize searchQuery = _searchQuery;

#pragma -
#pragma Private Methods

////////////////////////////////////////////////////////////////////////////////
// Logic

- (NSString *)resourcePath {
  return [NSString stringWithFormat:@"%@%@%@%@", 
          kServiceBaseURL, kServiceEndPoint, kLabelMari, [self.searchQuery encodeString:NSUTF8StringEncoding]];
}

#pragma -
#pragma Inheritance Methods

- (id)init {
  self = [super init];
  if (self) {
    self.boardItems = [[NSMutableArray array] retain];
    self.searchQuery = @"";
  }
  return self;
}

- (id)initWithSearchQuery:(NSString *)searchQuery {
  self = [super init];
  if (self) {
    self.boardItems = [[NSMutableArray array] retain];
    self.searchQuery = searchQuery;
    [[TTURLCache sharedCache] removeURL:self.resourcePath fromDisk:YES];
  }
  return self;
}

- (void) dealloc {
  self.searchQuery = nil;
  self.boardItems = nil;
  [super dealloc];
}

#pragma -
#pragma TTURLRequestModel Methods

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  if (!self.isLoading) {
    [self.boardItems removeAllObjects];
    
    TTURLRequest* request = [TTURLRequest requestWithURL:self.resourcePath delegate:self];
    request.cachePolicy = cachePolicy;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    request.response = [[[TTURLJSONResponse alloc] init] autorelease];
    
    [request send];
  }
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
  TTURLJSONResponse* response = request.response;
  NSArray *elements = response.rootObject;

  int index = 0;
  for (NSDictionary *element in elements) {
    BoardItem *item = [[[BoardItem alloc] init] autorelease];
    item.id         = index;
    item.title      = [element objectForKey:@"title"];
    item.author     = [element objectForKey:@"author"];
    item.content    = [element objectForKey:@"content"];
    item.published  = [[element objectForKey:@"published"] intValue];
    [self.boardItems addObject:item];
    index++;
  }

  [super requestDidFinishLoad:request];
}

@end
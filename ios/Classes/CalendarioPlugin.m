#import "CalendarioPlugin.h"
#if __has_include(<calendario/calendario-Swift.h>)
#import <calendario/calendario-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "calendario-Swift.h"
#endif

@implementation CalendarioPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCalendarioPlugin registerWithRegistrar:registrar];
}
@end

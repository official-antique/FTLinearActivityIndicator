#import <UIKit/UIKit.h>

@interface FTLinearActivityIndicator : UIView {
  CAGradientLayer *leftGradient, *rightGradient;
  CABasicAnimation *leftAnimation, *rightAnimation;
}

@property (nonatomic, assign) BOOL hidesWhenStopped;
@property (nonatomic, assign) BOOL animating;

-(void) startAnimating;
-(void) stopAnimating;
@end
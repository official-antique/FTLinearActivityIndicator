#import "FTLinearActivityIndicator.h"

@implementation FTLinearActivityIndicator
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    self.hidesWhenStopped = YES;
    self.animating = NO;

    leftGradient = [CAGradientLayer layer];
    rightGradient = [CAGradientLayer layer];

    leftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    rightAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
  } return self;
}

-(void) layoutSubviews {
  [super layoutSubviews];

  [self setClipsToBounds:YES];
  [self.layer setCornerRadius:self.bounds.size.height * 0.5];

  if(self.hidesWhenStopped) {
    [self setHidden:!self.animating];
  }

  [self.layer addSublayer:leftGradient];
  [self.layer addSublayer:rightGradient];
}

-(void) startAnimating {
  self.animating = YES;

  UIColor *color = [self.tintColor colorWithAlphaComponent:0.7];
  UIColor *clear = [self.tintColor colorWithAlphaComponent:0];

  leftGradient.colors = @[(id)[clear CGColor], (id)[color CGColor]];
  leftGradient.startPoint = CGPointMake(0.5, 0);
  leftGradient.endPoint = CGPointMake(1, 0);
  leftGradient.anchorPoint = CGPointMake(0, 0);
  leftGradient.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
  leftGradient.cornerRadius = self.bounds.size.height * 0.5;
  leftGradient.masksToBounds = YES;

  leftAnimation.fromValue = @(-self.bounds.size.width);
  leftAnimation.toValue = @(self.bounds.size.width);
  leftAnimation.duration = 1.5;
  leftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  leftAnimation.repeatCount = INFINITY;
  leftAnimation.removedOnCompletion = NO;
  [leftGradient addAnimation:leftAnimation forKey:@"leftAnimation"];

  rightGradient.colors = @[(id)[clear CGColor], (id)[color CGColor]];
  rightGradient.startPoint = CGPointMake(0.5, 0);
  rightGradient.endPoint = CGPointMake(0, 0);
  rightGradient.anchorPoint = CGPointMake(0, 0);
  rightGradient.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
  rightGradient.cornerRadius = self.bounds.size.height * 0.5;
  rightGradient.masksToBounds = YES;

  rightAnimation.fromValue = @(self.bounds.size.width);
  rightAnimation.toValue = @(-self.bounds.size.width);
  rightAnimation.duration = 1.5;
  rightAnimation.timeOffset = 0.5 * 1.5;
  rightAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  rightAnimation.repeatCount = INFINITY;
  rightAnimation.removedOnCompletion = NO;
  [rightGradient addAnimation:rightAnimation forKey:@"rightAnimation"];

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

-(void) stopAnimating {
  self.animating = NO;

  [leftGradient removeAllAnimations];
  [rightGradient removeAllAnimations];

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

-(void) tintColorDidChange {
  [super tintColorDidChange];

  if(self.animating) {
    [self startAnimating];
  } else {
    [self startAnimating];
    [self stopAnimating];
  }
}
@end

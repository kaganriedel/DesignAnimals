//
//  GameViewController.m
//  DesignAnimals
//
//  Created by Kagan Riedel on 8/20/14.
//  Copyright (c) 2014 612 Development. All rights reserved.
//

#import "GameViewController.h"
#import "Animal.h"

@interface GameViewController () <UITextFieldDelegate>

#pragma mark - Private Properties

@property (strong, nonatomic) NSTimer *gameTimer;

@property (strong, nonatomic) Animal *gameAnimal;

@property (nonatomic) BOOL gameOn;

@property (strong, nonatomic) NSMutableArray *gameImages;

#pragma mark - IBOutlets

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@property (weak, nonatomic) IBOutlet UITextField *keyboardField;

@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *images;

@property (weak, nonatomic) IBOutlet UIView *gameView;
@end

@implementation GameViewController

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.keyboardField becomeFirstResponder];
    
    [self startNewGame];
    
    for (UILabel* label in self.labels)
    {
        label.layer.cornerRadius = 3.0;
        label.textColor = [UIColor whiteColor];
    }
}

#pragma mark - GameViewController Methods

- (void)startNewGame
{
    self.playAgainButton.hidden = YES;
    self.gameOn = YES;

    [self updateLabelsWithText:@""];
    self.keyboardField.text = @"";
    self.gameAnimal = [Animal randomAnimal];
    
    //Only show enough labels to fit the name
    [self.labels enumerateObjectsUsingBlock:^(UILabel* label, NSUInteger idx, BOOL *stop)
    {
        label.hidden = idx < self.gameAnimal.name.length ? NO : YES;
    }];
    
    //Hide all the views. This should be changed to self.gameView.subviews removeAllObjects eventually
    self.gameImages = self.images.mutableCopy;
    [self.gameImages enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop){
        view.alpha = 0.0;
    }];
    
    [self showNextGameImage];
    [self.gameTimer invalidate];
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showNextGameImage) userInfo:nil repeats:YES];
}

- (void)showNextGameImage
{
    if (self.gameImages.count == 0)
    {
        [self.gameTimer invalidate];
        [self gameOver];
    }
    
    else
    {
        NSUInteger randomIndex = arc4random() % self.gameImages.count;
        
        UIView* view = self.gameImages[randomIndex];
        [UIView animateWithDuration:1.0 animations:^{
            view.alpha = 1.0;
        }];
        
        [self.gameImages removeObject:view];
    }
}

- (void)gameOver
{
    self.playAgainButton.hidden = NO;
    self.gameOn = NO;
}

- (void)updateLabelsWithText:(NSString*)text
{
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel* label = self.labels[i];
        
        if (i < text.length)
        {
            label.text = [[text substringWithRange:NSMakeRange(i, 1)] uppercaseString];
        }
        else
        {
            label.text = @"";
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (newLength > self.labels.count || !self.gameOn)
    {
        return  NO;
    }
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)textFieldEditingChanged:(UITextField*)sender
{
    [self updateLabelsWithText:sender.text];
    
    if ([sender.text isEqualToString:self.gameAnimal.name])
    {
        [self gameOver];
    }
}

- (IBAction)playAgainPressed:(id)sender
{
    [self startNewGame];
}

@end

//
//  Animal.h
//  DesignAnimals
//
//  Created by Kagan Riedel on 8/20/14.
//  Copyright (c) 2014 612 Development. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const kAnimalNameBird = @"bird";
static NSString* const kAnimalNameElephant = @"elephant";
static NSString* const kAnimalNameWhale = @"whale";

@interface Animal : NSObject

#pragma mark - Public Properties

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *images;

#pragma mark - Public Methods

+(NSArray*)allAnimalNames;

+(Animal*)animalFromAnimalName:(NSString*)animalName;

+(Animal*)randomAnimal;

@end

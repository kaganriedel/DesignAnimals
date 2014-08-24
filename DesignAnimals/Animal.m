//
//  Animal.m
//  DesignAnimals
//
//  Created by Kagan Riedel on 8/20/14.
//  Copyright (c) 2014 612 Development. All rights reserved.
//

#import "Animal.h"

@implementation Animal

+(Animal*)animalFromAnimalName:(NSString*)animalName
{
    Animal* animal = [[Animal alloc] init];
    animal.name = animalName;
    
    return animal;
}

+(NSArray*)allAnimalNames
{
    return @[
             kAnimalNameBird,
             kAnimalNameElephant,
             kAnimalNameWhale
             ];
}

+(Animal*)randomAnimal
{
    NSArray *allAnimalNames = [Animal allAnimalNames];
    NSUInteger randomIndex = arc4random() % allAnimalNames.count;
    NSString *randomAnimalName = allAnimalNames[randomIndex];
    Animal *randomAnimal = [Animal animalFromAnimalName:randomAnimalName];
    
    return randomAnimal;
}

@end

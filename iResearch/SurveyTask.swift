//
//  SurveyTask.swift
//  iResearch
//
//  Created by ANI on 4/11/17.
//  Copyright © 2017 VizNetwork. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    
    instructionStep.title = "Three Questions"
    instructionStep.text = "Three questions for the Sphinx"
    steps += [instructionStep]
    
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    let nameQuestionStep = ORKQuestionStep(identifier: "NameStep", title: "What's your name?", answer: nameAnswerFormat)
    nameQuestionStep.placeholder = "First Name"
    steps += [nameQuestionStep]
    
    let questQuestionStepTitle = "What is your favorite color?"
    let textChoices = [
        ORKTextChoice(text: "Green", value: 0 as NSNumber),
        ORKTextChoice(text: "Red", value: 1 as NSNumber),
        ORKTextChoice(text: "Blue", value: 2 as NSNumber),
        ORKTextChoice(text: "Purple", value: 3 as NSNumber),
        ORKTextChoice(text: "Black", value: 4 as NSNumber)
    ]
    let questAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    //Q4: Bool

    let boolFormat = ORKAnswerFormat.booleanAnswerFormat()
    let boolStep = ORKQuestionStep(identifier: "BooleanQuestionStep", title: "Is This True?", text: "Be sure to know if it's true or not", answer: boolFormat)
    steps += [boolStep]
    
    //Q5: Scale
    
    let scaleFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 7, defaultValue: 10, step: 1, vertical: true, maximumValueDescription: "Awesome", minimumValueDescription: "Good")
    let scaleStep = ORKQuestionStep(identifier: "ScaleQuestionStep", title: "How awesome is this session?", text: "You know it is.", answer: scaleFormat)
    steps += [scaleStep]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "All done."
    summaryStep.text = "That was easy."
    steps += [summaryStep]

    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}

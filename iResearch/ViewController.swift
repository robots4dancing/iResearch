//
//  ViewController.swift
//  iResearch
//
//  Created by Thomas Crawford on 4/11/17.
//  Copyright © 2017 VizNetwork. All rights reserved.
//

import UIKit
import ResearchKit

class ViewController: UIViewController {
    
    @IBAction func surveyTapped(button: UIButton) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: ORKTaskViewControllerDelegate {
    
    func printResult(id: String, answer: String) {
        print("Step \(id) Answer: \(answer)")
    }
    
    func handleResult(results: [ORKResult]) {
        for result in results {
            guard let stepResult = result as? ORKStepResult else {
                break
            }
            switch stepResult.identifier {
            case "NameStep":
                guard let stepTextResults = stepResult.results as? [ORKTextQuestionResult] else {
                    break
                }
                    for stepTextResult in stepTextResults {
                        printResult(id: stepResult.identifier, answer: stepTextResult.textAnswer!)
                    }
            case "TextChoiceQuestionStep", "ImageChoiceQuestionStep":
                guard let stepTextChoiceResults = stepResult.results as? [ORKChoiceQuestionResult] else  {
                    break
                }
                for stepTextChoiceResult in stepTextChoiceResults {
                    for answer in stepTextChoiceResult.choiceAnswers! {
                        printResult(id: result.identifier, answer: "\(answer)")
                    }
                }
            case "ScaleQuestionStep":
                guard let scaleResults = stepResult.results as? [ORKScaleQuestionResult] else {
                    break
                }
                for result in scaleResults {
                    printResult(id: result.identifier, answer: "\(result.scaleAnswer!)")
                }
            case "BooleanQuestionStep":
                guard let boolResults = stepResult.results as? [ORKBooleanQuestionResult] else {
                    break
                }
                for result in boolResults {
                    printResult(id: result.identifier, answer: "\(result.booleanAnswer!)")
                }
            default:
                print("Step \(result.identifier) ***")
            }
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        print("Got Result")
        switch reason{
        case .completed:
            if let results = taskViewController.result.results {
                print("Results: \(results)")
                handleResult(results: results)
            }
        case .discarded:
            print("Discarded")
        case .failed:
            print("Failed")
        case .saved:
            print("Saved")
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
}

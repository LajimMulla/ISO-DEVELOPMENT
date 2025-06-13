
import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?
   
    func getBMIValue() -> String {
  
            let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
            return bmiTo1DecimalPlace
      
    }
    func getAdvice() -> String {
        return bmi?.advice ?? "No Advice"
    }
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
 
    mutating func calculateBMI(height: Float, weight: Float){
        let bmiValue  = weight / ( height * height )
        
        if bmiValue < 18.5{
            print("You are under Weight")
            BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor.red)
        }
        else if bmiValue < 24.9  {
            BMI(value: bmiValue, advice: "You are Fit", color: UIColor.green )
        }else{
            BMI(value: bmiValue, advice: "Eat less Pies", color: UIColor.systemPink )
        }
    }
   
    
}

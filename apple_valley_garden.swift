import UIKit

class FresStartInitiative {
	
	//MARK: Properties
	
	var initiativeName: String
	var description: String
	var goal: String
	var progress: Int
	
	//MARK: Initialization
	
	init(name: String, description: String, goal: String, progress: Int) {
		self.initiativeName = name
		self.description = description
		self.goal = goal
		self.progress = progress
	}
	
	//MARK: Functions
	
	func setProgress(toProgress: Int) {
		self.progress = toProgress
	}
	
	func increaseProgress() {
		self.progress += 1
	}
	
	func getDescription() -> String {
		return self.description
	}
	
	func getGoal() -> String {
		return self.goal
	}
	
	func getProgress() -> Int {
		return self.progress
	}
	
	//MARK: Helper Functions
	
	func printProgress() {
		print("\(initiativeName) is \(progress)% complete")
	}
	
	func printInitiativeInfo() {
		print("\(initiativeName):\n\(description)\nGoal: \(goal)")
	}
}

//MARK: Testing

let freshStart = FresStartInitiative(name: "The Fresh Start Initiative", description: "An initiative to start fresh and make improvements.", goal: "Finish the initiative 100%", progress: 0)

freshStart.printInitiativeInfo()
freshStart.increaseProgress()
freshStart.printProgress()

//MARK: Other Helper Functions

func calculateProgress(forInitiative: FresStartInitiative) -> Int {
	return forInitiative.progress
}

func updateProgress(forInitiative: FresStartInitiative, newProgress: Int) {
	forInitiative.setProgress(toProgress: newProgress)
}

func printProgressSummary(forInitiative: FresStartInitiative) {
	print("\(forInitiative.initiativeName) is \(forInitiative.progress)% complete")
}
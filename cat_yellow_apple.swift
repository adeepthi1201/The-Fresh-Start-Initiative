import UIKit

class FreshStartInitiative {
    
    // MARK: Properties
    private let organizationName: String
    private var initiativeGoals: [String]?
    
    // MARK: Initialization
    init(organizationName: String, initiativeGoals: [String]? = nil) {
        self.organizationName = organizationName
        self.initiativeGoals = initiativeGoals
    }
    
    // MARK: Methods
    func addGoal(goal: String) {
        initiativeGoals?.append(goal)
    }
    
    func removeGoal(at index: Int) {
        initiativeGoals?.remove(at: index)
    }
    
    func presentInitiative() {
        guard let goals = initiativeGoals else { return }
        print("\(organizationName) has started The Fresh Start Initiative to:")
        for goal in goals {
            print("- \(goal)")
        }
    }
}

// MARK: - Test Initiative
let initiative = FreshStartInitiative(organizationName: "The Community")
initiative.addGoal(goal: "Help young people develop a learning mindset")
initiative.addGoal(goal: "Enable lives by promoting and teaching basic skills")
initiative.addGoal(goal: "Provide mentorship and guidance to those who seek it")
initiative.removeGoal(at: 1)
initiative.presentInitiative()
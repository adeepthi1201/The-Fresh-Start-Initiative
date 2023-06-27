// FILE: theFreshStartInitiative.js

// Variables
var freshStartInitiative = {
  participants: [],
  totalParticipants: 0,
  eligibleParticipants: 0
};

// Helper functions
function getRandomIntInRange(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Main program
function startFreshStartInitiative() {
  // Initialize participants
  for (var i = 0; i < 1000; i++) {
    freshStartInitiative.participants.push({
      id: i,
      status: 'single',
      income: getRandomIntInRange(10000, 100000)
    });
  }

  freshStartInitiative.totalParticipants = freshStartInitiative.participants.length;

  // Eligibility
  freshStartInitiative.participants.forEach(function(participant) {
    if (participant.status === 'single' && participant.income < 30000) {
      freshStartInitiative.eligibleParticipants++;
    }
  });

  // Assign benefits
  freshStartInitiative.participants.forEach(function(participant) {
    if (participant.status === 'single' && participant.income < 30000) {
      participant.benefits = {
        housing: true, 
        food: true, 
        medical: true, 
        job: true, 
        education: true
      };
    }
  });
}

// Program execution
startFreshStartInitiative();
console.log('The Fresh Start Initiative has been launched with ' + freshStartInitiative.totalParticipants + ' participants and ' + freshStartInitiative.eligibleParticipants + ' eligible participants.');
#include <iostream>
#include <string>

using namespace std;

// The Fresh Start Initiative
// A program to provide youth in a local community with access to resources,
// educational opportunities, and job skills training

// Main function
int main()
{
 // Declare Variables
 string community;
 int population;
 int goals;
 
 // User input
 cout << "What is the name of the local community?: ";
 cin >> community;
 cout << "What is the population size of the community?: ";
 cin >> population;
 cout << "How many goals are you setting for The Fresh Start Initiative?: ";
 cin >> goals;

 // Logic for success
 if (population >= 1000)
 {
   cout << "The Fresh Start Initiative will be successful if there are more than 1000 people in the " << community << " community." << endl;
  }
  else
  {
    cout << "The Fresh Start Initiative will not be successful if there are less than 1000 people in the " << community << " community." << endl;
  }

// Logic for goals
  if (goals >= 3)
  {
    cout << "The Fresh Start Initiative will be successful if there are at least 3 goals set." << endl;
  }
  else
  {
    cout << "The Fresh Start Initiative will not be successful if there are less than 3 goals set." << endl;
  }

// Output
 cout << "The Fresh Start Initiative will provide youth in the " << community << " community with access to resources, educational opportunities, and job skills training." << endl;
  
 // Terminate Program
 return 0;
}
#include <iostream>
#include <string>
#include <fstream>
using namespace std;

// Main function to start the program
int main()
{
	// Create two strings
	string title;
	string body;
 
	// Create an output file
	ofstream file;
	file.open("TheFreshStartInitiative.txt");
 
	// Prompt user to enter title
	cout << "Enter the title of the Fresh Start Initiative: ";
	getline(cin, title);
 
	// Prompt user to enter body
	cout << "Enter the body of the Fresh Start Initiative: ";
	getline(cin, body);
 
	// Write the title to the file
	file << title << endl;
 
	// Write the body to the file
	file << body << endl;
 
	// Close the file
	file.close();
 
	// Output to the console to confirm success
	cout << "The Fresh Start Initiative has been saved to a file." << endl;
 
	// Return 0 to indicate successful completion
	return 0;
}
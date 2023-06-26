#include <stdio.h>
#include <math.h>
 
// Global declarations
int g_budget;
double g_annualSavings;
 
// Function declarations
int applyForFunding();
double calculateProjectCosts(int labor, int materials);
void volunteerTime();
 
int main()
{
    // Initialize global variables
    g_budget = 50000;
    g_annualSavings = 0.0;
 
    // Reduce costs and apply for more funding
    g_budget -= applyForFunding();
    g_annualSavings = calculateProjectCosts(200, 3500);
    g_budget += applyForFunding();
 
    // Volunteer time and resources
    volunteerTime();
 
    // Print results
    printf("The Fresh Start Initiative\n");
    printf("------------------------\n");
    printf("Budget: %d\n", g_budget);
    printf("Annual savings: %.2f\n", g_annualSavings);
 
    return 0;
}
 
int applyForFunding()
{
    int additionalFunding = 10000;
 
    printf("Applied for additional funding of %d\n", additionalFunding);
 
    return additionalFunding;
}
 
double calculateProjectCosts(int labor, int materials)
{
    double projectCosts = labor * 15 + materials * 0.25;
    double annualSavings = projectCosts * 0.75;
 
    printf("Project costs: %.2f\n", projectCosts);
    printf("Annual savings: %.2f\n", annualSavings);
 
    return annualSavings;
}
 
void volunteerTime()
{
    int hours = 200;
    double volunteerCosts = hours * 10;
 
    printf("Volunteers provided %d hours of labor\n", hours);
    printf("Volunteer costs: %.2f\n", volunteerCosts);
 
    g_annualSavings += volunteerCosts;
}
# Covid-Simulation

Group Name: Future Dr. Fauci(s)

Group Members: Marie Check and Esther Kim

Brief Description:
COVID-19 Spread Simulation

Goal: To use processing to model the spread of Covid-19 in a community. 

Overview: We will start with a simple base simulation, such as tree burning, where depending on transmission rates (using real data from the CDC and other health organizations), there would be a visual representation of people catching Covid or others that don’t. We will then build up on that model by adding multiple variables that can be toggled on and off like modes. One of the variables we will include are the 3 major US vaccines: Johnson+Johnson, Pfizer, and Moderna. Modes will be utilized to simulate a population with only one or all three vaccine types along with an unvaccinated population. We could see how these various factors play a role in spreading or preventing covid when run individually or together. We will add other factors into the model, such as the decrease in effectiveness of the vaccines, the effects of masks on the spread of covid, etc. These will be represented as numbers and/or visually in our simulation.

Link to Prototype and Documentation: https://docs.google.com/document/d/1wrRULuiaHOxXiVJBUzgqQ4qGiGo9hQJetHGIiOBobzc/edit?usp=sharing

Marie's Work Log:
05/23/22--I worked on a skeleton of the Person class. I added all the instance vvraibles that we plan on using and just commented out the ones for future development phases.
05/24/22--I worked on the catchCovid method and its helper method calcCovid. This calculates the chance of someone getting covid based on the number of positive neighbors that they have and their vaccine status (so far, more contingencies will be added later). I also added a parameter to it so that when it is called, I can incorporate the number of covid-posiitve neighbors.
05/25/22--I made accessor methods for the x and y coordinates of the Persons on the screen. I also implemented age into the catchCovid methods, so if a person is elderly then, their chance of getting covid increases by 50%. Lastly, I updated the prototype document to reflect new changes we made.

Esther's Work Log:
5/24/22--I worked on set up, color, key pressed, and vaxType to create the array of Person. This will visualize the data that is being processed and allow the user to change settings. This will set the color for each person and fill in the corresponding pixel box based on the covid status. vaxType is used to set the vaccination status for each person in the 2D array.
5/25/22--I worked on setting up an initial infected portion of the population (randomly chosen). I added a countdown in draw (will probably move it later) to test out the simulation/visualization. I wrote spread in order to push the simulation forward, but it is bugged right now. I worked on neighbors infected for the person class to calculate covid status.

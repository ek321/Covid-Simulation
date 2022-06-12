# Covid-Simulation

Group Name: Future Dr. Fauci(s)

Group Members: Marie Check and Esther Kim

Brief Description:
COVID-19 Spread Simulation

Goal: To use processing to model the spread of Covid-19 in a community. 

Overview: We will start with a simple base simulation, such as tree burning, where depending on transmission rates (using real data from the CDC and other health organizations), there would be a visual representation of people catching Covid or others that don’t. We will then build up on that model by adding multiple variables that can be toggled on and off like modes. One of the variables we will include are the 3 major US vaccines: Johnson+Johnson, Pfizer, and Moderna. Modes will be utilized to simulate a population with only one or all three vaccine types along with an unvaccinated population. We could see how these various factors play a role in spreading or preventing covid when run individually or together. We will add other factors into the model, such as the decrease in effectiveness of the vaccines, the effects of masks on the spread of covid, etc. These will be represented as numbers and/or visually in our simulation.

Link to Prototype and Documentation: https://docs.google.com/document/d/1wrRULuiaHOxXiVJBUzgqQ4qGiGo9hQJetHGIiOBobzc/edit?usp=sharing

Compile/Run Instructions:
1. Once the sketch from processing is running, there will be a side menu on the right of the screen. The black portion will display the simulation.
2. Modes can be chosen on the side menu using the buttons. The blue letters will display which options have been chosen.
  - Under vax mode, prevax will distribute no vaccines to the population, while vax mode will.
  - Vax type determines the type of vaccine being distributed. The choice all will randomly choose the type of vaccines given to each person vaccinated. This can only be chosen when vax mode is on.
  - Boost mode will determine whether a booster shot is available to the population. If yes, people will periodically be given a booster shot.
  - Mask mode will determine whether or not masks are available to the public. This mode can be turned on regardless of whether vax mode is on or off.
  - There is an option to visualize the spread of covid through color or sign.
    * With color mode:
      - Blue = doesn't have covid
      - Orange = has covid (can spread covid to others)
      - Green = recovery period (doesn't spread covid to others, is immune to catching covid)
      - Gray = deceased
    * With sign mode:
      - "-" = doesn't have covid
      - "+" = has covid (can spread covid to others)
      - "," = recovery period (doesn't spread covid to others, is immune to catching covid)
      - "." = deceased
3. Once the desired modes are chosen, the simulation can be started by the start/pause button under settings.
  - The add time button will increase the amount of time the simulation runs for, while the remove time button will decrease it. The length of the simulation can be seen under simulation statistics, the simulation stop time.
4. You may pause and continue the simulation with the start/pause button at any time.
5. Once the simulation ends, it can be restarted by the restart button under system settings.
6. Simulation statistics will display general information about the simulation.
  - The density of the population can be changed by the buttons next to it.
8. Pressing on a person in the simulation will display information about them under the simulation statistics.

Marie's Work Log:
05/23/22--I worked on a skeleton of the Person class. I added all the instance vvraibles that we plan on using and just commented out the ones for future development phases.
05/24/22--I worked on the catchCovid method and its helper method calcCovid. This calculates the chance of someone getting covid based on the number of positive neighbors that they have and their vaccine status (so far, more contingencies will be added later). I also added a parameter to it so that when it is called, I can incorporate the number of covid-posiitve neighbors.
05/25/22--I made accessor methods for the x and y coordinates of the Persons on the screen. I also implemented age into the catchCovid methods, so if a person is elderly then, their chance of getting covid increases by 50%. Lastly, I updated the prototype document to reflect new changes we made.
05/27/22--I added boosted and mask modes to the simulation. This included updating the constructors for the Person class and added methods to determine the impact that wearing a mask or being boosted would have on a Peron's chance of catching covid.
05/31/22--I started the setup page.
06/01/22--I designed the setup page and had it display the modes that the user chose. I also fixed the keyPressed method.
06/02/22--I added more to the setup page and also fixed the way that the vaccine modes were triggered.
06/03/22--I fixed the counter for percent infected of the population, and tried to fix the percent vaccinated, but it didn't work.
06/04/22--I added a makePop method which sets the vaccination status, type, booster status, or mask status of the population after the user has made their inputs. I also implemented deaths.
06/06/22--I updated the side panel to be more user-friendly and included all of the simulation information in it so that the user can see the stats of the simulation update.
06/07/22--I implemented death as a factor so that a Person has a 20% chance of death if they are elderly and a 10% chance if they are not. I also fixed an error with the way Boost mode was implemented.
06/08/22--I made it so that we can cycle between the modes in the user selection panel. I also started differentiating sign mode and color mode.
06/09/22--I started sign mode, but had trouble erasing and replacing new signs.
06/10/22--I finished sign mode and color mode by updating the key pressed to take new user input.
06/12/22--Updated the prototype and fixed a small issue with sign mode displaying in a larger population. 


Esther's Work Log:
5/24/22--I worked on set up, color, key pressed, and vaxType to create the array of Person. This will visualize the data that is being processed and allow the user to change settings. This will set the color for each person and fill in the corresponding pixel box based on the covid status. vaxType is used to set the vaccination status for each person in the 2D array.
5/25/22--I worked on setting up an initial infected portion of the population (randomly chosen). I added a countdown in draw (will probably move it later) to test out the simulation/visualization. I wrote spread in order to push the simulation forward, but it is bugged right now. I worked on neighbors infected for the person class to calculate covid status.
5/26/22--I fixed the broken timer in draw so that we can slow it down and speed it up. I also added the random element in the person class for catching covid.
5/30/22--I fixed the covid counter in the corner so that I stops going ahead of what is on the screen.
5/31/22--I worked on incorporating a recovery period in the setCovidStatus method. There will be a set amount of time for being infected (and contagious) and recovery (not contagious?) where being infected again will not affect the recovery period.
6/1/22--I worked on fixing errors with the recovery period (in terms of the duration of covid and recovery periods). I also added in the population density factor so that the whole board is not filled with people. I plan to make this adjustable by the user, but for now, it is a fixed number at the start.
6/2/22--I worked on the display person attribute portion in the main tab, so that we can see the attributes of the person that is clicked on, but the helper method needs to be fixed.
6/3/22--I worked on the helper method so that clicking on a person will show their attributes.
6/6/22--I fixed errors in the personal attribute display method and then added the text needed for that method. I also set an end time for the simulation.
6/7/22--I fixed an error where the vaccine type of the person would not show when vax mode was on. I also made a reset function so that pressing r would reset the simulation based on the new settings chosen by the user.
6/8/22--I added a way for the user to adjust the ending time of the simulation and tested the person attribute display method.
6/9/22--I worked on adding a button class so that the user can click buttons rather than keys on the keyboard to change modes/settings.
6/10/22--I fixed the broken button class, so there is buttons for vax mode and vax type.
6/11/22--I added all the buttons and reformatted the text/buttons on the side menu so that it is neat. There are now buttons for all modes and to start/pause the simulation. I also organized the code in the various tabs and added comments for labels. I added buttons to change the population density and also code to randomize the people in the population being infected in the beginning (so not just the left most side; we will decide which one will be in the final version later). Also, I fixed the bug where pressing the button once was calling the button multiple times.
6/12/22--I fixed small errors in the simulation like a switch in the buttons and I added the instructions for the simulation in the ReadMe file.

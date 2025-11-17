Vacations!

Ah! How nice it is to be on vacation!
Well, while we mentally travel, we were asked to model and implement the following requirements using the concepts of the object-oriented paradigm.

Point 1: Places (3 points)

There are different types of places:
- cities: have a certain number of inhabitants, tourist attractions (e.g.: "Obelisco", "Cabildo", "Rosedal", "Caminito") and we know the average number of decibels they have.
- towns: we are interested in the area in km², when they were founded and in which province they are located.
- beach resorts: are a special category, we know the average meters of beach they have, whether the sea is dangerous and whether they have a pedestrian street.

We want to know which places are fun. For all places, this is true if they have an even number of letters. Additionally, for cities, if they have more than 3 tourist attractions and more than 100,000 inhabitants. In the case of towns, we must also consider if they were founded before 1800 or if they are from the Litoral ("Entre Ríos", "Corrientes" or "Misiones"). And in the case of beach resorts we will have to consider if they have more than 300 meters of beach and if the sea is dangerous.

Point 2: People (4 points)

People have preferences for going on vacation:
- some want tranquility, so the place they go to must be tranquil: for a city this means that it has less than 20 decibels, for a town that it is in the province of La Pampa and for a beach resort that it does not have a pedestrian street
- others want fun, so the place they go to must be fun
- there are those who want to go to strange places: these are those whose name has more than 10 letters (for example "Saldungaray")
- and finally those who combine several criteria (if any of the criteria accepts then they decide to go to that place)

We are interested that a person can change their preference simply, as well as add new preferences in the future.

We want to know if a person would go on vacation to a place based on their preference.

Point 3: Tour (4 points)

We want to establish the following flow for a tour:
- Initially we define a departure date, the required number of people, a list of places to visit and the amount to be paid per person
- Then we add a person, for which
  o the amount to be paid must be appropriate for the person: each person defines a maximum budget to go on vacation
  o all the places must be suitable for the person, according to what is defined in the previous point
  o otherwise the person cannot join the tour
- when we reach the required number of people, the tour is confirmed and no more people are allowed to join, unless someone wants to get off (you must implement the way to achieve this)

Point 4: Reports (3 points)

We want to know:
- Which tours are pending confirmation: they are those that have fewer people registered than the tour requires.
- What is the total of the tours that depart this year, considering the amount per person * the number of people.

Delegation and the implementation of declarative solutions will be explicitly considered.

NOTE:
13,25 - 14 => 10,
12,25 - <13,25 => 9,
11,50 - < 12,25 => 8,
10,50 - < 11,50 => 7,
9 - < 10,50 => 6,
8 - 9 Review,
5 - < 8 => 4,
< 5 => 2.
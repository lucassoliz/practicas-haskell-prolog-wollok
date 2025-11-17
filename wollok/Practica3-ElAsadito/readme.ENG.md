The Barbecue

It's a beautiful day. Around the table, several friends including Facu, Moni, Osky and Vero are ready to share a barbecue among friends. We ask you to help model this situation using the OO paradigm.

Point 1) Could you pass me the salt? - 3 points
Each person knows their position and which items are near them: salt, oil, vinegar, aceto, olive, a knife that cuts well, etc.
We want to model that one diner asks another to pass them an item.

If the other person does not have the item, the operation cannot be performed.

What happens depends on each person's criterion:
- some are "deaf", they pass the first item they have at hand
- others pass all the items, "that way you let me eat in peace"
- others ask to swap positions at the table, "so I can chat with other people" (both swap positions: A must go to B's position and vice versa)
- and finally there are people who pass the requested item to the other diner

We want it to be possible to add new criteria in the future and to allow a person to change their criterion dynamically (for example, change from giving everything to being "deaf"). When a person passes an item to another, that item ceases to be near the original diner and becomes near the diner who requested it.

Point 2) Time to eat - 4 points
Occasionally a tray with a food item is passed around, which tells you how many calories it has and whether it is meat; for example: "Pechito de cerdo" (pork rib), if it is meat and contains 270 calories. Each person decides whether they want to eat it; if they do, they record what they ate. The decision to eat or not depends on how they choose, which can be:

- vegetarian: only eats what is not meat
- dietetic: eats what contains less than 500 calories; we want to be able to configure this for everyone who chooses this strategy based on what the WHO (World Health Organization) recommends
- alternating: accepts and rejects alternately each food
- a combination of conditions, where all must be satisfied to accept the food

We want each diner to be able to change their criterion at any time and we want it to be easy to incorporate new food-choice criteria, as well as to avoid repeating the same idea over and over.

Point 3) Stuffed - 2 points
We want to know if a diner is "stuffed" (pipón); this occurs if any of the foods they consumed is heavy (contains more than 500 calories).

Point 4) I'm having a great time! - 3 points
We want to know if a diner is having a good time at the barbecue; this generally occurs if that person ate something and:
- Osky has no objections, he always has a good time
- Moni if she sat at the table in position 1
- Facu if he ate meat
- Vero if she does not have more than 3 items nearby

Point 5) In theory... - 2 points
Indicate a place where you used:
- polymorphism
- inheritance
- composition

Justify why and what advantages it gave.

14 points => 10,
13 or 12 => 9,
11 => 8,
10 => 7,
9 or 8 => 6,
7 => 4,
6 => 3,
less than 6 => 2.
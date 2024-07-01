* In this first lesson, you're going to be building the foundation for a fantasy world where the SuiFrens hang out, play different games, and evolve together.

* We'll create a fren_group Move module with the following features:

* Create new SuiFrens via a function. The first Fren type weâll start out with is Baby Shark. Keep track of all the SuiFrens that have been born. Each SuiFren will be unique with its own appearance. You can see various aspects of their appearance can change and create unique SuiFrens - body, ear, belly, emotion, etc. Each SuiFren has a level field that denotes the SuiFrenâs power. In later courses, we'll make our Sui Fren world more exciting with power upgrades, evolution, and breeding of new Fren types. In order to generate a unique appearance for each SuiFren, we'll randomly generate the properties. There are generally two ways to do this:

- Generate each SuiFren off-chain and only randomize the id of the SuiFrens people receive. Each Sui Fren is then generated off-chain with unique combination of aspects and associated with a specific id. This allows each person to receive their own unique SuiFren.
- Generate a single random number on-chain that can be parsed into different attributes. We'll focus on this in our journey to explore Move together.
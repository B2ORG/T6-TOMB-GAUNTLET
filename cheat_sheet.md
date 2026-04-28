# Challenge list

| Round | Name | Description |
| :---: | :--- | :--- |
| 1 | Power outage | The team must activate a generator by the end of the round. |
| 2 | Sabertooth | The team may only kill zombies using melee weapons. |
| 3 | Anchored | The team's movement is restricted until all zombies in the round are killed. |
| 4 | One pint, mate | You must have an active perk at the end of the round. |
| 5 | Bless the RNG gods | You must obtain a weapon from the Mystery Box by the end of the round. |
| 6 | Where are my keys? | The team must dig up a specified number of dig piles by the end of the round. |
| 7 | Shit got personal | The team must kill a specified number of zombies with melee attacks by the end of the round. |
| 8 | Stay healthy | You must have the Jugger-Nog perk at the end of the round. |
| 9 | German tech | The team may only kill zombies using the MP40. |
| 10 | You took an arrow to the knee | The team's ability to jump is restricted until all zombies in the round are killed. |
| 11 | POV: You're a cheap bastard | The team is not allowed to spend any points. |
| 12 | Gimme my magic stick | The team must fulfill the staff upgrade objective by the end of the round. |
| 13 | Leg day | You lose points, ammo, or health while standing still. |
| 14 | They're on crack | The team must survive a round with faster and stronger zombies. |
| 15 | Vibe killing | The round can only be progress if all 6 generators are on and uninterrupted. |
| 16 | Metal overdose | The team must survive a round with Panzer Soldats. |
| 17 | So you've got a shovel | The team must dig up a specified number of dig piles by the end of the round. |
| 18 | Fast AF boiii | The team must survive a round with sped-up time. |
| 19 | German tech | The team may only kill zombies using the MP40. |
| 20 | Say your prayers | The team must reach the church by Generator 6 and defend it. |
| 21 | The drunk monk | You must have a specified number of active perks at the end of the round. |
| 22 | Hungover | The perks are taken away, and the team cannot repurchase them until the end of the round. |
| 23 | Bob the Builder | The team must kill a zombie using equipment from all 4 action slots. |
| 24 | Behind Closed Doors | The team may only kill zombies with weapons available in the first room. |
| 25 | No touching grass | The team may only kill zombies while indoors. |
| 26 | Ammo is taxed | You consume twice as much ammo. |
| 27 | Hands off | The team may not pick up any power-ups, and there are many of them. |
| 28 | 2013 strats | The team must kill a specified number of zombies with the tank. |
| 29 | Gun game | The team must survive with a randomized loadout. |
| 30 | Grand finale | The team must reach the chamber in the center of the map (beneath Pack-a-Punch) and survive. |

Extra details about specific rounds are at the bottom of the document.

# Second chance

Second chance rolls the game back to the beginning of the round upon failing a challenge. On solo, player uses up a QR. On coop, players have independent count of second chances, look forward for in-game message about being awarded one.

# Game rules

The game rules have been changed in relation to default Origins logic

## Generators

Set rounds: 10, 21, 24, 28

## Panzers

Set rounds: 8, 12, 16, 20, 24, 28, 30

## Weather

| Round | Weather |
| :---: | :---: |
| 5 | Rain |
| 6 | Snow |
| 7 | Snow |
| 8 | Clear |
| 9 | Rain |
| 10 | Snow |
| 11 | Clear |
| 12 | Clear |
| 13 | Rain |
| 14 | Snow |
| 15 | Snow |
| 16 | Rain |
| 17 | Rain |
| 21 | Clear |
| 25 | Rain |

## Mystery box

- Box always starts in Generator 2 bunker
- RayGun & RayGun Mark 2 are permanently removed from the box
- On rounds 5, 10 and 15, the chances of getting monkeys from the box is dramatically increased, it starts on 69% and goes up by 10% (max to 99%) each hit. Once someone receives monkeys, the chances go to normal on that round.

## Powerups

| Round | Behavior |
| :---: | :--- |
| 2 | Nukes are disabled |
| 4 | First drop is double points (coop only) |
| 9 | Nukes are disabled |
| 15 | Nukes are disabled |
| 19 | Nukes are disabled |
| 23 | First drop is max ammo |
| 24 | Nukes are disabled |
| 27 | Drop limit is removed (check challenge details) |
| 30 | Drops from zombies are disabled (check challenge details) |

## Maxis drone

On following rounds, maxis drone will be recalled at the beginning of the round, to prevent it from attacking zombies: 2, 9, 19, 24, 29

## Digs

- On round 12, there's extra 50% chances of digging up a zombie
- On round 17, players are guaranteed to receive golden shovel if they dig at least once

## Craftables

- On round 29, all craftables are disabled (they cannot be picked up or built). Everything except for staffs can be picked up and build once round 29 is complete.

# Challenge details

Some extra info and tips about specific challenges

## 4. One pint, mate

Each player has to have the perk

## 5. Bless the RNG gods

Each player has to obtain at least one

## 6. Where are my keys?

The amount of digs is equal to the player count (max: 4)

## 7. Shit got personal

The amount of zombies to kill is 6 on solo and 12 for coop for any amount of players

## 8. Stay healthy

Each player has to have the perk

## 9 and 19 German tech

MP40 with stock also counts

## 10. You took an arrow to the knee

Jumping is disabled, and gspeed value is reduced by `20` which makes movement slower

## 12. Gimme my magic stick

For solo and 2 player one staff is required, for 3 players 2 staffs are required. For 4 and more players, 3 staffs are required. As the "soul" from the zombie travels for a while, if last zombie is killed and staff is not already upgraded, the challenge is going to fail.

## 13. Leg day

Each tick it is randomized what will the player lose, health, points or ammo. While reviving, player cannot lose health.

## 14. They're on crack

Zombies are set to their maximum speed and do more damage (4 hit down with jug). They also break through the shield faster.

## 15. Vibe killing

While the generators are attacked, the round count is locked. The generators have a simple approximation mechanism, so by staying in the trench area, only generators 1, 2 and 3 will be attacked. Similarly, the church area can only activate 4, 5 and 6. While in the No Man's Land area closer to trenches, the trench generators can also be triggered. The same generator cannot be attacked twice in a row. The wait time between generator attacks is increased by 4 seconds after each attack.

## 16. Metal overdose

Panzer limit is set to player count + 3, but no more than 7.

## 18. Fast AF boiii

Both timescale and gspeed values are being changed approximately every second. The possible values are rerolled every time from a specified range, the timescale range is 1.4 to 1.8 and gspeed is from 175 to 215.

## 20. Say your prayers

The round cannot be progress until all players are in church. Players who won't make it to the church in time are instakilled.

## 22. Hungover

The perks are not returned after the round, they're lost permanently.

## 23. Bob the Builder

Equipment goal is separate for each player, with the exception of Maxis Drone, which counts for everyone upon getting a kill.

## 24. Behind Closed Doors

All weapons that would be available in a first room game are allowed here, so starting pistol, grenades, first room wallbuys and guns available in a challenge box.

## 25. No touching grass

There's a color overlay if player is in the area that'd cause a fail. The kills are evaluated based on where the player is, not the zombie that's being killed.

## 27. Hands off

The powerups are unlimited.

## 28. 2013 strats

The kill requirement is 24 for solo, 72 for 2p, 96 for 3p and 120 for 4p

## 29. Gun game

Guns are rolled on random interval between 10 and 16 seconds. The weapon has 1 in 8 chances of being upgraded, unless it's a wallbuy, in which case it's 1 in 5.

## 30. Grand finale

Same principle as round 20. Additionally, there are up to 2 panzers respawning throught the round, and natural powerups are disabled. Once the target zone is entered, in 45 second intervals the round "cycles", there are 4 cycles after which the logic repeats. First cycle respawns max ammo. Second respawns insta kill and zombie blood. Third cycle respawns max ammo, and gives eligible players a perk. If after receiving a random perk player has less than 4 perks, he gets one more. Fourth cycle respawns zombie blood, and if there are still zombies remaining to respawn, a nuke is respawned as well. Each cycle there are 20 zombies added to the round count (unless all zombies have respawned).

# Side challenges

Gauntlet has few side challenges, that upon completion grant certain benefits

## Round 3 - Sniper Challenge

Players must keep 100% headshot accuract through the round. If a zombie is hit in any body part other than the head, the challenge is failed. At the end of the round, each player that has not failed the challenge is rewarded 750 points + 250 points for each player that did not fail the challenge, so if in a 2 player game both players maintain 100% headshot accuracy, they will both get 1250 points, however if only one of them succeeds, he'll only get 1000 points.

## Round 6 - Monkey Challenge

At least one zombie must be killed with a monkey bomb. Once completed, the next purchase equal to or above 500 points will be refunded.

## Round 13 - Zone Challenge

At least one player has to kill at least one zombie while being in 7 + 1 per player distinct zones. Once the progress level of this challenge is past 50%, the zone hud will be colored if player is in a zone he's already killed a zombie in before. Each player has a separate progress level, but only one has to complete the challenge to get the reward. The reward is automatically upgraded wallbuy guns if purchased while crouched or prone before round 20. Additionally it makes the Mauser reward be upgraded, and increases changes of getting upgraded guns during gungame from 1 in 8 to 1 in 5 and from 1 in 5 to 1 in 3 respectively.

## Round 18 - Mauser Challenge

If no player is damaged during this round, on round 20 there are free Mausers (1 per player) available to be picked up in church.

## Round 20 - Zombie Blood challenge

This challenge does not by itself require anything, instead it uses progress from previous challenges. It activates at the end of the round, and spawns:
- One zombie blood per player on generator 6 if round 6 challenge has been completed
- One zombie blood per player on either generator 2 or 3 if round 13 challenge has been completed
- One zombie blood per player on either generator 4 or 5 if round 18 challenge has been completed
The zombie blood powerups last until the end of the round.

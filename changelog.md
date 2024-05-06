## Update V0.13.3
### Resprites
* New sprite for Boating License (now Fishing License), done by `@Grassy`.
### Bugfixes
* Fixed Rigged Joker giving more probability than it should on repeating non triggers.
* Fixed Cicero falsely flagging Jokers that should be negative, and vice versa.
* Fixed Nebula not working correctly with Dagonet.
* Fixed Go For Broke spamming the Chips message and softlocking the run.
* Fixed Broke Joker and Go For Broke displaying message upon being sold.
* Fixed Grudgeful and Historical Joker setting Blind requirement below 0.
## Update V0.13.2
### Bugfixes
* Fixed Special Edition Joker crashing.
* Fixed Dagonet only working on Jokers that it's not supposed to work on.
## Update V0.13.1
### Balance Changes
* Monopolist first bonus starts at $10 instead of $25.
* The Sniper now gains X2 Mult instead of X4 Mult, but the score need to be within 10% instead of 5%.
* Abbey Road now requires 5 hands to be played the same amount of times instead of 4.
* Seal Collector now starts at 0 chips instead of 25.
### Bugfixes
* Fixed Monopolist not working with Dagonet, it now no longer gets affected by Dagonet at all.
* Fixed crash that happened when selling Dagonet.
* Fixed Student Loans applying discards from the collection tab.
* Training Wheels now gains 0.1X Mult per 10 scored cards, instead of 0.01 per card, to hopefully fix a floating point error that was happening.
* Fixed Broke Joker and Go For Broke not setting Mult/Chips correctly when using Page Of Pentacles to go back to positive balance.
* Mountain Climber now works correctly with Lucky Cards.
### Other
* Added localization messages to Broke Joker and Go For Broke when their Mult/Chips values change.
* Simplified Aurora Borealis so Blue Seals now give an extra negative Planet Card.
* All Blue Seal related Jokers now function correctly since the new Blue Seal change.
* Printer no longer adds duplicated cards to hand.
## Update V0.13.0
### New Jokers
* Mountain Climber: Every scored card permanently gains +1 Mult.
* Cheapskate: If a Booster Pack is skipped, earn half of it's cost.
   _If you have the possiblity to take 2 cards, you can still take one. Cost get's rounded down_
* Psychic Joker: +150 Chips, destroyed if you play less than 5 cards in one hand.
* Cheat: Retrigger all cards if played hand contains a straight.
* Plus One: Increases rank of scored cards by 1 on the first hand of round.
### Balance Changes
* Student loans now gives -1 discard as soon as the balance is negative, so it's not just a strictly better credit card.
* Blue Moon now requires 3 Lucky Cards to be triggered instead of 4.
* Historical Joker and Grudgeful Joker now lower the blind requirement by the amount of chips they have, instead of giving chips directly.   This means that they will no longer get affected by mult (and will hopefully make them much less op). They both cap at 25% of the current blinds chips.
### Bugfixes
* Fixed Rigged Joker not increasing probabilities.
* Fixed Monopolist updating it's Mult value while in the collection tab.
* Fixed Student Loans giving -1 discard from the collection tab.
* Delayed Joker no longer triggers when cards are discarded by The Hook.
* All starting jokers from any of the modded decks no longer get a random edition. (Thank you SDM!)
### Other
* Added localization message to Pack A Punch.
* Student loans now updates discards in real time.
* Commander is now compatible with Dagonet, allowing you to upgrade 2 cards instead of 1.
* Created a [website](https://mikaschoenmakers.github.io/MikasBalatro/) to show off all Jokers and Consumables based off of the template by `@notmario`.
* The mod now **REQUIRES** lovely to be installed.
## Update V0.12.0
### New Jokers
* Dawn: Retrigger all played cards in first hand of round.
* Savings: +5 Mult per round, resets when buying a card.
* Monopolist: X1 Mult, gains X0.5 Mult per $25, requirement doubles when met.\
   _Ex: once you reach $25 you'll get X1.5 Mult, at $50 X2, at $100 X2.5, etc._
* Nebula: Adds the level of all poker hands to Mult.\
   _Does not count undiscovered hands like Flush House and Five of a Kind until they are discovered_
### Resprites
* New sprites for Bribe (now Incense), Shy Joker (now Training wheels) and Glue, done by `@Grassy`.
### Bugfixes
* Fixed a full_hand crash that happened with other mods.
* Fixed a crash that happened with Deck Creator
### Other
* Added blueprint compatibility for Tax Collector and Glass Cannon.
* Dagonet no longer affects repetitions, since this isn't really a value in any of the jokers description but more of an internal value.
* Pack A Punch now ignores the spending limit, which means that you will go into the negatives if you do not have $20.
## Update V0.11.2
### Resprites
* New sprites for both Tarot cards, done by `@Grassy`.
### Bugfixes
* Fixed Abbey Road not working.
* Fixed wrong odds on Ace of Pentacles.
## Update V0.11.1
### Balance changes
* Bribe's cost now increases by $25 for each usage.
* Tax collector now gives $1, $2 or $4 per rarity, starting at uncommon.
* Fortune's effect is now inverted, meaning that it has a 1/4 chance of setting your money to $0, otherwise it will double your money. This prevents infinite money with Oops All 6s.
* Eye chart now also counts itself for letters in the name.
### Resprites
* New sprite for Lucky Number Seven (now Scratch Card), done by `@Grassy`.
### Bugfixes
* Fixed Checklist not updating the Poker Hand.
* Cicero no longer gives Negative to Misprint and no longer ignores Printer.
* Fixed wrong description of One Of Us.
## Update V0.11.0
### New Jokers
* Pack A Punch: Give the left-most Joker a random Edition when a blind is selected, at the cost of $20. This will replace the current Edition. It also self destructs if it replaces a negative Edition and there are too many Jokers.
* Seal Stealer:  Trigger Purple and Blue seals when they are scored. This works with Harp Seal as well as Planetary Alignment (now Aurora Borealis).
* Tax Collector: Gives $1, $2, $3 or $4 per Joker at the end of the round, based on their rarity.
* Glass Cannon: Retrigger all glass cards, but they are guaranteed to break.
* Scoring Test: If played hand scores less than 1% of blind chip requirement, destroy it.
* Cicero: All Jokers that do not give Mult, Chips or retriggers will be negative in the shop.
### New Tarots
* The Idiot: Multiply your money by -1.
* Fortune: Has a 3/4 chance to double your money with no cap, otherwise set your money to $0.
### New Spectrals
* Bribe: Turn a random Joker Negative but lose $50, ignoring the spending limit.
### Resprites
* New sprite for Planetary Alignment (now Aurora Borealis), The Cultist, What Are The Odds (now Blue Moon), and The Gambler (now Horseshoe), all done by `@Grassy`.
### Other
* Harp Seal now works with Planetary Alignment (now Aurora Borealis).
* Added a Mod Badge, so Steamodded V0.9.7 is required.
## Update V0.10.1
### Balance changes
* Showoff Joker now gains X0.25 Mult instead of X1 Mult.
* Jokers For Hire deck now has a linear cost increase, instead of an exponential one. Example: 2nd joker will cost the base price X2, 3rd joker will cost the base price X3, etc.
    - Riff-raff now costs $1.000.000.000.
### Bugfixes
* Changed blueprint compatibility for a lot of Jokers, meaning they should now work correctly with blueprint.
    - The full list of Jokers that got changed with regards to blueprint is: Cultist, Lucky Number Seven, Delayed Jokers, Showoff, Sniper, Blackjack, Batman, Grudgeful, Historical, Shy joker, Abbey Road, Rigged, What Are The Odds, Stockpiler, Checklist and One Of Us.
* Fixed Incomplete Joker stretching on reload.
### Other
* Changed Jokers (where applicable) to use in game functions to pick random editions, to be more in line with the base game, this means the odds will be the same as the base game as well instead of being evenly spread.
* Now uses the updated joker API for setting the local variables used in localization. This means Steamodded V0.8.2 is **required**.
## Update V0.10.0
### New Jokers
* Added 7 new Jokers, making the total Joker count 45 (3 full pages)
* Detailed ability information can be found in the [readme](https://github.com/MikaSchoenmakers/MikasBalatro?tab=readme-ov-file#mikas-balatro-mod-collection)
### Resprites
* Added a new sprite to The Banker (now Gold Bar), done by `@Grassy`.
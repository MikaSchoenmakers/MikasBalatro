let jokers = [
  // -- LEGENDARY --
  {
    name: "Cicero",
    text: [
      "Jokers that do not",
      "give {C:mult}Mult{}, {C:chips}Chips{} or",
      "{C:attention}retriggers{} will be",
      "{C:dark_edition}negative{} in the shop"
    ],
    image_url: "assets/1x/j_mmc_cicero.png",
    rarity: "Legendary",
    soul: true
  },
  {
    name: "Dagonet",
    text: [
      "{C:attention}Doubles{} all base values",
      "on other Jokers",
      "{C:inactive}(If possible)"
    ],
    image_url: "assets/1x/j_mmc_dagonet.png",
    rarity: "Legendary",
    soul: true
  },
  // -- RARE --
  {
    name: "Batman",
    text: [
      "Gains {C:mult}+1{} Mult for",
      "every {C:attention}non-lethal{} hand played",
      "Mult gain increases for every",
      "Joker with {C:attention}\"Joker\"{} in the name",
      "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_batman.png",
    rarity: "Rare"
  },
  {
    name: "Fishing License",
    text: [
      "{C:attention}Copies{} effects of all",
      "scored {C:attention}Enhanced{} cards",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_fishing_license.png",
    rarity: "Rare"
  },
  {
    name: "The Commander",
    text: [
      "If {C:attention}first hand{} of round",
      "has only {C:attention}1{} card, give it a",
      "random {C:attention}Enhancement{}, {C:attention}Seal",
      "and {C:attention}Edition"
    ],
    image_url: "assets/2x/j_mmc_commander.png",
    rarity: "Rare"
  },
  {
    name: "Cultist",
    text: [
      "{X:mult,C:white}X1{} Mult per hand played",
      "Resets every round",
      "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_cultist.png",
    rarity: "Rare"
  },
  {
    name: "Delayed Joker",
    text: [
      "Gives {C:mult}+20{} Mult, {C:chips}+100{}",
      "Chips and {X:mult,C:white}X1.5{} Mult on",
      "the {C:attention}4th{} action",
      "{C:inactive}(Current action: {C:attention}1{C:inactive})"
    ],
    image_url: "assets/2x/j_mmc_delayed.png",
    rarity: "Rare"
  },
  {
    name: "Grudgeful Joker",
    text: [
      "Lowers blind requirement",
      "with {C:attention}excess Chips{} from",
      "last round. Caps at {C:attention}25%",
      "of current blind's Chips",
      "{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
    ],
    image_url: "assets/2x/j_mmc_grudgeful.png",
    rarity: "Rare"
  },
  {
    name: "Historical Joker",
    text: [
      "If scored cards have the same",
      "{C:attention}ranks{} and {C:attention}order{} as previous",
      "hand, reduce blind requirement",
      "by previous hands {C:chips}Chips{}. Caps at",
      "{C:attention}25%{} of current blind's Chips",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_historical.png",
    rarity: "Rare"
  },
  {
    name: "Monopolist",
    text: [
      "{X:mult,C:white}X1{} Mult, gains",
      "{X:mult,C:white}X0.5{} Mult at {C:money}$10{},",
      "requirement doubles",
      "when met"
    ],
    image_url: "assets/2x/j_mmc_monopolist.png",
    rarity: "Rare"
  },
  {
    name: "Pack A Punch",
    text: [
      "When {C:attention}Blind{} is selected,",
      "lose {C:money}$20{} and give the",
      "{C:attention}left-most{} Joker",
      "a random {C:attention}Edition",
      "{C:inactive}(Will replace current edition)"
    ],
    image_url: "assets/2x/j_mmc_pack_a_punch.png",
    rarity: "Rare"
  },
  {
    name: "Plus One",
    text: [
      "Increases rank",
      "of scored cards by",
      "{C:attention}1{} on the {C:attention}first",
      "{C:attention}hand{} of round"
    ],
    image_url: "assets/2x/j_mmc_plus_one.png",
    rarity: "Rare"
  },
  {
    name: "The Printer",
    text: [
      "If hand scores more than",
      "blind's Chips, {C:attention}duplicate{}",
      "played cards"
    ],
    image_url: "assets/2x/j_mmc_printer.png",
    rarity: "Rare"
  },
  {
    name: "The Show-Off",
    text: [
      "Gains {X:mult,C:white}X0.25{} Mult when",
      "a blind is finished with",
      "{C:attention}X2{} the chip requirement",
      "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_showoff.png",
    rarity: "Rare"
  },
  {
    name: "The Sniper",
    text: [
      "Gains {X:mult,C:white}X2{} Mult when a",
      "blind is finished within {C:attention}10%{} of",
      "the {C:attention}exact{} chip requirement",
      "{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult)",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_sniper.png",
    rarity: "Rare"
  },
  {
    name: "Straight Nate",
    text: [
      "{X:mult,C:white}X4{} Mult if played hand",
      "contains a {C:attention}Straight{} and you have",
      "both {C:attention}Odd Todd{} and {C:attention}Even Steven{}",
      "Gives {C:dark_edition}+1{} Joker slot"
    ],
    image_url: "assets/2x/j_mmc_straight_nate.png",
    rarity: "Rare"
  },
  // -- UNCOMMON --
  {
    name: "Abbey Road",
    text: [
      "If at least {C:attention}5{} poker hands",
      "have been played the same",
      "amount of times, give {X:mult,C:white}X4{} Mult",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_abbey_road.png",
    rarity: "Uncommon"
  },
  {
    name: "Blackjack Joker",
    text: [
      "Gives {X:mult,C:white}X3{} Mult when",
      "the ranks of all played",
      "cards is {C:attention}exactly 21",
      "Gives {X:mult,C:white}X0.5{} Mult less for",
      "every point below 21"
    ],
    image_url: "assets/2x/j_mmc_blackjack.png",
    rarity: "Uncommon"
  },
  {
    name: "Blue Moon",
    text: [
      "If {C:attention}3 Lucky cards{} trigger",
      "in one hand, create a",
      "random {C:dark_edition}negative{} Joker",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_blue_moon.png",
    rarity: "Uncommon"
  },
  {
    name: "Camper",
    text: [
      "Every discarded {C:attention}card{}",
      "permanently gains",
      "{C:chips}+4{} Chips"
    ],
    image_url: "assets/2x/j_mmc_camper.png",
    rarity: "Uncommon"
  },
  {
    name: "Cheat",
    text: [
      "Retrigger all cards",
      "if played hand",
      "contains a {C:attention}Straight{}",
    ],
    image_url: "assets/2x/j_mmc_cheat.png",
    rarity: "Uncommon"
  },
  {
    name: "Checklist",
    text: [
      "Playing {C:attention}High Card{} upgrades",
      "it by 1 level,",
      "poker hand changes",
      "at end of round"
    ],
    image_url: "assets/2x/j_mmc_checklist.png",
    rarity: "Uncommon"
  },
  {
    name: "Dawn",
    text: [
      "Retrigger all played",
      "cards in {C:attention}first",
      "{C:attention}hand{} of round"
    ],
    image_url: "assets/2x/j_mmc_dawn.png",
    rarity: "Uncommon"
  },
  {
    name: "Finishing Blow",
    text: [
      "If a blind is finished",
      "with a {C:attention}High Card{}, randomly",
      "{C:attention}Enhance{} scored cards"
    ],
    image_url: "assets/2x/j_mmc_finishing_blow.png",
    rarity: "Uncommon"
  },
  {
    name: "The Fisherman",
    text: [
      "{C:attention}+1{} hand size per discard",
      "{C:attention}-1{} hand size per hand played",
      "Resets every round",
      "{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
    ],
    image_url: "assets/2x/j_mmc_fisherman.png",
    rarity: "Uncommon"
  },
  {
    name: "Football Card",
    text: [
      "{C:blue}Common{} Jokers",
      "each give {C:chips}+50{} Chips"
    ],
    image_url: "assets/2x/j_mmc_football_card.png",
    rarity: "Uncommon"
  },
  {
    name: "Glass Cannon",
    text: [
      "{C:attention}Retrigger{} all {C:attention}Glass",
      "{C:attention}Cards{}, but they are",
      "{C:red}guaranteed{} to break"
    ],
    image_url: "assets/2x/j_mmc_glass_cannon.png",
    rarity: "Uncommon"
  },
  {
    name: "Harp Seal",
    text: [
      "{C:attention}Doubles{} the effect",
      "of all {C:attention}Seals",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_harp_seal.png",
    rarity: "Uncommon"
  },
  {
    name: "Horseshoe",
    text: [
      "Retrigger all",
      "scored {C:attention}Lucky{} cards",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_horseshoe.png",
    rarity: "Uncommon"
  },
  {
    name: "Impatient Joker",
    text: [
      "{C:mult}+3{} Mult per card discarded",
      "Resets every round",
      "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_impatient.png",
    rarity: "Uncommon"
  },
  {
    name: "Mountain Climber",
    text: [
      "Every played {C:attention}card{}",
      "permanently gains",
      "{C:mult}+1{} Mult when scored"
    ],
    image_url: "assets/2x/j_mmc_mountain_climber.png",
    rarity: "Uncommon"
  },
  {
    name: "One Of Us",
    text: [
      "If played hand",
      "contains {C:attention}5 Enhanced cards,",
      "give a random Joker",
      "a random {C:attention}Edition"
    ],
    image_url: "assets/2x/j_mmc_one_of_us.png",
    rarity: "Uncommon"
  },
  {
    name: "Savings",
    text: [
      "{C:mult}+5{} Mult per round",
      "Resets when",
      "buying a {C:attention}card",
      "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_savings.png",
    rarity: "Uncommon"
  },
  {
    name: "Scoring Test",
    text: [
      "If played hand",
      "scores less than {C:attention}1%",
      "of blind requirement",
      "{C:red}destroy{} it"
    ],
    image_url: "assets/2x/j_mmc_scoring_test.png",
    rarity: "Uncommon"
  },
  {
    name: "Special Edition",
    text: [
      "Gains {C:mult}+2{} Mult per {C:attention}Seal{}, {C:chips}+10{}",
      "Chips per {C:attention}Enhancement{} and {X:mult,C:white}X0.1{} Mult",
      "per {C:attention}Edition{} for every card in deck",
      "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult, {C:chips}+0{C:inactive}, Chips and {X:mult,C:white}X1{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_special_edition.png",
    rarity: "Uncommon"
  },
  {
    name: "Street Fighter",
    text: [
      "Gives {X:mult,C:white}X4{} Mult",
      "when balance is",
      "at or below {C:red}-$20"
    ],
    image_url: "assets/2x/j_mmc_street_fighter.png",
    rarity: "Uncommon"
  },
  {
    name: "Student Loans",
    text: [
      "Go up to {C:red}-$100{} in debt",
      "Gives -1 {C:red}discard{}",
      "for every {C:red}-$25{} in debt",
      "{C:inactive}(Currently {C:attention}-1{C:inactive} discards)"
    ],
    image_url: "assets/2x/j_mmc_student_loans.png",
    rarity: "Uncommon"
  },
  {
    name: "Training Wheels",
    text: [
      "{X:mult,C:white}X1{} Mult, gains {X:mult,C:white}X0.1",
      "Mult per {C:attention}10 card{} scored",
      "{C:inactive}Currently {C:attention}0 {C:inactive}cards scored",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_training_wheels.png",
    rarity: "Uncommon"
  },
  // -- COMMON --
  {
    name: "Aurora Borealis",
    text: [
      "{C:attention}Blue Seals{} give an",
      "extra {C:dark_edition}negative {C:planet}Planet{} card",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_aurora_borealis.png",
    rarity: "Common"
  },
  {
    name: "Bomb",
    text: [
      "Gains {C:mult}+15{} Mult per round",
      "self destructs after {C:attention}3{} rounds",
      "{C:inactive}(Currently {C:mult}+15{C:inactive} Mult)",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_bomb.png",
    rarity: "Common"
  },
  {
    name: "Broke Joker",
    text: [
      "Gains {C:mult}+1{} Mult",
      "per {C:red}-$2",
      "{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
    ],
    image_url: "assets/2x/j_mmc_broke.png",
    rarity: "Common"
  },
  {
    name: "Buy One Get One",
    text: [
      "{C:green}1 in 4{} chance to",
      "get a random {C:attention}extra card{}",
      "of whatever you're buying",
      "{C:inactive}(Must have room)"
    ],
    image_url: "assets/2x/j_mmc_buy_one_get_one.png",
    rarity: "Common"
  },
  {
    name: "Cheapskate",
    text: [
      "If a {C:attention}Booster Pack",
      "is skipped, earn",
      "half of it's {C:money}cost"
    ],
    image_url: "assets/2x/j_mmc_cheapskate.png",
    rarity: "Common"
  },
  {
    name: "Eye Chart",
    text: [
      "Gives {C:chips}+20{} Chips for every",
      "letter {C:attention}\"A\"{} in your Jokers",
      "Letter changes when this",
      "Joker appears in the shop",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_eye_chart.png",
    rarity: "Common"
  },
  {
    name: "Glue",
    text: [
      "If you have both {C:attention}Half",
      "and {C:attention}Incomplete Joker{}, give",
      "{C:dark_edition}+2{} Joker slots and {X:mult,C:white}X5{} Mult",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_glue.png",
    rarity: "Common"
  },
  {
    name: "Go For Broke",
    text: [
      "Gains {C:chips}+4{} Chips",
      "per {C:red}-$1",
      "{C:inactive}(Currently {C:chips}0{C:inactive} Chips)"
    ],
    image_url: "assets/2x/j_mmc_go_for_broke.png",
    rarity: "Common"
  },
  {
    name: "Gold Bar",
    text: [
      "Earn {C:money}$2{} for every",
      "{C:attention}Gold Seal{} and {C:attention}Gold card{}",
      "at end of round",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_gold_bar.png",
    rarity: "Common"
  },
  {
    name: "Incomplete Joker",
    text: [
      "{C:chips}+100{} Chips if played",
      "hand contains",
      "{C:attention}3{} or fewer cards"
    ],
    image_url: "assets/2x/j_mmc_incomplete.png",
    rarity: "Common"
  },
  {
    name: "The Investor",
    text: [
      "Gives {C:money}$5{} at end of",
      "round. {C:green}1 in 4{} chance to",
      "give {C:red}-$5{} instead"
    ],
    image_url: "assets/2x/j_mmc_investor.png",
    rarity: "Common"
  },
  {
    name: "Nebula",
    text: [
      "Adds all {C:attention}poker",
      "{C:attention}hand{} levels above",
      "1 to {C:mult}Mult"
    ],
    image_url: "assets/2x/j_mmc_nebula.png",
    rarity: "Common"
  },
  {
    name: "Prime Time",
    text: [
      "Each played {C:attention}2{},",
      "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
      "{X:mult,C:white}X1.2{} Mult when scored",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_prime_time.png",
    rarity: "Common"
  },
  {
    name: "Psychic Joker",
    text: [
      "{C:chips}+150{} Chips, destroyed",
      "if you play less",
      "than {C:attention}5{} cards",
      "in one hand"
    ],
    image_url: "assets/2x/j_mmc_psychic.png",
    rarity: "Common"
  },
  {
    name: "Rigged Joker",
    text: [
      "Once per hand, add {C:attention}+1{} to all",
      "listed {C:green,E:1,S:1.1}probabilities{} whenever a",
      "{C:attention}Lucky{} card does not trigger",
      "Resets every round"
    ],
    image_url: "assets/2x/j_mmc_rigged.png",
    rarity: "Common"
  },
  {
    name: "Scratch Card",
    text: [
      "Gain {C:money}$1{}, {C:money}$3{}, {C:money}$10{}, {C:money}$25{},",
      "{C:money}$50{} when 1, 2, 3, 4 or 5",
      "{C:attention}7 cards{} are scored,",
      "respectively",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/j_mmc_scratch_card.png",
    rarity: "Common"
  },
  {
    name: "Seal Collector",
    text: [
      "Gains {C:chips}+25{} Chips for",
      "every card with a {C:attention}seal",
      "{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
    ],
    image_url: "assets/2x/j_mmc_seal_collector.png",
    rarity: "Common"
  },
  {
    name: "Seal Steal",
    text: [
      "Played {C:purple}Purple{} and",
      "{C:blue}Blue{} Seals trigger",
      "when {C:attention}scored"
    ],
    image_url: "assets/2x/j_mmc_seal_steal.png",
    rarity: "Common"
  },
  {
    name: "Shackles",
    text: [
      "{C:blue}+1{} hand, {C:red}+1{} discard,",
      "{C:attention}+1{} hand size. Destroyed",
      "if you play more than",
      "{C:attention}4{} cards in one hand"
    ],
    image_url: "assets/2x/j_mmc_shackles.png",
    rarity: "Common"
  },
  {
    name: "The Stockpiler",
    text: [
      "{C:attention}+1{} hand size for every 4",
      "cards in deck above {C:attention}52{}",
      "Caps at the current Ante",
      "{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
    ],
    image_url: "assets/2x/j_mmc_stockpiler.png",
    rarity: "Common"
  },
  {
    name: "Suit Alley",
    text: [
      "{C:diamonds}Diamond{} and {C:clubs}Club{} cards",
      "gain {C:chips}+12{} Chips when scored",
      "{C:hearts}Heart{} and {C:spades}Spade{} cards",
      "gain {C:mult}+3{} Mult when scored"
    ],
    image_url: "assets/2x/j_mmc_suit_alley.png",
    rarity: "Common"
  },
  {
    name: "Tax Collector",
    text: [
      "Gives {C:green}$1{}, {C:red}$2{} or {C:legendary}$4",
      "per Joker with the",
      "respective {C:attention}rarity",
      "at end of round"
    ],
    image_url: "assets/2x/j_mmc_tax_collector.png",
    rarity: "Common"
  }
]

// works the same. 
let consumables = [
  {
    name: "Ace Of Pentacles",
    text: [
      "{C:red}1 in 4{} chance",
      "to set money to",
      "{C:money}$0{}, otherwise",
      "{C:attention}double{} your money",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/c_mmc_ace_of_pentacles.png",
    rarity: "Tarot"
  },
  {
    name: "Page Of Pentacles",
    text: [
      "Multiply",
      "money by {C:red}-1",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/c_mmc_page_of_pentacles.png",
    rarity: "Tarot"
  },
  {
    name: "Incense",
    text: [
      "Add {C:dark_edition}Negative{} to",
      "a random {C:attention}Joker{},",
      "{C:red}-$50{}, ignores",
      "spending limit",
      "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
    ],
    image_url: "assets/2x/c_mmc_incense.png",
    rarity: "Spectral"
  },
]

let card_modifications = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Enhancement"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Edition"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Seal"
  // },
]

let decks = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Deck"
  // },
]

let stickers = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Sticker"
  // },
]

let blinds = [
  // {
  //   name: "The Wall",
  //   text: [
  //     "Extra large blind",
  //     "{C:inactive}({C:red}4x{C:inactive} Base for {C:attention}$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 2)"
  //   ],
  //   image_url: "img/the_wall.png",
  //   rarity: "Boss Blind"
  // },
  // {
  //   name: "Violet Vessel",
  //   text: [
  //     "Very large blind",
  //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 8)"
  //   ],
  //   image_url: "img/violet_vessel.png",
  //   rarity: "Showdown"
  // },
]

let shop_items = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Voucher"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Pack"
  // },
]

let cols = {
  MULT: "#FE5F55",
  CHIPS: "#009dff",
  MONEY: "#f3b958",
  XMULT: "#FE5F55",
  FILTER: "#ff9a00",
  ATTENTION: "#ff9a00",
  BLUE: "#009dff",
  RED: "#FE5F55",
  GREEN: "#4BC292",
  PALE_GREEN: "#56a887",
  ORANGE: "#fda200",
  IMPORTANT: "#ff9a00",
  GOLD: "#eac058",
  YELLOW: "#ffff00",
  CLEAR: "#00000000",
  WHITE: "#ffffff",
  PURPLE: "#8867a5",
  BLACK: "#374244",
  L_BLACK: "#4f6367",
  GREY: "#5f7377",
  CHANCE: "#4BC292",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#5d5dff",
  ETERNAL: "#c75985",
  INACTIVE: "#ffffff99",
  HEARTS: "#f03464",
  DIAMONDS: "#f06b3f",
  SPADES: "#403995",
  CLUBS: "#235955",
  ENHANCED: "#8389DD",
  JOKER: "#708b91",
  TAROT: "#a782d1",
  PLANET: "#13afce",
  SPECTRAL: "#4584fa",
  VOUCHER: "#fd682b",
  EDITION: "#4ca893",
  LEGENDARY: "#b26cbb",
}

let rarities = {
  "Common": "#009dff",
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Joker": "#708b91",
  "Tarot": "#a782d1",
  "Planet": "#13afce",
  "Spectral": "#4584fa",
  "Voucher": "#fd682b",
  "Pack": "#9bb6bd",
  "Enhancement": "#8389DD",
  "Edition": "#4ca893",
  "Seal": "#4584fa",
  "Deck": "#9bb6bd",
  "Sticker": "#5d5dff",
  "Boss Blind": "#5d5dff",
  "Showdown": "#4584fa",
}

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
  for (let joker of jokers) {
    console.log("adding joker", joker.name);

    joker.text = joker.text.map((line) => { return line + "{}" });

    joker.text = joker.text.join("<br/>");
    joker.text = joker.text.replaceAll("{}", "</span>");
    joker.text = joker.text.replace(regex, function replacer(match, p1, offset, string, groups) {
      let classes = p1.split(",");

      let css_styling = "";

      for (let i = 0; i < classes.length; i++) {
        let parts = classes[i].split(":");
        if (parts[0] === "C") {
          css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
        } else if (parts[0] === "X") {
          css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
        }
      }

      return `</span><span style='${css_styling}'>`;
    });

    let joker_div = document.createElement("div");
    joker_div.classList.add("joker");
    if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="hasback" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else if (joker.soul) {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    }

    jokers_div.appendChild(joker_div);
  }
}

if (jokers.length === 0) {
  document.querySelector(".jokersfull").style.display = "none"
} else {
  let jokers_div = document.querySelector(".jokers");
  add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
  document.querySelector(".consumablesfull").style.display = "none"
} else {
  let consumables_div = document.querySelector(".consumables");
  add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
  document.querySelector(".cardmodsfull").style.display = "none"
} else {
  let cardmods_div = document.querySelector(".cardmods");
  add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
  document.querySelector(".decksfull").style.display = "none"
} else {
  let decks_div = document.querySelector(".decks");
  add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
  document.querySelector(".stickersfull").style.display = "none"
} else {
  let stickers_div = document.querySelector(".stickers");
  add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
  document.querySelector(".blindsfull").style.display = "none"
} else {
  let blinds_div = document.querySelector(".blinds");
  add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
  document.querySelector(".shopitemsfull").style.display = "none"
} else {
  let shopitems_div = document.querySelector(".shopitems");
  add_cards_to_div(shop_items, shopitems_div);
}
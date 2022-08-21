Config = {
    UseTarget = true, -- Set to false to not use qb-target

    Items = { -- Add as many items as you want
        [1] = {item = 'metalscrap', amount = math.random(1,5)},
        [2] = {item = 'plastic', amount = math.random(1,5)},
        [3] = {item = 'rubber', amount = math.random(1,5)}
    },

    AdditionalItem = true, -- Set to false to not give an additional item

    AdditionalItems = { -- Add as many additional items as you want, reflects from true/false above
        [1] = {item = 'rubber', amount = math.random(1,5)},
        [2] = {item = 'metalscrap', amount = math.random(1,5)},
        [3] = {item = 'plastic', amount = math.random(1,5)}
    },

    Dumpsters = { -- Models of dumpsters/trash cans to be searchable
        'prop_dumpster_01a',
        'prop_dumpster_02a',
        'prop_dumpster_02b',
        'prop_dumpster_3a',
        'prop_dumpster_4a',
        'prop_dumpster_4b'
    },

    SearchTime = 5, -- Time in seconds it takes to search a dumpster

    Language = { -- Modify this to your own language.
        search = "Press [~g~E~w~] to search the Trash Bin",
        searching = "Searching Dumpster...",
        stopsearch = "You stopped searching...",
        alreadysearched = "You already searched this container",
        dumplabel = "Search Dumpster"
    }
}
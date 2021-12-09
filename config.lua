Config = {}

Config.Items = {
    [1] = "metalscrap",
    [2] = "plastic",
}
Config.ItemAmount = math.random(3,5)
-- Additional Item can be received by 2 chance numbers equaling each other in the server.lua
Config.AddtionalItem = true
Config.AddItem = 'rubber'
Config.AddItemAmount = math.random(1,3)

Config.Dumpsters = {
    218085040,
    666561306,
    -58485588,
    -206690185,
    1511880420,
    682791951
}

Config.SearchTime = math.random(5000,10000)
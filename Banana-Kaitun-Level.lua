repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer
getgenv().Premium  = false   -- Premium mode (true = premium, false = free)
getgenv().FpsBoost = true    -- FPS boost: strip heavy particles & sounds
getgenv().Key      = ""      -- License key (leave "" if none required)
getgenv().Config = {
	["Blox Fruits"] = {
		-- General & Performance
		["Hide UI"]      = false,      -- Hide in-game UI to reduce memory/lag
		["Select Team"]  = "Pirates",  -- Starting team: "Pirates" | "Marines"
		["White Screen"] = false,      -- Blank the screen to minimize GPU load
		["Lock Fps"] = {
			["Enabled"] = true,        -- Cap the frame rate
			["FPS"]     = 15,          -- FPS target (15 = lowest load, 30 = smoother)
		},
		-- Progression
		["Auto Awaken Fruit"] = false,  -- Run Raids to awaken Devil Fruit moves
		["Farm Fragments"] = {
			["Enabled"]  = false,  -- Auto-farm Fragments
			["Fragment"] = 50000,  -- Stop at this fragment amount
		},
		["Farm Mastery"] = {
			["Enabled"]     = false,                        -- Farm Mastery (after max level & milestones)
			["Mode"]        = "Bone",                       -- Area: "Bone" (Haunted Castle) | "Cake" (Cake Island) | "Tiki" (Tiki Outpost)
			["Weapon Farm"] = { "Sword", "Gun", "Blox Fruit" }, -- Weapons to push to Mastery 600
		},
		-- Race
		["Get Race"] = {
			["Race Quest"] = {
				["Enabled"] = false,       -- Auto-reroll until target race is hit
				["Race"]    = { "Ghoul" }, -- Targets: "Ghoul" "Cyborg" "Human" "Mink" "Fishman" "Skypiea"
			},
			["Pull Lever"] = true,  -- Pull Mirage Island lever & upgrade Race V2/V3
		},
		-- Auto Get: Items
		["Get Items"] = {
			["Saber"]              = true,  -- Solve puzzle for Saber (Sea 1)
			["Godhuman"]           = true,  -- Farm materials & buy Godhuman (Sea 3)
			["Skull Guitar"]       = true,  -- Solve puzzle for Soul Guitar (Sea 3)
			["Mirror Fractal"]     = true,  -- Beat Dough King for Mirror Fractal
			["Cursed Dual Katana"] = true,  -- Complete the full CDK questline
			["Shark Anchor"]       = true,  -- Hunt Sea Terrors for Shark Anchor
		},
		-- Auto Get: Rare Items
		["Get Rare Items"] = {
			["Rengoku"]        = false,  -- Find key & open chest for Rengoku (Sea 2)
			["Dragon Trident"] = false,  -- Beat Tide Keeper for Dragon Trident
			["Pole (1st Form)"] = false, -- Beat Thunder God for Pole V1
			["Gravity Blade"]  = false,  -- Beat Fajita for Gravity Cane
		},
		-- Bosses & Summons
		["Summon Rip Indra"] = true,  -- Summon Rip Indra (God's Chalice + 3 Haki colors)
		-- Shop & Inventory
		["Sniper Fruit Shop"] = {
			["Enabled"] = true,  -- Auto-buy top fruits from the shop when in stock
			["Fruit"]   = { "Leopard-Leopard", "Kitsune-Kitsune", "Dragon-Dragon", "Yeti-Yeti", "Gas-Gas" }, -- Priority order
		},
		["Lock Fruit"] = {},  -- Protected fruits (never eaten, dropped, or traded)
		-- Server Hop
		["Select Hop"] = {
			["Hop If Found Near Exploiter"]  = false,  -- Hop if a suspicious player is nearby
			["Hop Find rip_indra True Form"] = false,  -- Hop searching for Rip Indra (True Form)
			["Hop Find Dough King"]          = false,  -- Hop searching for Dough King
			["Hop Find Raids Castle"]        = false,  -- Hop searching for the Sea Castle raid event
			["Hop Find Cake Queen"]          = false,  -- Hop searching for Cake Queen
			["Hop Find Soul Reaper"]         = false,  -- Hop searching for Soul Reaper
			["Hop Find Darkbeard"]           = false,  -- Hop searching for Darkbeard
			["Hop Find Mirage"]              = false,  -- Hop searching for Mirage Island
		},
		-- Webhook
		["Webhook"] = {
			["Enabled"]      = false,  -- Send status to your Discord webhook
			["Ping Discord"] = "",     -- Discord user/role ID to ping (optional)
			["Url"]          = "",     -- Your Discord webhook URL
		},
	},
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/VxezeHubLoader/refs/heads/main/BF-Kaitun.lua"))()
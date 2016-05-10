local HeroData = {}
HeroData[1] = 	{ 	["attack"] = 8,		["dead"] = 7 ,		["hurt"] = 4, 		["wait"] = 17,
					["tornado"] = 6,	["move"] = 8,		["magic1"] = 12,	["magic2"] = 28,
					["focus"] = 2,		["focusPre"] = 2
				}

HeroData[2] =	{	["attack"] = 12,	["dead"] = 9 ,		["hurt"] = 4, 		["wait"] = 8,
					["s06"] = 11,		["move"] = 4,		["magic1"] = 20,	["magic2"] = 4,
					["focus"] = 4,		["focusPre"] = 2,	["s01"] = 6,		["s05Move"] = 7,
					["s05"] = 10,		["s05Explode"] = 7,	
					["skill1"] = "#skillIcon6.png",
					["skill2"] = "#skillIcon5.png",
					["skill3"] = "#skillIcon4.png",
					["skillPic"] = "#heroSkillCircle.png"
				}
						
HeroData[3] = 	{	["attack"] = 9,		["dead"] = 6 ,		["hurt"] = 4, 		["wait"] = 8,
					["move"] = 8,		["magic1"] = 12,	["magic2"] = 6,		["focus"] = 6,
					["focusPre"] = 2,	
					["skill1"] = "#skillIcon10.png"	,
					["skill2"] = "#skillIcon9.png",
					["skill3"] = "#skillIcon8.png",
					["skillPic"] = "#skillIcon9.png"
				}

HeroData[4] =	{
					["attack"] = 7,		["dead"] = 6 ,		["hurt"] = 4, 		["wait"] = 9,
					["focus"] = 4,		["focusPre"] = 2,	["magic1"] = 21,
					["skill1"] = "#skillIcon14.png",
					["skill2"] = "#skillIcon13.png",
					["skill3"] = "#skillIcon12.png",
					["skillPic"] = "#skillIcon13.png"
				}
HeroData["Heroname"] = {	[1] = "盖伦",	[2] = "安妮",	[3] = "希维尔", [4] = "提莫"}

HeroData["HeroIntroduce"] = {	[1] = "拥有德玛西亚之\n力的英勇勇士",	[2] = "她就像孩子的\n玩偶",
								[3] = "希维尔无愧战争\n女神的称号",		[4] = "他有一张全球\n嘲讽脸"}
return HeroData
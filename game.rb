#!/usr/bin/env ruby -w
require 'rubygems'
require 'gosu'
require 'nokogiri'
require_relative 'Pokemon.rb'
include Nokogiri
include Gosu

class Game < Window
# create all of our class variable
  def initialize
	@pokes = ["abomasnow", "abra", "absol", "accelgor", "aerodactyl", "aggron", "aipom", "alakazam", "alomomola", "altaria", "ambipom", "amoonguss", "ampharos", "anorith", "arbok", "arcanine", "archen", "archeops", "ariados", "armaldo", "aron", "audino", "axew", "azumarill", "azurill", "bagon", "baltoy", "banette", "barboach", "basculin", "bastiodon", "bayleef", "beartic", "beautifly", "beedrill", "beheeyem", "beldum", "bellossom", "bellsprout", "bibarel", "bidoof", "bisharp", "blastoise", "blaziken", "blissey", "blitzle", "boldore", "bonsly", "bouffalant", "braviary", "breloom", "bronzong", "bronzor", "budew", "buizel", "bulbasaur", "buneary", "burmy", "butterfree", "cacnea", "cacturne", "camerupt", "carnivine", "carracosta", "carvanha", "cascoon", "castform", "caterpie", "chandelure", "chansey", "charizard", "charmander", "charmeleon", "chatot", "cherrim", "cherubi", "chikorita", "chimchar", "chimecho", "chinchou", "chingling", "cinccino", "clamperl", "claydol", "clefable", "clefairy", "cleffa", "cloyster", "cofagrigus", "combee", "combusken", "conkeldurr", "corphish", "corsola", "cottonee", "cradily", "cranidos", "crawdaunt", "croagunk", "crobat", "croconaw", "crustle", "cryogonal", "cubchoo", "cubone", "cyndaquil", "darmanitan", "darumaka", "deerling", "deino", "delcatty", "delibird", "dewgong", "dewott", "diglett", "ditto", "dodrio", "doduo", "donphan", "dragonair", "dragonite", "drapion", "dratini", "drifblim", "drifloon", "drilbur", "drowzee", "druddigon", "ducklett", "dugtrio", "dunsparce", "duosion", "durant", "dusclops", "dusknoir", "duskull", "dustox", "dwebble", "eelektrik", "eelektross", "eevee", "ekans", "electabuzz", "electivire", "electrike", "electrode", "elekid", "elgyem", "emboar", "emolga", "empoleon", "escavalier", "espeon", "excadrill", "exeggcute", "exeggutor", "exploud", "farfetchd", "fearow", "feebas", "feraligatr", "ferroseed", "ferrothorn", "finneon", "flaaffy", "flareon", "floatzel", "flygon", "foongus", "forretress", "fraxure", "frillish", "froslass", "furret", "gabite", "gallade", "galvantula", "garbodor", "garchomp", "gardevoir", "gastly", "gastrodon", "gengar", "geodude", "gible", "gigalith", "girafarig", "glaceon", "glalie", "glameow", "gligar", "gliscor", "gloom", "golbat", "goldeen", "golduck", "golem", "golett", "golurk", "gorebyss", "gothita", "gothitelle", "gothorita", "granbull", "graveler", "grimer", "grotle", "grovyle", "growlithe", "grumpig", "gulpin", "gurdurr", "gyarados", "happiny", "hariyama", "haunter", "haxorus", "heatmor", "heracross", "herdier", "hippopotas", "hippowdon", "hitmonchan", "hitmonlee", "hitmontop", "honchkrow", "hoothoot", "hoppip", "horsea", "houndoom", "houndour", "huntail", "hypno", "igglybuff", "illumise", "infernape", "ivysaur", "jellicent", "jigglypuff", "jolteon", "joltik", "jumpluff", "jynx", "kabuto", "kabutops", "kadabra", "kakuna", "kangaskhan", "karrablast", "kecleon", "kingdra", "kingler", "kirlia", "klang", "klink", "klinklang", "koffing", "krabby", "kricketot", "kricketune", "krokorok", "krookodile", "lairon", "lampent", "lanturn", "lapras", "larvesta", "larvitar", "leafeon", "leavanny", "ledian", "ledyba", "lickilicky", "lickitung", "liepard", "lileep", "lilligant", "lillipup", "linoone", "litwick", "lombre", "lopunny", "lotad", "loudred", "lucario", "ludicolo", "lumineon", "lunatone", "luvdisc", "luxio", "luxray", "machamp", "machoke", "machop", "magby", "magcargo", "magikarp", "magmar", "magmortar", "magnemite", "magneton", "magnezone", "makuhita", "mamoswine", "mandibuzz", "manectric", "mankey", "mantine", "mantyke", "maractus", "mareep", "marill", "marowak", "marshtomp", "masquerain", "mawile", "medicham", "meditite", "meganium", "meowth", "metagross", "metang", "metapod", "mienfoo", "mienshao", "mightyena", "milotic", "miltank", "mime-jr", "minccino", "minun", "misdreavus", "mismagius", "monferno", "mothim", "mr-mime", "mudkip", "muk", "munchlax", "munna", "murkrow", "musharna", "natu", "nidoking", "nidoqueen", "nidoranf", "nidoranm", "nidorina", "nidorino", "nincada", "ninetales", "ninjask", "noctowl", "nosepass", "numel", "nuzleaf", "octillery", "oddish", "omanyte", "omastar", "onix", "oshawott", "pachirisu", "palpitoad", "panpour", "pansage", "pansear", "paras", "parasect", "patrat", "pawniard", "pelipper", "persian", "petilil", "phanpy", "pichu", "pidgeot", "pidgeotto", "pidgey", "pidove", "pignite", "pikachu", "piloswine", "pineco", "pinsir", "piplup", "plusle", "pokes", "politoed", "poliwag", "poliwhirl", "poliwrath", "ponyta", "poochyena", "porygon", "porygon-z", "porygon2", "primeape", "prinplup", "probopass", "psyduck", "pupitar", "purrloin", "purugly", "quagsire", "quilava", "qwilfish", "raichu", "ralts", "rampardos", "rapidash", "raticate", "rattata", "relicanth", "remoraid", "reuniclus", "rhydon", "rhyhorn", "rhyperior", "riolu", "roggenrola", "roselia", "roserade", "rufflet", "sableye", "salamence", "samurott", "sandile", "sandshrew", "sandslash", "sawk", "sawsbuck", "sceptile", "scizor", "scolipede", "scrafty", "scraggy", "scyther", "seadra", "seaking", "sealeo", "seedot", "seel", "seismitoad", "sentret", "serperior", "servine", "seviper", "sewaddle", "sharpedo", "shedinja", "shelgon", "shellder", "shellos", "shelmet", "shieldon", "shiftry", "shinx", "shroomish", "shuckle", "shuppet", "sigilyph", "silcoon", "simipour", "simisage", "simisear", "skarmory", "skiploom", "skitty", "skorupi", "skuntank", "slaking", "slakoth", "slowbro", "slowking", "slowpoke", "slugma", "smeargle", "smoochum", "sneasel", "snivy", "snorlax", "snorunt", "snover", "snubbull", "solosis", "solrock", "spearow", "spheal", "spinarak", "spinda", "spiritomb", "spoink", "squirtle", "stantler", "staraptor", "staravia", "starly", "starmie", "staryu", "steelix", "stoutland", "stunfisk", "stunky", "sudowoodo", "sunflora", "sunkern", "surskit", "swablu", "swadloon", "swalot", "swampert", "swanna", "swellow", "swinub", "swoobat", "taillow", "tangela", "tangrowth", "tauros", "teddiursa", "tentacool", "tentacruel", "tepig", "throh", "timburr", "tirtouga", "togekiss", "togepi", "togetic", "torchic", "torkoal", "torterra", "totodile", "toxicroak", "tranquill", "trapinch", "treecko", "tropius", "trubbish", "turtwig", "tympole", "tynamo", "typhlosion", "tyranitar", "tyrogue", "umbreon", "unfezant", "unown", "ursaring", "vanillish", "vanillite", "vanilluxe", "vaporeon", "venipede", "venomoth", "venonat", "venusaur", "vespiquen", "vibrava", "victreebel", "vigoroth", "vileplume", "volbeat", "volcarona", "voltorb", "vullaby", "vulpix", "wailmer", "wailord", "walrein", "wartortle", "watchog", "weavile", "weedle", "weepinbell", "weezing", "whimsicott", "whirlipede", "whiscash", "whismur", "wigglytuff", "wingull", "wobbuffet", "woobat", "wooper", "wormadam", "wurmple", "wynaut", "xatu", "yamask", "yanma", "yanmega", "zangoose", "zebstrika", "zigzagoon", "zoroark", "zorua", "zubat"]
	#create the window
  super(556, 371, false)
  @scene = Image.new("Images/scene.png", false)
  @box = Image.new("Images/box.png", false)
  @optionBox = Image.new("Images/option-box.png", false)
  @attackBox = Image.new("Images/attackBox.png", false)
	@choose = Font.new(self, "pokefont.tff", 20)
	@moves = Font.new(self, "pokefont.tff", 30)
	@theirName = Font.new(self, 'pokefont.tff', 20)
	@ourName = Font.new(self, 'pokefont.tff', 20)
	@outputText2 = ""
	@pos = 0;
	@chosen = 0
	@ourPokemon = "pikachu"
	@otherPokemon = "pikachu"
	@us = Poke.new
	@them = Poke.new
	@turn = 0
	@attack = 0
	@sprite1 = Image.new("Images/sprites/" + @ourPokemon + " back.png", false)
	@sprite2 = Image.new("Images/sprites/" + @otherPokemon + " front.png", false)
	@attackChosen = 0
	@attacking = 0
	@take = 0
	@attacked = @them
	@over = 0
	@attacker = @us
	@usAttack = 0
	@themAttack = 0
	@x = 0
	@y = 0
	@dir = 2
	@oneLastChecker = 0
  end
  # get the searched move from the xml database
  def getMove(move, num, who)
	xml_file = File.read("Moves.xml")
	doc = Nokogiri::XML.parse(xml_file)
	doc.xpath('//move').each do
		|attack|
		# does the name we are looking for match the position in the xml?
		if attack.xpath('name').text.eql? move
			if num == 1
				who.instance_variable_get(:@move1).setter(attack.xpath('name').text, attack.xpath('type').text, attack.xpath('damage').text)
			elsif num == 2
				who.instance_variable_get(:@move2).setter(attack.xpath('name').text, attack.xpath('type').text, attack.xpath('damage').text)
			elsif num == 3
				who.instance_variable_get(:@move3).setter(attack.xpath('name').text, attack.xpath('type').text, attack.xpath('damage').text)
			else 
				who.instance_variable_get(:@move4).setter(attack.xpath('name').text, attack.xpath('type').text, attack.xpath('damage').text)
			end
		end
	end
  end
  # originally meant to get multipliers from another xml file, but I decided it was not necessary in this implementation, but I left the bones of the function
  def getStrengths(moveType, pokeType1, pokeType2, attacker, attacked)
	
	# math came from original game, but type multiplier is missing
	take1 = (0.5 * attacker.instance_variable_get(:@attack).to_f/(attacked.instance_variable_get(:@attack) - 5)).floor + 1
	@take = take1
			
	@attacking = 1

  end
	#call this repetively built into gosu
  def update
  # if health is at or below 0 of either Pokemon then the game is over
  if @us.instance_variable_get(:@hp) <= 0 or @them.instance_variable_get(:@hp) <= 0
	@over = 1
  end
  # both pokemon were chosen by the player
  if @chosen == 2
		#move through the xml file and find the pokemon the player entered
		xml_file = File.read("Pokemon.xml")
		doc = Nokogiri::XML.parse(xml_file)
		doc.xpath('//poke').each do
			|poke|
			if poke.xpath('name').text.eql? @ourPokemon
				@us.setter(@ourPokemon, poke.xpath('num').text, poke.xpath('type1').text, poke.xpath('type2').text, poke.xpath('hp').text, poke.xpath('attack').text)
				moves = poke.xpath('moves').text + poke.xpath('moves3').text
				listMoves = moves.split(',')
				# randomly get a move from the list of moves the pokemon can know and call helper function to retrieve it from xml
					getMove(listMoves[rand(0..listMoves.length - 1)], 1, @us)
					getMove(listMoves[rand(0..listMoves.length - 1)], 2, @us)
					getMove(listMoves[rand(0..listMoves.length - 1)], 3, @us)
					getMove(listMoves[rand(0..listMoves.length - 1)], 4, @us)
					#@us.instance_variable_get(:@move3).check
				#end
			end
			
			if poke.xpath('name').text.eql? @otherPokemon
				@them.setter(@otherPokemon, poke.xpath('num').text, poke.xpath('type1').text, poke.xpath('type2').text, poke.xpath('hp').text, poke.xpath('attack').text)
				moves = poke.xpath('moves').text + poke.xpath('moves3').text
				listMoves = moves.split(',')
				# randomly get a move from the list of moves the pokemon can know and call helper function to retrieve it from xml
					getMove(listMoves[rand(0..listMoves.length - 1)], 1, @them)
					getMove(listMoves[rand(0..listMoves.length - 1)], 2, @them)
					getMove(listMoves[rand(0..listMoves.length - 1)], 3, @them)
					getMove(listMoves[rand(0..listMoves.length - 1)], 4, @them)
				#end
			end
		end
		# set our sprite with the images we want.
		@sprite1 = Image.new("Images/sprites/" + @ourPokemon + " back.png", false)
		@sprite2 = Image.new("Images/sprites/" + @otherPokemon + " front.png", false)
		# reset position to be used again and move chosen to next stage
		@pos = 0
		@chosen = 3
  end
	#our turn 
	if @chosen == 3 and @turn == 0
		# choose attack and display the text and text box for it
		if @attackChosen == 1
			#move1
			if @pos == 0
				getStrengths(@us.instance_variable_get(:@move1).instance_variable_get(:@type), @us.instance_variable_get(:@type1), @us.instance_variable_get(:@type2), @us, @them)
				@outputText2 = @ourPokemon.capitalize + " used " + @us.instance_variable_get(:@move1).instance_variable_get(:@name)
			#move3
			elsif @pos == 1
				getStrengths(@us.instance_variable_get(:@move3).instance_variable_get(:@type), @us.instance_variable_get(:@type1), @us.instance_variable_get(:@type2), @us, @them)
				@outputText2 = @ourPokemon.capitalize + " used " + @us.instance_variable_get(:@move3).instance_variable_get(:@name)
			#move2
			elsif @pos == 10
				getStrengths(@us.instance_variable_get(:@move2).instance_variable_get(:@type), @us.instance_variable_get(:@type1), @us.instance_variable_get(:@type2), @us, @them)
				@outputText2 = @ourPokemon.capitalize + " used " + @us.instance_variable_get(:@move2).instance_variable_get(:@name)
			#move4
			elsif @pos == 11
				getStrengths(@us.instance_variable_get(:@move4).instance_variable_get(:@type), @us.instance_variable_get(:@type1), @us.instance_variable_get(:@type2), @us, @them)
				@outputText2 = @ourPokemon.capitalize + " used " + @us.instance_variable_get(:@move4).instance_variable_get(:@name)
			end
			# tells us who is giving and who is recieving damage
			@attacked = @them
			@attacker = @us
			@usAttack = 1
		end
	#their turn
	elsif @chosen == 3 and @turn == 1
		# get attacked and display the text for it
		# get one of the enemy Pokemon's four moves randomly and attack with it
		randy = rand(1..4)
		if randy == 1
			getStrengths(@them.instance_variable_get(:@move1).instance_variable_get(:@type), @them.instance_variable_get(:@type1), @them.instance_variable_get(:@type2), @them, @us)
			@outputText2 = @otherPokemon.capitalize + " used " + @them.instance_variable_get(:@move1).instance_variable_get(:@name)
		#move3
		elsif randy == 3
			getStrengths(@them.instance_variable_get(:@move3).instance_variable_get(:@type), @them.instance_variable_get(:@type1), @them.instance_variable_get(:@type2), @them, @us)
			@outputText2 = @otherPokemon.capitalize + " used " + @them.instance_variable_get(:@move3).instance_variable_get(:@name)
		#move2
		elsif randy == 2
			getStrengths(@them.instance_variable_get(:@move2).instance_variable_get(:@type), @them.instance_variable_get(:@type1), @them.instance_variable_get(:@type2), @them, @us)
			@outputText2 = @otherPokemon.capitalize + " used " + @them.instance_variable_get(:@move2).instance_variable_get(:@name)
		#move4
		elsif randy == 4
			getStrengths(@them.instance_variable_get(:@move4).instance_variable_get(:@type), @them.instance_variable_get(:@type1), @them.instance_variable_get(:@type2), @them, @us)
			@outputText2 = @otherPokemon.capitalize + " used " + @them.instance_variable_get(:@move4).instance_variable_get(:@name)
		end
		@attacked = @us
		@attacker = @them
		@themAttack = 1
	end
  end

  # gosu calls repetively and displays in the gui
  def draw
  # is the game over? 
	if @over == 0
		# need to choose our pokemon 
		if @chosen == 0
			@choose.draw("Choose your Pokemon. Press a and d to ", 110, 75, 1, 1.0, 1.0, Gosu::Color::WHITE)
			@choose.draw("move through list and space to confirm", 115, 90, 1, 1.0, 1.0, Gosu::Color::WHITE)
			@choose.draw(@pokes[@pos].capitalize, 230, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
		# need to choose our pokemon 
		elsif @chosen == 1
			@choose.draw("Choose the enemy Pokemon. Press a and d to ", 98, 75, 1, 1.0, 1.0, Gosu::Color::WHITE)
			@choose.draw("move through list and space to confirm", 115, 90, 1, 1.0, 1.0, Gosu::Color::WHITE)
			@choose.draw(@pokes[@pos].capitalize, 230, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
		# both pokemon have been chosen and we can play now
		elsif @chosen == 3
			@scene.draw(0,0,0)	
			@box.draw(0,0,2)
			@theirName.draw(@otherPokemon.capitalize, 50, 48, 3, 1.0, 1.0, Gosu::Color::BLACK)
			@ourName.draw(@ourPokemon.capitalize, 335, 180, 3, 1.0, 1.0, Gosu::Color::BLACK)
			# are we attacking? 1 is true, 0 is false
			if @attacking == 1
				# fixes glitch of text flipping back and forth each call
				if @oneLastChecker == 0
					@outputText1 = @outputText2
					@oneLastChecker = 1
				end
				@choose.draw(@outputText1 , 30, 270, 7, 1.5, 1.5, Gosu::Color::BLACK) 
				# move their character if we are still moving
				if @them.instance_variable_get(:@name).eql? @attacker.instance_variable_get(:@name) and @themAttack == 1
					@sprite1.draw(50,150,1, 1.3, 1.3) #us
					@sprite2.draw(330 + @x, 40 + @y,1,1.3,1.3) #them
					# draw health stats and names
						if (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.5
						Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
						@choose.draw(@us.instance_variable_get(:@hp), 445, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw("/", 477, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw(@us.instance_variable_get(:@maxHp), 485, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						
						
						# them
						if (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.5
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
					# if we hit the furthest move distance we need to move back
					if @x >= -50
						if @x == -50
							@dir = @dir * -1
						end
						@x = @x + @dir
						@y = @y - @dir
						# we are back to original position so stop moving 
						if @x == 0
							@themAttack = 0
							@outputText1 = " "
						end
					end
				# move our character
				elsif @usAttack == 1
					@sprite1.draw(50 + @x,150 + @y,1, 1.3, 1.3) #us
					@sprite2.draw(330, 40,1,1.3,1.3) #them
					# display names and health stats
						if (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.5
						Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
						@choose.draw(@us.instance_variable_get(:@hp), 445, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw("/", 477, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw(@us.instance_variable_get(:@maxHp), 485, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						
						
						# them
						if (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.5
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
					# move until we hit the max position and move back 
					if @x <= 50
						if @x == 50
							@dir = @dir * -1
						end
						@x = @x + @dir
						@y = @y - @dir
						# if we are back in our original position then we are finished moving 
						if @x == 0
							@usAttack = 0
							@outputText1 = " "
						end
					end
					@oneLastChecker = 0
				end
				# are we both finished attacking? 
				if @themAttack == 0 and @usAttack == 0
					# make a delay 
					sleep(1)
					#variable to use i with to make ruby error about unused i go away
					this = 0
					# display the health bar moving down incrementally, moves too fast to even notice
					for i in 0..@take
						this = i + this
						# decrement health by 1
						@attacked.decre
						if (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.5
						Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
						@choose.draw(@us.instance_variable_get(:@hp), 445, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw("/", 477, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						@choose.draw(@us.instance_variable_get(:@maxHp), 485, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
						
						
						# them
						if (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.5
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
						elsif (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.2
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
						else 
							Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
						end
					end	
					# we are finished attacking 
					@attacking = 0
					# reset the box to let us choose a move 
					if @them.instance_variable_get(:@name).eql? @attacked.instance_variable_get(:@name)
						@attack = 0
					end
					#puts "them " + @them.instance_variable_get(:@hp).to_s
					#puts "us " + @us.instance_variable_get(:@hp).to_s
					#puts @outputText2
					if @turn == 0
						@turn = 1
						@attackChosen = 0
					else 
						@turn = 0
					end
				end
			# nobody is attacking 
			elsif @attacking == 0
				@sprite1.draw(50,150,1, 1.3, 1.3)
				@sprite2.draw(330,40,1,1.3,1.3)
				
				#us
				if (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.5
					Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
				elsif (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp)) >= 0.2
					Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
				else 
					Gosu.draw_rect(405, 209, (110 * (@us.instance_variable_get(:@hp).to_f / @us.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
				end
				@choose.draw(@us.instance_variable_get(:@hp), 445, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
				@choose.draw("/", 477, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
				@choose.draw(@us.instance_variable_get(:@maxHp), 485, 220, 3, 1.0, 1.0, Gosu::Color::BLACK)
				
				
				# them
				if (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.5
					Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::GREEN, 3)
				elsif (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp)) >= 0.2
					Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::YELLOW, 3)
				else 
					Gosu.draw_rect(122, 77, (110 * (@them.instance_variable_get(:@hp).to_f / @them.instance_variable_get(:@maxHp))).floor, 7, Gosu::Color::RED, 3)
				end
			
			
			
			
			
			
				# draw our attack box where we choose moves 
				if @attack == 0 && @turn == 0 && @attackChosen == 0
					@attackBox.draw(0,0,3)
					@moves.draw("Dam", 425, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
					if @pos == 0 #move 1
						Gosu.draw_rect(17, 277, 177, 35, Gosu::Color::RED, 3)
						Gosu.draw_rect(19, 279, 173, 31, Gosu::Color::WHITE, 3)
						@moves.draw(@us.instance_variable_get(:@move1).instance_variable_get(:@damage), 500, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
						@moves.draw(@us.instance_variable_get(:@move1).instance_variable_get(:@type), 425, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
					elsif @pos == 1 #move 3
						Gosu.draw_rect(217, 277, 177, 35, Gosu::Color::RED, 3)
						Gosu.draw_rect(219, 279, 173, 31, Gosu::Color::WHITE, 3)
						@moves.draw(@us.instance_variable_get(:@move3).instance_variable_get(:@damage), 500, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
						@moves.draw(@us.instance_variable_get(:@move3).instance_variable_get(:@type), 425, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
					elsif @pos == 10 #move2
						Gosu.draw_rect(17, 322, 177, 35, Gosu::Color::RED, 3)
						Gosu.draw_rect(19, 324, 173, 31, Gosu::Color::WHITE, 3)
						@moves.draw(@us.instance_variable_get(:@move2).instance_variable_get(:@damage), 500, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
						@moves.draw(@us.instance_variable_get(:@move2).instance_variable_get(:@type), 425, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
					elsif @pos == 11 #move 4
						Gosu.draw_rect(217, 322, 177, 35, Gosu::Color::RED, 3)
						Gosu.draw_rect(219, 324, 173, 31, Gosu::Color::WHITE, 3)
						@moves.draw(@us.instance_variable_get(:@move4).instance_variable_get(:@damage), 500, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
						@moves.draw(@us.instance_variable_get(:@move4).instance_variable_get(:@type), 425, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
					end
					@moves.draw(@us.instance_variable_get(:@move1).instance_variable_get(:@name), 20, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
					@moves.draw(@us.instance_variable_get(:@move2).instance_variable_get(:@name), 20, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
					@moves.draw(@us.instance_variable_get(:@move3).instance_variable_get(:@name), 220, 280, 4, 1.0, 1.0, Gosu::Color::BLACK)
					@moves.draw(@us.instance_variable_get(:@move4).instance_variable_get(:@name), 220, 325, 4, 1.0, 1.0, Gosu::Color::BLACK)
				end
			end
		end
	else
		# has anybody feinted? if so the game is over and we need to display a win or loss screen 
		if @us.instance_variable_get(:@hp) <= 0
			@choose.draw("Your Pokemon has fainted, press Esc to quit!", 75, 200, 3, 1.0, 1.0, Gosu::Color::WHITE)
		else 
			@choose.draw("Enemy Pokemon has fainted, press Esc to quit!", 75, 200, 3, 1.0, 1.0, Gosu::Color::WHITE)
		end
	end
  end

  def button_down(id)
  ##################################
  # pressing d moves the move chooser box around and moves to next pokemon in list
    if id == KbA
		if @chosen != 3
			@pos = @pos - 1
			if @pos < 0
				@pos = 598
			end
		end
		
		if @chosen == 3 && (@pos == 1 || @pos == 11)
			@pos = @pos - 1
		end
	# pressing d moves the move chooser box around and moves to next pokemon in list
	elsif id == KbD
		if @chosen != 3
			@pos = @pos + 1
			if @pos > 598
				@pos = 0
			end
		end
		
		if @chosen == 3 && (@pos == 0 || @pos == 10)
			@pos = @pos + 1
		end
    end
	###############################
	# if 'Esc' is pressed we need to close out of the game
    if id == KbEscape then close end
	###############################
	if id == KbW
		if @chosen == 3 && @pos >= 10
			@pos = @pos - 10
		end
	end
	if id == KbS && @chosen == 3 && @pos < 10
		@pos = @pos + 10
	end
	# pressing spacebar changes jobs based on time in game. 
	if id == KbSpace
		if @chosen == 3 && @turn == 0
			@attack = 2
			@attackChosen = 1
		elsif @chosen == 0
			@chosen = 1
			@ourPokemon = @pokes[@pos]
			@pos = 0
		elsif @chosen == 1
			@chosen = 2
			@otherPokemon = @pokes[@pos]
		end
	end
  end
end

Game.new.show

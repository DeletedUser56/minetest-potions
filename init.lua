-- Potions mod by DeletedUser56

potions = {}
local Colorize = minetest.colorize
local w = 0.7
local gravity = tonumber(minetest.settings:get("movement_gravity"))


function potions.is_obj_hit(self, pos)

	local entity
	for _,object in pairs(minetest.get_objects_inside_radius(pos, 1.1)) do

		if object:is_player() and self._thrower ~= object:get_player_name() then
			return true
		end

	 end
end



minetest.register_entity("potions:splash_slowness_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#8B8BBB:200^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#8B8BBB:300",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
							obj:set_physics_override({speed = 0.5})
							minetest.after(20, function()
							obj:set_physics_override({speed = 1})
						end)
						potions.slowness_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_harming_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#540000:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#540000:250",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
					local hp = obj:get_hp()
					minetest.after(0.3, function()
						obj:punch(obj, 2, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.7, function()
						obj:punch(obj, 4, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.11, function()
						obj:punch(obj, 6, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.15, function()
						obj:punch(obj, 8, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					potions.harming_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_poison_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#5C7A5C:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#5C7A5C:250",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
							local hp = obj:get_hp()
					minetest.after(1, function()
						obj:punch(obj, 1, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(2, function()
						obj:punch(obj, 2, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(3, function()
						obj:punch(obj, 3, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(4, function()
						obj:punch(obj, 4, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(5, function()
						obj:punch(obj, 5, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(6, function()
						obj:punch(obj, 6, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(7, function()
						obj:punch(obj, 7, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(8, function()
						obj:punch(obj, 8, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(9, function()
						obj:punch(obj, 9, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(10, function()
						obj:punch(obj, 10, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(11, function()
						obj:punch(obj, 11, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(12, function()
						obj:punch(obj, 12, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(13, function()
						obj:punch(obj, 13, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(14, function()
						obj:punch(obj, 14, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(15, function()
						obj:punch(obj, 15, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(16, function()
						obj:punch(obj, 16, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(17, function()
						obj:punch(obj, 17, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(18, function()
						obj:punch(obj, 18, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(18.2, function()
					end)
					potions.poison_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_regeneration_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:violet:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:violet:250",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
						local hp = obj:get_hp()
					minetest.after(1, function()
						obj:set_hp(hp +2)
					end)
					minetest.after(2, function()
						obj:set_hp(hp +4)
					end)
					minetest.after(3, function()
						obj:set_hp(hp +6)
					end)
					minetest.after(4, function()
						obj:set_hp(hp +8)
					end)
					minetest.after(5, function()
						obj:set_hp(hp +10)
					end)
					potions.regeneration_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_haste_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#58FF00:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#58FF00:220",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
					obj:set_physics_override({speed = 1.40})
					minetest.after(20, function()
						obj:set_physics_override({speed = 1})
					end)
					potions.haste_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_leaping_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#61FFC9:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#61FFC9:220",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
					obj:set_physics_override({jump = 1.40})
					minetest.after(20, function()
						obj:set_physics_override({jump = 1})
					end)
					potions.leaping_particles(obj)
						end
					end
				end
			end
	end
})

minetest.register_entity("potions:splash_slow_falling_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#DBF4F3:220^splash_potion_bottle_overlay.png"},
	acc = {x=0, y=-gravity, z=0},
	pointable = false,
		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)
			local n = node.name
			local g = minetest.get_node_group(n, "liquid")
			local d = 0.1
			local redux_map = {7/8,0.5,0.25}
			
			if n ~= "air" and g == 0 or potions.is_obj_hit(self, pos) then
				minetest.sound_play("potions_glass_break", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=pos.x-d, y=pos.y+0.5, z=pos.z-d},
					maxpos = {x=pos.x+d, y=pos.y+0.5+d, z=pos.z+d},
					minvel = {x=-2, y=0, z=-2},
					maxvel = {x=2, y=2, z=2},
					minacc = acc,
					maxacc = acc,
					minexptime = 0.5,
					maxexptime = 1.25,
					minsize = 1,
					maxsize = 2,
					collisiondetection = true,
					vertical = false,
					texture = "potion_particle_overlay.png^[colorize:#DBF4F3:220",
					glow = 100,
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
					obj:set_physics_override({gravity = 0.6})
					minetest.after(10, function()
						obj:set_physics_override({gravity = 1})
					end)
					potions.slow_falling_particles(obj)
						end
					end
				end
			end
	end
})

function potions.particles(obj, color)
	local d = 0.2
	local pos = obj:get_pos()
	minetest.add_particlespawner({
		amount = 1,
		time = 1,
		minpos = {x=pos.x-d, y=pos.y+1, z=pos.z-d},
		maxpos = {x=pos.x+d, y=pos.y+2, z=pos.z+d},
		minvel = {x=-0.1, y=0, z=-0.1},
		maxvel = {x=0.1, y=0.1, z=0.1},
		minacc = {x=-0.1, y=0, z=-0.1},
		maxacc = {x=0.1, y=.1, z=0.1},
		minexptime = 0.5,
		maxexptime = 1,
		minsize = 0.5,
		maxsize = 1,
		collisiondetection = false,
		vertical = false,
		glow = 300,
		texture = "potion_particle_overlay.png^[colorize:"..color..":230",
	})
end

function potions.regeneration_particles(user)
			if user:get_pos() then potions.particles(user, "violet") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
				if user:get_pos() then potions.particles(user, "violet") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
				if user:get_pos() then potions.particles(user, "violet") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
				if user:get_pos() then potions.particles(user, "violet") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "violet") end
			end)
		end
		
function potions.harming_particles(user)
			if user:get_pos() then potions.particles(user, "#540000") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
				if user:get_pos() then potions.particles(user, "#540000") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
				if user:get_pos() then potions.particles(user, "#540000") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
				if user:get_pos() then potions.particles(user, "#540000") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#540000") end
			end)
		end
		
function potions.poison_particles(user)
			if user:get_pos() then potions.particles(user, "#5C7A5C") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#5C7A5C") end
			end)
		end

function potions.haste_particles(user)
			if user:get_pos() then potions.particles(user, "#58FF00") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
				if user:get_pos() then potions.particles(user, "#58FF00") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
				if user:get_pos() then potions.particles(user, "#58FF00") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
				if user:get_pos() then potions.particles(user, "#58FF00") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#58FF00") end
			end)
		end

function potions.slowness_particles(user)
			if user:get_pos() then potions.particles(user, "#8B8BBB") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#8B8BBB") end
			end)
		end

function potions.leaping_particles(user)
			if user:get_pos() then potions.particles(user, "#61FFC9") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#61FFC9") end
			end)
		end
		
function potions.weakness_particles(user)
			if user:get_pos() then potions.particles(user, "#7131C0") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
				if user:get_pos() then potions.particles(user, "#7131C0") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
				if user:get_pos() then potions.particles(user, "#7131C0") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
				if user:get_pos() then potions.particles(user, "#7131C0") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#7131C0") end
			end)
		end
		
function potions.slow_falling_particles(user)
			if user:get_pos() then potions.particles(user, "#DBF4F3") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#DBF4F3") end
			end)
		end
		
minetest.register_craftitem("potions:regeneration", {
	description = Colorize("#D2FF00", "Potion of Regeneration").."\n" ..Colorize("#1719B6", "Instant Healing").. "\n" ..Colorize("#FF3800", "Heal per second: 3").. "\n" ..Colorize("#FFD4FF", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:violet:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		local hp = user:get_hp()
					minetest.after(1, function()
						user:set_hp(hp +2)
					end)
					minetest.after(2, function()
						user:set_hp(hp +4)
					end)
					minetest.after(3, function()
						user:set_hp(hp +6)
					end)
					minetest.after(4, function()
						user:set_hp(hp +8)
					end)
					minetest.after(5, function()
						user:set_hp(hp +10)
					end)
					potions.regeneration_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
					
				itemstack:take_item()
				return itemstack
			end,
})

minetest.register_craftitem("potions:harming", {
	description = Colorize("#D2FF00", "Potion of Harming").."\n" ..Colorize("#1719B6", "Instant Harming").. "\n" ..Colorize("#FF3800", "Damage per second: 3").. "\n" ..Colorize("#540000", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#8B0000:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		local hp = user:get_hp()
					minetest.after(0.3, function()
						user:punch(user, 2, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.7, function()
						user:punch(user, 4, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.11, function()
						user:punch(user, 6, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					minetest.after(0.15, function()
						user:punch(user, 8, {
						full_punch_interval = 0.3,
						damage_groups = {fleshy = 4}
						}, nil)
					end)
					potions.harming_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
			end,
})

minetest.register_craftitem("potions:poison", {
	description = Colorize("#D2FF00", "Potion of Poison").."\n" ..Colorize("#1719B6", "Poison").. "\n" ..Colorize("#FF3800", "Heal per second: 1").. "\n" ..Colorize("#5C7A5C", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#5C7A5C:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		local hp = user:get_hp()
					minetest.after(1, function()
						user:punch(user, 1, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(2, function()
						user:punch(user, 2, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(3, function()
						user:punch(user, 3, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(4, function()
						user:punch(user, 4, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(5, function()
						user:punch(user, 5, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(6, function()
						user:punch(user, 6, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(7, function()
						user:punch(user, 7, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(8, function()
						user:punch(user, 8, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(9, function()
						user:punch(user, 9, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(10, function()
						user:punch(user, 10, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(11, function()
						user:punch(user, 11, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(12, function()
						user:punch(user, 12, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(13, function()
						user:punch(user, 13, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(14, function()
						user:punch(user, 14, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(15, function()
						user:punch(user, 15, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(16, function()
						user:punch(user, 16, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(17, function()
						user:punch(user, 17, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(18, function()
						user:punch(user, 18, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = 1}
						}, nil)
					end)
					minetest.after(18.2, function()
					end)
					potions.poison_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
			end,
})

minetest.register_craftitem("potions:slowness", {
	description = Colorize("#D2FF00", "Potion of Slowness").."\n" ..Colorize("#1719B6", "Slowness").. "\n" ..Colorize("#FF3800", "Speed: -%50 (.5)").. "\n" ..Colorize("#8B8BBB", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#8B8BBB:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 0.5})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					potions.slowness_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:swiftness", {
	description = Colorize("#D2FF00", "Potion of Swiftness").."\n" ..Colorize("#1719B6", "Swiftness").. "\n" ..Colorize("#FF3800", "Speed: +%40 (.40)").. "\n" ..Colorize("#58FF00", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#58FF00:127^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 1.40})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					potions.haste_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:leaping", {
	description = Colorize("#D2FF00", "Potion of Leaping").."\n" ..Colorize("#1719B6", "Leaping").. "\n" ..Colorize("#FF3800", "Jump boost: +%40 (.40)").. "\n" ..Colorize("#61FFC9", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#61FFC9:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({jump = 1.40})
				minetest.after(20, function()
					user:set_physics_override({jump = 1})
				end)
					potions.leaping_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:slow_falling", {
	description = Colorize("#D2FF00", "Potion of Slow Falling").."\n" ..Colorize("#1719B6", "Gravity").. "\n" ..Colorize("#FF3800", "Gravity: -%40 (.40)").. "\n" ..Colorize("#DBF4F3", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#DBF4F3:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({gravity = 0.6})
				minetest.after(10, function()
					user:set_physics_override({gravity = 1})
				end)
					potions.slow_falling_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

-- TODO: Add weakness and strength potions/splash potions
--minetest.register_craftitem("potions:weakness", {
--	description = Colorize("#D2FF00", "Potion of Weakness").."\n" ..Colorize("#1719B6", "Weakness").. "\n" ..Colorize("#FF3800", "Armor: -%40 (.40)").. "\n" ..Colorize("#7131C0", "Duration: 20 seconds"),
--	inventory_image = "potion_liquid_overlay.png^[colorize:#7131C0:250^potion_bottle_overlay.png",
--	groups = {can_eat_when_full=1},
--	stack_max = 1,
--	on_place = on_secondary_use,
--	on_secondary_use = function(itemstack, user, pointed_thing)
--		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
--			user:set_properties({
--				armor_groups = { fleshy = 2000, crumbly = 2000 },
--			})
--
--				minetest.after(20, function()
--					user:set_properties({
--						armor_groups = { fleshy = 100, crumbly = 100 },
--						})
--					end)
--					potions.weakness_particles(user)
--					inv:add_item("main", "vessels:glass_bottle")
--				itemstack:take_item()
--				return itemstack
--				
--			end,
--})

minetest.register_craftitem("potions:slowness_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Slowness").."\n" ..Colorize("#1719B6", "Slowness").. "\n" ..Colorize("#FF3800", "Speed: -6").. "\n" ..Colorize("#8B8BBB", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#8B8BBB:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_slowness_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:harming_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Harming").."\n" ..Colorize("#1719B6", "Instant Harming").. "\n" ..Colorize("#FF3800", "Damage per second: 4").. "\n" ..Colorize("#540000", "Duration: 4 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#540000:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_harming_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:poison_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Poison").."\n" ..Colorize("#1719B6", "Poison").. "\n" ..Colorize("#FF3800", "Damage per second: 1").. "\n" ..Colorize("#5C7A5C", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#5C7A5C:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_poison_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:regeneration_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Regeneration").."\n" ..Colorize("#1719B6", "Instant Healing").. "\n" ..Colorize("#FF3800", "Heal per second: 2").. "\n" ..Colorize("violet", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:violet:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_regeneration_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:swiftness_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Swiftness").."\n" ..Colorize("#1719B6", "Swiftness").. "\n" ..Colorize("#FF3800", "Speed: +%40").. "\n" ..Colorize("#58FF00", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#58FF00:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_haste_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:leaping_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Leaping").."\n" ..Colorize("#1719B6", "Leaping").. "\n" ..Colorize("#FF3800", "Jump boost: +%40").. "\n" ..Colorize("#61FFC9", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#61FFC9:220^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_leaping_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:slow_falling_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Slow Falling").."\n" ..Colorize("#1719B6", "Gravity").. "\n" ..Colorize("#FF3800", "Gravity: -%40").. "\n" ..Colorize("#DBF4F3", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#DBF4F3:220^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = on_secondary_use,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_slow_falling_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

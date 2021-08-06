-- Potions mod by DeletedUser56

potions = {}
local Colorize = minetest.colorize
local w = 0.7
local gravity = tonumber(minetest.settings:get("movement_gravity"))
local help = "Use the `place` key to throw / drink."


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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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

minetest.register_entity("potions:splash_healing_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#FF4074:168^splash_potion_bottle_overlay.png"},
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({ 
 	 				amount = 60,
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
					texture = "potion_particle_overlay.png^[colorize:#FF4074:168",
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
						local hp = obj:get_hp()
						obj:set_hp(hp + 5)
							potions.healing_particles(obj)
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
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

minetest.register_entity("potions:splash_invisibility_flying", {
	visual = "sprite",
	visual_size = {x=w/2,y=w/2},
	collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
	physical = false,
	textures = {"potion_liquid_overlay.png^[colorize:#4D4DFD:230^splash_potion_bottle_overlay.png"},
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
				minetest.sound_play("mcl_potions_breaking_glass", {pos = pos, max_hear_distance = 16, gain = 1})
				self.object:remove()
				minetest.add_particlespawner({
					amount = 58,
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
					texture = "potion_particle_overlay.png^[colorize:#4D4DFD:230",
				})
				for _,obj in pairs(minetest.get_objects_inside_radius(pos, 4)) do

					local entity = obj:get_luaentity()
					if obj:is_player() or entity._cmi_is_mob then

						local pos2 = obj:get_pos()
						local rad = math.floor(math.sqrt((pos2.x-pos.x)^2 + (pos2.y-pos.y)^2 + (pos2.z-pos.z)^2))
							if rad or potions.is_obj_hit(self, pos) then
					obj:set_properties({
					visual_size = {x = 0, y = 0},
					})

					obj:set_nametag_attributes({
					color = {a = 0, r = 255, g = 255, b = 255}
					})
				minetest.after(20, function()
					obj:set_properties({
					visual_size = {x = 1, y = 1},
					})

				obj:set_nametag_attributes({
				color = {a = 255, r = 255, g = 255, b = 255}
				})
				end)
					potions.invisibility_particles(obj)
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
		texture = "potion_particle_overlay.png^[colorize:"..color..":168",
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
		
function potions.healing_particles(user)
			if user:get_pos() then potions.particles(user, "#FF4074") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
				if user:get_pos() then potions.particles(user, "#FF4074") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
				if user:get_pos() then potions.particles(user, "#FF4074") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
				if user:get_pos() then potions.particles(user, "#FF4074") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#FF4074") end
			end)
		end
-- TODO: Add potion of weakness, strength #7131C0, #E10009
		
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
		
function potions.invisibility_particles(user)
			if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(1, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(1.9, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(2.8, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(3.7, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(4.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(5.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(6.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(8.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(9.1, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(10, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(0.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(1.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(2.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(3.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(4.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(5.1, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(6.1, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(7, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(7.8, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(8.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(9.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(0.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(1.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(2.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(3.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(4.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(5.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(7.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(8.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(9.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(0.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(1.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(2.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(3.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(4.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(5.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(6.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(7.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(8.0, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(9.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(10.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(11.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(12.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(13.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(14.8, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(15.7, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(16.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(17.7, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(18.8, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(19.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(20.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(11.0, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(12.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(13.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(14.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(15.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(16.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(17.7, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(18.9, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(19.0, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(20.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(11.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(12.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(13.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(14.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(15.8, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(16.9, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(17.11, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(18.13, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(19.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(20.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(11.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(12.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(13.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			minetest.after(14.6, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(15.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(16.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(17.5, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(18.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(19.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(20.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(11.4, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(13.0, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(14.2, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
			minetest.after(15.3, function()
				if user:get_pos() then potions.particles(user, "#4D4DFD") end
			end)
		end
		
minetest.register_craftitem("potions:regeneration", {
	description = Colorize("#D2FF00", "Potion of Regeneration").."\n" ..Colorize("#1719B6", "Instant Healing").. "\n" ..Colorize("#FF3800", "Heal per second: 3").. "\n" ..Colorize("#FFD4FF", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:violet:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
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
					
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.regeneration_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
					
				itemstack:take_item()
				return itemstack
			end,
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
					
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
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
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.harming_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
			end,
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
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
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
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.poison_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
			end,
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
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 0.5})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.slowness_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 0.5})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 1.40})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.haste_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({speed = 1.40})
				minetest.after(20, function()
					user:set_physics_override({speed = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({jump = 1.40})
				minetest.after(20, function()
					user:set_physics_override({jump = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.leaping_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({jump = 1.40})
				minetest.after(20, function()
					user:set_physics_override({jump = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
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
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({gravity = 0.6})
				minetest.after(10, function()
					user:set_physics_override({gravity = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.slow_falling_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
			user:set_physics_override({gravity = 0.6})
				minetest.after(10, function()
					user:set_physics_override({gravity = 1})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.slow_falling_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:invisibility", {
	description = Colorize("#D2FF00", "Potion of Invisibility").."\n" ..Colorize("#1719B6", "Invisibility").. "\n" ..Colorize("#FF3800", "Invisibility +%100").. "\n" ..Colorize("#4D4DFD", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#4D4DFD:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		user:set_properties({
			visual_size = {x = 0, y = 0},
		})

		user:set_nametag_attributes({
			color = {a = 0, r = 255, g = 255, b = 255}
		})
			minetest.after(20, function()
		user:set_properties({
			visual_size = {x = 1, y = 1},
		})

		user:set_nametag_attributes({
			color = {a = 255, r = 255, g = 255, b = 255}
		})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.invisibility_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		user:set_properties({
			visual_size = {x = 0, y = 0},
		})

		user:set_nametag_attributes({
			color = {a = 0, r = 255, g = 255, b = 255}
		})
			minetest.after(20, function()
		user:set_properties({
			visual_size = {x = 1, y = 1},
		})

		user:set_nametag_attributes({
			color = {a = 255, r = 255, g = 255, b = 255}
		})
				end)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.invisibility_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:healing", {
	description = Colorize("#D2FF00", "Potion of Healing").."\n" ..Colorize("#1719B6", "Instant Healing").. "\n" ..Colorize("#FF4074", "+%6 HP").. "\n" ..Colorize("#4D4DFD", "Duration: 1 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#FF4074:250^potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		local hp = user:get_hp()
					user:set_hp(hp + 6)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.invisibility_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		local inv = minetest.get_inventory({type="player", name=user:get_player_name()})
		local hp = user:get_hp()
					user:set_hp(hp + 6)
					minetest.sound_play("mcl_potions_drinking", {pos = pos, max_hear_distance = 16, gain = 1})
					potions.healing_particles(user)
					inv:add_item("main", "vessels:glass_bottle")
				itemstack:take_item()
				return itemstack
				
			end,
})

minetest.register_craftitem("potions:slowness_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Slowness").."\n" ..Colorize("#1719B6", "Slowness").. "\n" ..Colorize("#FF3800", "Speed: -6").. "\n" ..Colorize("#8B8BBB", "Duration: 10 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#8B8BBB:250^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_slowness_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_harming_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_poison_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_regeneration_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_haste_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_leaping_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_slow_falling_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
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

minetest.register_craftitem("potions:invisibility_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Invisibility").."\n" ..Colorize("#1719B6", "Invisibility").. "\n" ..Colorize("#FF3800", "Invisibility: %100").. "\n" ..Colorize("#4D4DFD", "Duration: 20 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#4D4DFD:230^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_invisibility_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_invisibility_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craftitem("potions:healing_splash", {
	description = Colorize("#D2FF00", "Splash Potion of Healing").."\n" ..Colorize("#1719B6", "Healing").. "\n" ..Colorize("#FF4074", "+6% HP").. "\n" ..Colorize("#4D4DFD", "Duration: 1 seconds"),
	inventory_image = "potion_liquid_overlay.png^[colorize:#FF4074:230^splash_potion_bottle_overlay.png",
	groups = {can_eat_when_full=1},
	stack_max = 1,
	on_place = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_healing_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local velocity = 6
			local dir = user:get_look_dir();
			local pos = user:get_pos();
			local obj = minetest.add_entity({x=pos.x+dir.x,y=pos.y+2+dir.y,z=pos.z+dir.z}, "potions:splash_healing_flying")
			obj:set_velocity({x=dir.x*velocity,y=dir.y*velocity,z=dir.z*velocity})
			obj:set_acceleration({x=dir.x*-3, y=-9.8, z=dir.z*-3})
			itemstack:take_item()
			return itemstack
		end,
})

minetest.register_craft({
	output = "potions:regeneration",
	recipe = {
		{"default:diamond", "farming:straw", "default:diamond"},
		{"farming:bread", "vessels:glass_bottle", "farming:straw"},
		{"default:diamond", "default:apple", "default:diamond"}
	}
})

minetest.register_craft({
	output = "potions:harming",
	recipe = {
		{"default:dry_grass_1", "bucket:bucket_lava", "default:dry_grass_1"},
		{"bucket:bucket_lava", "vessels:glass_bottle", "bucket:bucket_lava"},
		{"default:dry_grass_1", "bucket:bucket_lava", "default:dry_grass_1"}
	}
})

minetest.register_craft({
	output = "potions:poison",
	recipe = {
		{"default:clay_lump", "default:cactus", "default:clay_lump"},
		{"default:cactus", "vessels:glass_bottle", "default:cactus"},
		{"default:clay_lump", "default:cactus", "default:clay_lump"}
	}
})

minetest.register_craft({
	output = "potions:slowness",
	recipe = {
		{"flowers:geranium", "default:junglesapling", "flowers:geranium"},
		{"default:junglesapling", "vessels:glass_bottle", "default:junglesapling"},
		{"flowers:geranium", "default:junglesapling", "flowers:geranium"}
	}
})

minetest.register_craft({
	output = "potions:swiftness",
	recipe = {
		{"default:papyrus", "default:snow", "default:papyrus"},
		{"default:snow", "vessels:glass_bottle", "default:snow"},
		{"default:papyrus", "default:snow", "default:papyrus"}
	}
})

minetest.register_craft({
	output = "potions:leaping",
	recipe = {
		{"flowers:mushroom_brown", "flowers:mushroom_red", "flowers:mushroom_brown"},
		{"flowers:mushroom_red", "vessels:glass_bottle", "flowers:mushroom_red"},
		{"flowers:mushroom_brown", "flowers:mushroom_red", "flowers:mushroom_brown"}
	}
})

minetest.register_craft({
	output = "potions:healing",
	recipe = {
		{"flowers:mushroom_brown", "potions:harming", "default:papyrus"},

	}
})

minetest.register_craft({
	output = "potions:slow_falling",
	recipe = {
		{"default:papyrus", "default:clay_brick", "default:papyrus"},
		{"default:clay_brick", "vessels:glass_bottle", "default:clay_brick"},
		{"default:papyrus", "default:clay_brick", "default:papyrus"}
	}
})

minetest.register_craft({
	output = "potions:invisibility",
	recipe = {
		{"default:diamondblock", "default:mese_crystal", "default:diamondblock"},
		{"default:mese_crystal", "vessels:glass_bottle", "default:mese_crystal"},
		{"default:diamondblock", "default:mese_crystal", "default:diamondblock"}
	}
})

minetest.register_craft({
	output = "potions:regeneration_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:regeneration"}
	}
})

minetest.register_craft({
	output = "potions:harming_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:harming"}
	}
})

minetest.register_craft({
	output = "potions:poison_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:poison"}
	}
})

minetest.register_craft({
	output = "potions:slowness_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:slowness"}
	}
})

minetest.register_craft({
	output = "potions:swiftness_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:swiftness"}
	}
})

minetest.register_craft({
	output = "potions:leaping_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:leaping"}
	}
})

minetest.register_craft({
	output = "potions:slow_falling_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:slow_falling"}
	}
})

minetest.register_craft({
	output = "potions:invisibility_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:invisibility"}
	}
})

minetest.register_craft({
	output = "potions:healing_splash",
	recipe = {
		{"default:coal_lump"},
		{"potions:healing"}
	}
})

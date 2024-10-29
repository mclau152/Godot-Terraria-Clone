extends Node2D

@onready var tilemap: TileMapLayer = $TileMapLayer  # Adjust the path to your TileMap node
const MAP_WIDTH = 100  # Adjust size as needed
const MAP_HEIGHT = 50
const SURFACE_HEIGHT = 25  # Base surface level
const NOISE_SCALE = 20.0  # Adjust for more/less variation

func _ready() -> void:
	generate_terrain()

func generate_terrain() -> void:
	# Create noise for terrain generation
	var noise = FastNoiseLite.new()
	noise.seed = randi()  # Random seed, you can set a specific one if you want
	noise.frequency = 0.05
	
	# Generate the terrain
	for x in range(MAP_WIDTH):
		# Calculate surface height using noise
		var surface = SURFACE_HEIGHT + int(noise.get_noise_1d(x * NOISE_SCALE) * 5.0)
		
		# Fill the terrain
		for y in range(MAP_HEIGHT):
			var tile_pos = Vector2i(x, y)
			
			# If we're at or below the surface, place tiles
			if y >= surface:
				# Place dirt underground
				tilemap.set_cell(0, tile_pos, 0, Vector2i(0, 0))  # Replace 0 with your dirt tile ID
			elif y == surface - 1:
				# Place grass on the surface
				tilemap.set_cell(0, tile_pos, 0, Vector2i(1, 0))  # Replace 1 with your grass tile ID

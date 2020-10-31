# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



paintings_sub = [
{name: "Abstract Paintings", description: "", minorcategories_attributes: [
    {name: "Geometric Paintings"}, 
    {name: "Modern Art"}, 
    {name: "Contemporary Art"},
    {name: "Trendy Abstract Art"}
]},
{name: "Portrait Paintings", description: "",minorcategories_attributes:[
    {name: "Lady Paintings"}, 
    {name: "African Paintings"}, 
    {name: "Couple Paintings"},
    {name: "Children Paintings"},
    {name: "Hyper Realistic Paintings"}
]},
{name: "Indian Paintings", description: "", minorcategories_attributes: [
    {name: "Folk Paintings"}, 
    {name: "Tribal Paintings"}, 
    {name: "Temple Paintings"}, 
    {name: "Monument Paintings"},
    {name: "Cityscape Paintings"},
    {name: "Rajasthani Paintings"},
    {name: "Village Paintings"}, 
    {name: "Traditional Art"}, 
    {name: "Madhubani Paintings"},
    {name: "Warli Art"},
    {name: "Gond Art"}
]},
{name: "Still Life  Paintings", description: "", minorcategories_attributes: [
    {name: "Music Instruments Paintings"},
    {name: "Object Paintings"}
]},
{name: "Landscape Paintings", description: "", minorcategories_attributes:[
    {name: "Nature Paintings"}, 
    {name: "Flower Paintings"}, 
    {name: "Seascape Paintings"}, 
    {name: "Ship Paintings"},
    {name: "Building Paintings"},
    {name: "Transportation Paintings"}
]},
{name: "Animal,Birds Paintings", description: "", minorcategories_attributes:[
    {name: "Running Horse Paintings"}, 
    {name: "Dog, Cat Paintings"}, 
    {name: "Animals Paintings"}, 
    {name: "Birds Paintings"},
    {name: "Peacock Paintings"}
]},
{name: "Animal,Birds Paintings", description: "", minorcategories_attributes:[
    {name: "Running Horse Paintings"}, 
    {name: "Dog, Cat Paintings"}, 
    {name: "Animals Paintings"}, 
    {name: "Birds Paintings"},
    {name: "Peacock Paintings"}
]},
{name: "Style Paintings", description: "", minorcategories_attributes:[
    {name: "Impressionistic"}, 
    {name: "Futuristic"}, 
    {name: "Abstract"}, 
    {name: "Decorative"},
    {name: "Minimalistic"},
    {name: "Realistic"}, 
    {name: "Conceptual"}, 
    {name: "Contemporary"}, 
    {name: "Pop Art"},
    {name: "Expressionistic"},
    {name: "Cubism"},
    {name: "Illustration"}

]},
{name: "Medium", description: "", minorcategories_attributes:[
    {name: "Acrylic"}, 
    {name: "Oil"}, 
    {name: "Watercolor"}, 
    {name: "Mixed Media"},
    {name: "Charcoal"}
]},
{name: "Surface", description: "", minorcategories_attributes:[
    {name: "Chanson paper"}, 
    {name: "Canvas"}, 
    {name: "Canvas board"}, 
    {name: "Drawing paper"},
    {name: "Fabiano paper"},
    {name: "Handmade paper"},
    {name: "Thick paper"}
]}
]
sculptures_sub = [name: "Materials", minorcategories_attributes: [
    {name: "Stone Sculpture"}, 
    {name: "Jade Sculpture"}, 
    {name: "Wood Sculpture"}, 
    {name: "Bronze Sculpture"},
    {name: "Clay Sculpture"},
    {name: "Digital sculpting"},
    {name: "Environmental sculpture"},
    {name: "Garden sculpture"}, 
    {name: "Light sculpture"}, 
    {name: "Miniature model"}
]
]
handcrafts_sub = [{name: "Textiles", minorcategories_attributes: [
    {name: "Appliqué"},
    {name: "Crocheting"}, 
    {name: "Embroidery"}, 
    {name: "Felt-making"},
    {name: "Knitting"},
    {name: "Lace-making"},
    {name: "Macramé"}, 
    {name: "Quilting"},
    {name: "Tapestry art"},
    {name: "Weaving"}
]},
    {name: "Woodcraft"},
    {name: "Papercraft"}, 
    {name: "Pottery"},
    {name: "Glass Crafts"},
    {name: "Jewelry"}
]

posters_sub = [
    {name: "Infomercial"},
    {name: "Formative"},
    {name: "Show"}, 
    {name: "Political"},
    {name: "Corporate"},
    {name: "Campaign"},
    {name: "Fashion"},
    {name: "Subject"}
]

photography_path = [
    {name: "Portrait Photography"},
    {name: "Product Photography"},
    {name: "Fine Art Photography"},
    {name: "Fashion Photography"},
    {name: "Architectural Photography"},
    {name: "Photojournalism"},
    {name: "Sports Photography"},
    {name: "Aerial Photography"}
]

custom_arts_path = [
    {name: "Portraits"},
    {name: "Posters"},
    {name: "Stickers"},
    {name: "Caricature"},
    {name: "Digital illustrations"},
]

CATEGORIES = [
    { name: 'Paintings', description: "Paintings", subcategories_attributes: paintings_sub },
    { name: 'Sculptures', description: "Sculptures", subcategories_attributes: sculptures_sub},
    { name: 'Handcrafts', description: "Handcrafts", subcategories_attributes: handcrafts_sub},
    { name: 'Posters', description: "Posters", subcategories_attributes: posters_sub},
    { name: 'Photography', description: "Photographs", subcategories_attributes: photography_path},
    { name: 'Cutstom Arts', description: "Cutstom Arts", subcategories_attributes: custom_arts_path}
]

CATEGORIES.each do |category|
    Category.create(category)
end
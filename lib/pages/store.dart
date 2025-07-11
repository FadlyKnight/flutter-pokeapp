import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

// Widget Flutter (State: Stateless)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon Shop',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}

// Widget Flutter (State: Stateful)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  // Add a state variable to store the selected category
  Map _selectedData = {
    'name': 'Raichu',
    'price': 'Rp 500.000',
    'imageUrl':
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png',
    'rating': '4.8',
    'type': 'Listrik',
    'description':
        'Raichu adalah Pokémon listrik cepat dengan serangan petir yang mematikan.',
  }; // init base data

  // Controller untuk EditText/TextField
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String text) {
    setState(() {
      _searchQuery = text;
    });
    print('Searching for: $_searchQuery');
  }

  // Add a method to update the selected category
  void _updateSelectedCategory(Map selectedCategory) {
    setState(() {
      _selectedData = selectedCategory;
    });
    print('Selected category: $_selectedData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Widget Flutter (Layout: Column)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widget Flutter (Basic: EditText/TextField)
              TextField(
                controller: _searchController,
                onChanged: _updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Cari Pokemon favoritmu...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),

              // Banner Promo (Container)
              // Widget Flutter (Scaffold: Container)
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red[300],
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://media-hosting.imagekit.io/1b5d57a4229644fa/pokemon-banner.jpg?Expires=1840987701&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=eGWEfgC63Quglf8BUGA8Ek7Nqs2VZH5h1f4PLDNxwj3jw7RycVBIuypad3VUg4NAAkSI3TWMQy8zkAn8XEwdqyuOEjpePEtS1ArHS1rSg9PdIbSSx6RgApbOl9SHlQ28HV56R4QunpSFXISd62k4kI1w~aRrw6~qpThdJW3DjXqv2tT0-20rEbMF6gK9pux8vKZdzh4mhKlGCcejUVnreKs~pfbLBT~g~SKGs8sidRTBXPNsGQDdnxdD4Ps1pFRXjSi6Tj4E62bPynT5m6nstv4XOHJgN80gKFeJ1Dob3u9Qk8Znq3HdU-wPQTj-DeepDe2TyEt54wR9OvE-xf4Ttg__',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kategori Pokemon
              // Widget Flutter (Basic: Text)
              const Text(
                'Kategori Pokemon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Widget Flutter (Layout: Row in ListView)
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PokemonCategory(
                      icon: Icons.local_fire_department,
                      color: Colors.redAccent,
                      text: 'Api',
                      type: 'fire',
                      onCategorySelected: _updateSelectedCategory,
                    ),
                    PokemonCategory(
                      icon: Icons.water_drop,
                      color: Colors.blueAccent,
                      text: 'Air',
                      type: 'water',
                      onCategorySelected: _updateSelectedCategory,
                    ),
                    PokemonCategory(
                      icon: Icons.bolt,
                      color: Colors.yellowAccent,
                      text: 'Listrik',
                      type: 'electric',
                      onCategorySelected: _updateSelectedCategory,
                    ),
                    PokemonCategory(
                      icon: Icons.grass,
                      color: Colors.greenAccent,
                      text: 'Rumput',
                      type: 'grass',
                      onCategorySelected: _updateSelectedCategory,
                    ),
                    PokemonCategory(
                      icon: Icons.psychology,
                      color: Colors.purpleAccent,
                      text: 'Psikis',
                      type: 'psychic',
                      onCategorySelected: _updateSelectedCategory,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Featured Pokemon - Contoh StatefulWidget lain
              const Text(
                'Pokemon Langka',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Pass the selected category to FeaturedPokemon
              FeaturedPokemon(selectedData: _selectedData),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Flutter (State: Stateful)
class PokemonCategory extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String? type;
  // Add callback function to pass the selected category back
  final Function(Map) onCategorySelected;

  const PokemonCategory({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    this.type,
    required this.onCategorySelected,
  });

  @override
  State<PokemonCategory> createState() => _PokemonCategoryState();
}

// Contoh StatelessWidget
class _PokemonCategoryState extends State<PokemonCategory> {
  Map _category = {}; // Kategori Pokemon yang dipilih

  // List data Pokemon dengan Key category
  Map pokemonData = {
    'electric': {
      'name': 'Raichu',
      'price': 'Rp 500.000',
      'imageUrl':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png',
      'rating': '4.8',
      'type': 'Listrik',
      'description':
          'Raichu adalah Pokémon listrik cepat dengan serangan petir yang mematikan.',
    },
    'fire': {
      'name': 'Charizard',
      'price': 'Rp 2.000.000',
      'imageUrl':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png',
      'rating': '4.9',
      'type': 'Api',
      'description':
          'Charizard adalah naga api yang kuat, bisa terbang dan menyemburkan api panas.',
    },
    'grass': {
      'name': 'Bulbasaur',
      'price': 'Rp 800.000',
      'imageUrl':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
      'rating': '4.2',
      'type': 'Rumput',
      'description':
          'Bulbasaur adalah Pokémon tanaman yang lucu dan bisa menyerap energi matahari.',
    },
    'water': {
      'name': 'Blastoise',
      'price': 'Rp 900.000',
      'imageUrl':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png',
      'rating': '4.3',
      'type': 'Air',
      'description':
          'Blastoise punya meriam air di punggungnya dan serangan air yang dahsyat.',
    },
    'psychic': {
      'name': 'Mewtwo',
      'price': 'Rp 1.500.000',
      'imageUrl':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png',
      'rating': '5.0',
      'type': 'Psikis',
      'description':
          'Mewtwo adalah Pokémon psikis super kuat hasil eksperimen genetik.',
    },
  };

  // Method untuk memperbarui kategori Pokemon yang dipilih
  void _updateKategori(String? type) {
    setState(() {
      _category = pokemonData[type];
    });
    // Call the callback function to pass the selected category to parent
    widget.onCategorySelected(_category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => _updateKategori(widget.type!),
              iconSize: 50,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: Icon(widget.icon, color: widget.color, size: 40),
            ),
          ),

          const SizedBox(height: 8),
          Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Contoh StatelessWidget dengan Basic Widgets
class PokemonItem extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  final String rating;
  final String type;

  const PokemonItem({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, //
        children: [
          // Widget Flutter (Basic: Image)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  type,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 3),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    // Widget Flutter (Basic: Button - IconButton)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name ditambahkan ke keranjang'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Contoh StatefulWidget lain - Featured Pokemon dengan counter
class FeaturedPokemon extends StatefulWidget {
  // Add parameter to receive selected category
  final Map selectedData;

  const FeaturedPokemon({super.key, required this.selectedData});

  @override
  State<FeaturedPokemon> createState() => _FeaturedPokemonState();
}

class _FeaturedPokemonState extends State<FeaturedPokemon> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Flutter (Layout: Row)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widget Flutter (Basic: Image)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.selectedData['imageUrl'],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Widget Flutter (Basic: Text)
                    Text(
                      widget.selectedData['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Display category when selected
                    Text(
                      widget.selectedData['type'],
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.selectedData['price'],
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.selectedData['rating'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            widget.selectedData['description'],
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          // Display the selected category
          widget.selectedData.isNotEmpty
              ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Kategori Terpilih: ${widget.selectedData['type']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              : const SizedBox(),
          // Widget Kuantitas
          Row(
            children: [
              const Text(
                'Jumlah:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 15),
              // Widget Flutter (Basic: Button - IconButton)
              IconButton(
                onPressed: _decrementQuantity,
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.remove, size: 16),
                ),
              ),
              Text(
                '$_quantity',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _incrementQuantity,
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.add, size: 16, color: Colors.red[700]),
                ),
              ),
              const Spacer(),
              // Widget Flutter (Basic: Button - ElevatedButton)
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.selectedData['name']} ($_quantity) ditambahkan ke keranjang',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Beli',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

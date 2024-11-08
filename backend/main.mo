import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
    public type Phone = {
        id: Nat;
        name: Text;
        brand: Text;
        price: Nat;
        description: Text;
        imageUrl: Text;
        specs: Text;
        storage: Text;
        color: Text;
    };

    private stable var nextId : Nat = 0;
    private stable var phoneEntries : [(Nat, Phone)] = [];
    private var phones = HashMap.HashMap<Nat, Phone>(0, Nat.equal, Hash.hash);

    system func preupgrade() {
        phoneEntries := Iter.toArray(phones.entries());
    };

    system func postupgrade() {
        phones := HashMap.fromIter<Nat, Phone>(phoneEntries.vals(), 1, Nat.equal, Hash.hash);
        
        if (phones.size() == 0) {
            // Modern Phones
            addPhone(
                "iPhone 15 Pro Max",
                "Apple",
                1199,
                "Latest flagship with A17 Pro chip",
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg",
                "A17 Pro chip, 48MP camera",
                "256GB",
                "Natural Titanium"
            );
            addPhone(
                "Samsung Galaxy S24 Ultra",
                "Samsung",
                1299,
                "Premium Android flagship with S Pen",
                "https://image-us.samsung.com/us/smartphones/galaxy-s24-ultra/images/galaxy-s24-ultra-highlights-color-titanium-gray-mo.jpg",
                "Snapdragon 8 Gen 3, 200MP camera",
                "512GB",
                "Titanium Gray"
            );
            addPhone(
                "Google Pixel 8 Pro",
                "Google",
                999,
                "Advanced AI photography capabilities",
                "https://lh3.googleusercontent.com/PB5YJQQoZOTCGQjvwkRoHpTHLdXrQe9qhLxGxAgWy5vKhvyVvC8VHYJc8CszoTyPHFX5FMiHJKoXmxZRgPEF-Kj0GNZ9YJv9XQ=rw-e365-w1440",
                "Google Tensor G3, 50MP main camera",
                "128GB",
                "Porcelain"
            );
            addPhone(
                "OnePlus 12",
                "OnePlus",
                799,
                "Fast charging flagship killer",
                "https://image01.oneplus.net/ebp/202401/19/1-m00-51-68-ckvxbn-pnwaacxlaaa_qf0qjqu263.png",
                "Snapdragon 8 Gen 3, 100W charging",
                "256GB",
                "Flowy Emerald"
            );
            addPhone(
                "iPhone 15",
                "Apple",
                799,
                "Dynamic Island, USB-C",
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-pink?wid=5120&hei=2880&fmt=p-jpg",
                "A16 Bionic, 48MP camera",
                "128GB",
                "Pink"
            );
            // Classic Phones
            addPhone(
                "Nokia 3310",
                "Nokia",
                59,
                "The indestructible legend returns",
                "https://upload.wikimedia.org/wikipedia/commons/3/31/Nokia_3310_blue.jpg",
                "Snake II included, Month-long battery",
                "16MB",
                "Navy Blue"
            );
            addPhone(
                "Motorola RAZR V3",
                "Motorola",
                149,
                "Iconic flip phone of the 2000s",
                "https://upload.wikimedia.org/wikipedia/commons/f/f4/Motorola_RAZR_V3i_03.JPG",
                "Slim design, VGA camera",
                "5MB",
                "Silver"
            );
        };
    };

    private func addPhone(name: Text, brand: Text, price: Nat, description: Text, imageUrl: Text, specs: Text, storage: Text, color: Text) {
        let phone: Phone = {
            id = nextId;
            name = name;
            brand = brand;
            price = price;
            description = description;
            imageUrl = imageUrl;
            specs = specs;
            storage = storage;
            color = color;
        };
        phones.put(nextId, phone);
        nextId += 1;
    };

    public query func getAllPhones() : async [Phone] {
        Iter.toArray(phones.vals())
    };

    public query func getPhone(id: Nat) : async ?Phone {
        phones.get(id)
    };
}

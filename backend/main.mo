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
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-max-black-titanium-select?wid=940&hei=1112&fmt=png-alpha",
                "A17 Pro chip, 48MP camera",
                "256GB",
                "Natural Titanium"
            );
            addPhone(
                "Samsung Galaxy S24 Ultra",
                "Samsung",
                1299,
                "Premium Android flagship with S Pen",
                "https://images.samsung.com/is/image/samsung/p6pim/uk/2401/gallery/uk-galaxy-s24-ultra-s928-sm-s928bzggeub-thumb-537234069",
                "Snapdragon 8 Gen 3, 200MP camera",
                "512GB",
                "Titanium Gray"
            );
            addPhone(
                "Google Pixel 8 Pro",
                "Google",
                999,
                "Advanced AI photography capabilities",
                "https://lh3.googleusercontent.com/K98KHE-1_0XWTYrWWpAaYsCOu_YXoQY6tX9CkLqnqDuE-hnGrWAGXOVRMlhThpVhYSBWQAGkVyHKhEVyoVHKQQHPJfA_ZQs=rw-e365-w1440",
                "Google Tensor G3, 50MP main camera",
                "128GB",
                "Porcelain"
            );
            addPhone(
                "iPhone 15",
                "Apple",
                799,
                "Dynamic Island, USB-C",
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pink-select-202309?wid=940&hei=1112&fmt=png-alpha",
                "A16 Bionic, 48MP camera",
                "128GB",
                "Pink"
            );
            addPhone(
                "Samsung Galaxy Z Fold 5",
                "Samsung",
                1799,
                "Foldable flagship with S Pen support",
                "https://images.samsung.com/is/image/samsung/p6pim/uk/2307/gallery/uk-galaxy-z-fold5-f946-sm-f946bzaaeub-thumb-537212069",
                "7.6\" Main Display, Snapdragon 8 Gen 2",
                "256GB",
                "Cream"
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
            // Classic Phones
            addPhone(
                "Nokia 3310",
                "Nokia",
                59,
                "The indestructible legend returns",
                "https://images.ctfassets.net/wcfotm6rrl7u/6eeA6QsS8WoE8YcuOYqiWA/e20b3526ee1ad38c76c9f9a788ced006/nokia_3310-blue-int.png",
                "Snake II included, Month-long battery",
                "16MB",
                "Navy Blue"
            );
            addPhone(
                "Motorola RAZR V3",
                "Motorola",
                149,
                "Iconic flip phone of the 2000s",
                "https://motorolarazr.com/wp-content/uploads/2020/02/motorola-razr-v3-pink.png",
                "Slim design, VGA camera",
                "5MB",
                "Pink"
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

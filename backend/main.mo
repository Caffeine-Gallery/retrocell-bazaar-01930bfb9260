import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
    // Phone type definition
    public type Phone = {
        id: Nat;
        name: Text;
        brand: Text;
        price: Nat;
        description: Text;
        imageUrl: Text;
    };

    private stable var nextId : Nat = 0;
    private stable var phoneEntries : [(Nat, Phone)] = [];
    private var phones = HashMap.HashMap<Nat, Phone>(0, Nat.equal, Hash.hash);

    // Initialize with some phones
    system func preupgrade() {
        phoneEntries := Iter.toArray(phones.entries());
    };

    system func postupgrade() {
        phones := HashMap.fromIter<Nat, Phone>(phoneEntries.vals(), 1, Nat.equal, Hash.hash);
        
        if (phones.size() == 0) {
            addPhone("iPhone 3G", "Apple", 199, "The revolutionary phone that changed everything", "https://upload.wikimedia.org/wikipedia/commons/a/ad/IPhone_3G.jpg");
            addPhone("Motorola RAZR V3", "Motorola", 299, "Iconic flip phone of the 2000s", "https://upload.wikimedia.org/wikipedia/commons/f/f4/Motorola_RAZR_V3i_03.JPG");
            addPhone("Nokia 3310", "Nokia", 99, "Indestructible classic with Snake game", "https://upload.wikimedia.org/wikipedia/commons/3/31/Nokia_3310_blue.jpg");
            addPhone("BlackBerry Bold", "BlackBerry", 299, "Business phone with QWERTY keyboard", "https://upload.wikimedia.org/wikipedia/commons/9/99/BlackBerry_Bold_9000.jpg");
            addPhone("Sony Ericsson W800", "Sony", 249, "Walkman phone for music lovers", "https://upload.wikimedia.org/wikipedia/commons/8/8e/Sony-Ericsson-W800i-KuchenBild.jpg");
        };
    };

    private func addPhone(name: Text, brand: Text, price: Nat, description: Text, imageUrl: Text) {
        let phone: Phone = {
            id = nextId;
            name = name;
            brand = brand;
            price = price;
            description = description;
            imageUrl = imageUrl;
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
